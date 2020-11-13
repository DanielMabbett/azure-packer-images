[[_TOC_]]

-----

# Steps

## 1 - Copy the repository

Start by performing a `git clone`:

```bash
git clone https://soltecrdg@dev.azure.com/soltecrdg/Azure%20Images/_git/Azure%20Images
```

Create a new repository client side (can be git version control system, but recommend Azure DevOps) 

*Push* the repository to the new repository.

## 2 - Copy the pipelines

Go to `Pipelines` then `Releases`

Navigate to `Export`

![image.png](/.attachments/image-98887bd1-6e30-4b4f-b4bd-b2e6b93fce3b.png)

This will download a `json` file

Upload the json file to the new **Azure DevOps** project by going to `Pipelines` then `Releases` and then in the pipelines slide clicking `new` and `import release pipeline`

![image.png](/.attachments/image-c5b4f323-00f2-4e1f-b0e0-e63214ad80ff.png)

Do this for all the pipelines including:
* CIS Storage Account Dependency Creation
* Windows Server 2019 - CIS Hardened - L1
* Windows Server 2019 - CIS Hardened - L2

## 3 - Create a new service connection
Create a new service connection by clicking New service connection.

Select Azure Resource Manager and hit next.

Easiest option is to select service principal (automatic), this will use your azure devops account to automatically create a service principal, so make sure that you have owner permissions to that subscription.

Select the subscription, give the service connection name the title:

Deployment Subscription Service Connection

Include in the description the subscription id and the name of the connection.

Ensure that "Grant access permission to all pipelines" is enabled, or you will have to allow each one in the pipeline one-by-one!

You should see this:
![image.png](/.attachments/image-d2bf10de-339f-49ff-a39e-b93d2760aaf6.png)

## 4 - Edit the pipeline variables 

### 4a - Storage Account Creation for a place to put the CIS Tool

Start with the **CIS Storage Account Dependency Creation**

Click `edit`

![image.png](/.attachments/image-c1eed960-9e60-4562-8ec5-d4a02ec90f67.png)

Go to `variables` and update the variables to what the clients naming convention may be. 

Run this pipeline. 

### 4b - Grabbing a private endpoint for the `tools` and `reports` containers

Go to the storage account you have just created in *3a* in the portal.

Click on `Shared Access Signature`

![image.png](/.attachments/image-4ff69498-9b46-4a16-bbdd-d33ddd20270d.png)

Create a SAS token with the following properties: 
* Allowed Services: Blob only
* Allowed Resource Types: Container, Object
* Allowed Permissions: Read, Write, List, Add, Create, Process
* Expiry: Min 1 year expiration
* Allowed IP Addresses: Any
* Allowed Protocols: Basic

Grab the BLOB SERVICE SAS URL

IMPORTANT: **Make note of this sas token and save somewhere secure**

You will see this:
```
https://ablob.blob.core.windows.net/?sv=somesastoken
```

Set `reports_storage_account_url` to:

```
https://ablob.blob.core.windows.net/reports/?sv=somesastoken
```

Set `storage_account_url` to:

```
https://ablob.blob.core.windows.net/tools/?sv=somesastoken
```

Do this for **all CIS pipelines**.


### 4c - Set the remaining variables

Set the remaining variables in each pipeline to what the client asks for.

Click `edit`

![image.png](/.attachments/image-c1eed960-9e60-4562-8ec5-d4a02ec90f67.png)

Go to `variables` and update the variables to what the clients naming convention may be. 