[[_TOC_]]

-----

# Overview 

Packer is a tool that allows you to create Virtual Machine images.

This section shall focus on how these images are created in Azure DevOps pipelines.

## Structure and Location

### Repository 

A single repository sits under "repos". This contains all the base resources required to create the virtual machine image: 

* A directory for each image build
* The **json** files in each image directory which contains the information on how to *construct the image*
* A **config** folder in each image directory which contains:
  * The *local group policy* (settings) that will be applied to the image
  * The initial script to apply these group policy settings


### Packer Structure 

Packer works by using a **json** file that starts by a creating ephemeral Virtual Machine, it then provisions that Virtual Machine and finally creates an image which will be pushed to a Shared Image Gallery. So:

1. Create temporary virtual machine infrastructure
2. Provision that virtual machine (finishes with Sysprep)
3. Capture the image
4. Push the image to a Shared Image Gallery
5. Cleanup / Removal of the temporary virtual machine infrastructure

All packer json files in this repository follow this structure. Let's look closer at an example:

```json
{
    "variables": {
        "subscription_id": "{{env `ARM_SUBSCRIPTION_ID`}}",
        "client_id": "{{env `ARM_CLIENT_ID`}}",
        "client_secret": "{{env `ARM_CLIENT_SECRET`}}",
        "tenant_id": "{{env `ARM_TENANT_ID`}}",
        "image_publisher": "",
        "image_offer": "",
        "image_sku": "",
        "image_version": "",
        "destination_resource_group_name": "sharedImageGallery",
        "destination_image_name": "image",
        "destination_image_version": "version",
        "destination_replication_region": "northeurope",
        "destination_gallery_name": "sig001",
        "destination_resource_group_location": "northeurope",
        "helper_script_folder": "c:/buildartifacts",
        "vm_size": "Standard_D2_v2",
        "storage_account_url": "https://someblob.blob.core.windows.net/tools/Assessor-CLI-v4.0.21"
    },
    "builders": [
        {
            "type": "azure-arm",
            "subscription_id": "{{user `subscription_id`}}",
            "client_id": "{{user `client_id`}}",
            "client_secret": "{{user `client_secret`}}",
            "tenant_id": "{{user `tenant_id`}}",
            "managed_image_resource_group_name": "{{user `destination_resource_group_name`}}",
            "managed_image_name": "{{user `destination_image_name`}}",
            "os_type": "Windows",
            "image_publisher": "{{user `image_publisher`}}",
            "image_offer": "{{user `image_offer`}}",
            "image_sku": "{{user `image_sku`}}",
            "image_version": "{{user `image_version`}}",
            "communicator": "winrm",
            "winrm_use_ssl": "true",
            "winrm_insecure": "true",
            "winrm_timeout": "3m",
            "winrm_username": "packer",
            "location": "{{user `destination_resource_group_location`}}",
            "vm_size": "{{user `vm_size`}}",
            "shared_image_gallery_destination": {
                "resource_group": "{{user `destination_resource_group_name`}}",
                "gallery_name": "{{user `destination_gallery_name`}}",
                "image_name": "{{user `destination_image_name`}}",
                "image_version": "{{user `destination_image_version`}}",
                "replication_regions": [
                    "{{user `destination_replication_region`}}"
                ]
            }
        }
    ],
    "provisioners": [
        {
            "type": "file",
            "source": "{{ template_dir }}/config/",
            "destination": "{{user `helper_script_folder`}}"
        },
        {
            "type": "powershell",
            "inline": [
                "Set-ExecutionPolicy Bypass -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
            ]
        },
        {
            "type": "powershell",
            "inline": [
                "if( Test-Path $Env:SystemRoot\\windows\\system32\\Sysprep\\unattend.xml ){ rm $Env:SystemRoot\\windows\\system32\\Sysprep\\unattend.xml -Force}",
                "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm",
                "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
            ]
        }
    ]
}
```

* The top section in the **variables**, these are inputs that can be changed when you run `packer build` to influence the outcome. Usually these are the only thing that need to change per release. This example has many variables so that they can be configured in Azure DevOps rather than in the JSON file.
* You then have **builders**. These are settings for packer to know how to build the overall job. For example, `shared_image_gallery_destination` is a block of configuration that tells Packer to push the image to a shared image gallery for distribution after the virtual machine image capture is finished. This example contains many specific features for Windows VM building, such as `winrm` settings.
* Lastly you have **provisioners**, this is a procedural (from top to bottom) block of code that informs packer what to provision the virtual machine with. 
This is the most important part, as it is what makes the images unique from each other. This ecample pushes local config to the VM via winrm (do not do this with large folders or files as WinRM is slow compared to http), then installs chocolatey (a package manager) and then finally Sysprep's the machine ready for image capture.

### Image Specific Details 

There are many more details for each specific build in their respective `readme.md` files. 

## Azure DevOps Pipeline Structure

### Pipeline Setup

There is one Azure DevOps pipeline per Virtual Machine image, the structure of these is relatively simple: 
* One Job per pipeline named "build"
* 3 tasks per job, two are creating the **dependencies** (the resource group, shared image gallery, image definitions for the image to eventually end up at), and th final task is the `Packer build` command.

### Authentication 

Azure DevOps uses a **service principal** to authenticate with Azure, which is configured outside of the pipelines in a **service connection** in "Project Settings". 

The pipelines all use the same **service connection**: `Deployment Subscription Service Connection` so by changing that connection a user can change the target subscription.