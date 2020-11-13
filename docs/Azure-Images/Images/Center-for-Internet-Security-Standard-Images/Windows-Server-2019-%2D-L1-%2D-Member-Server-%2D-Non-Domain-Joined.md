[[_TOC_]]

---

# Windows Server 2019 - CIS Hardening - L1 - Member Server - Non-Domain Joined

## Getting Started

### Dependancies

#### Tooling (local)

To run this locally, you shall require the following tools:

* Packer v1.6.0 or above
* Azure CLI v2

#### Storage Account with Assessor CLI uploaded

The CIS Assessor CLI is not permitted to be served on a publicly assessible endpoint.

To work around this, there is a release pipeline to upload the tools from this repo to a storage account:

<https://dev.azure.com/soltecrdg/Azure%20Images/_release?view=all&_a=releases&definitionId=8>

This job will create a storage account, two containers named `tools` and `reports` respectively,
and upload the contents from `tools/` up to the `tools` container.

#### Setting the `storage_account_url` and `reports_storage_account_url` values (includes Azure DevOps)

You will need to make sure that the *storage account* has been created and that the *Assessor CLI* has been uploaded.

From here, it is important to retrive a *url* with a *SAS token* that will allow Packer to retrieve the *tools*, and upload the *reports* to the storage account.

You can do this in the portal by navigating to the storage account and creating Shared Access Signature:

![alt text](../img/sas.PNG)

You will ideally want to create a sas token with the minimum requirements such as read and
list for `storage_account_url` and create,write add and list for `reports_storage_account_url`.

Then, add the path so that it includes the container name in the url, otherwise the path to the blob folder will be incorrect.

Below are some examples of what they should eventually look like:

```env
storage_account_url = "https://nameofstorageaccount.blob.core.windows.net/tools/?st=sastokenwithreadlist"
reports_storage_account_url = "https://nameofstorageaccount.blob.core.windows.net/reports/?st=sastokenwithwritecreateaddandlist"
```

### Running Packer locally

*Please look at the [dependencies](/Azure-Images/Getting-Started) section before continuing.* 

Local command example:

```bash
packer build \
-var client_id=*** \
-var client_secret=*** \
-var subscription_id=*** \
-var tenant_id=*** \
-force \
-var destination_gallery_name=signame \
-var destination_image_name=Win2019CISL1 \
-var destination_image_version=<version> \
-var destination_resource_group_location=northeurope \
-var destination_resource_group_name=Packer-RG \
-var image_offer=WindowsServer \
-var image_publisher=MicrosoftWindowsServer \
-var image_sku=2019-Datacenter \
-var image_type=Windows \
var image_version=latest \
-var vm_size=Standard_D2_v2 \
-var storage_account_url=*** \
-var reports_storage_account_url=*** \
-on-error=abort \
-color=false \2
/home/vsts/work/r1/a/_AzureImages/windows-server-2019-CIS-L1/Win2019CISL1.json
```

## Installed Packages and Configuration

The following has been applied to the virtual machine before capturing the VM Image:

### CIS Hardening 

| Type      | Name                | 
|-----------|---------------------|
| Benchmark | Windows Server 2019 CIS Benchmark v1.1.0.1 |
| Profile   | L1 - Member Server  |

(Further information at `./config/cis-hardening/Server2019v1.1.0.1/Server2019v1.1.0/readme.docx`)

GPO's Applied:
* MS-L1 - GPO Applied using LGPO.exe
* USER-L1 - GPO Applied using LGPO.exe

#### **ALTERATIONS MADE**

None

## Contribute

Some of the best ways to contribute are to try things out, file issues, join in design conversations, and make pull-requests.
DM either Wes Jackson or Daniel Mabbett for further details.

To contribute, please create a ticket in the project and then a branch with the changes relating to the ticket.
