[[_TOC_]]

-----

# Virtual Machines

Azure Virtual Machines (VM) is one of several types of on-demand, scalable computing resources that Azure offers. Typically, you choose a VM when you need more control over the computing environment than the other choices offer. This article gives you information about what you should consider before you create a VM, how you create it, and how you manage it.

An Azure VM gives you the flexibility of virtualization without having to buy and maintain the physical hardware that runs it. However, you still need to maintain the VM by performing tasks, such as configuring, patching, and installing the software that runs on it.

https://docs.microsoft.com/en-us/azure/virtual-machines/windows/overview

# Storage Accounts

An Azure storage account contains all of your Azure Storage data objects: blobs, files, queues, tables, and disks. The storage account provides a unique namespace for your Azure Storage data that is accessible from anywhere in the world over HTTP or HTTPS. Data in your Azure storage account is durable and highly available, secure, and massively scalable.

https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview

# Shared Image Gallery

Shared Image Gallery is a service that helps you build structure and organization around your images. Shared Image Galleries provide:

Global replication of images.
Versioning and grouping of images for easier management.
Highly available images with Zone Redundant Storage (ZRS) accounts in regions that support Availability Zones. ZRS offers better resilience against zonal failures.
Premium storage support (Premium_LRS).
Sharing across subscriptions, and even between Active Directory (AD) tenants, using RBAC.
Scaling your deployments with image replicas in each region.
Using a Shared Image Gallery you can share your images to different users, service principals, or AD groups within your organization. Shared images can be replicated to multiple regions, for quicker scaling of your deployments.

An image is a copy of either a full VM (including any attached data disks) or just the OS disk, depending on how it is created. When you create a VM from the image, a copy of the VHDs in the image are used to create the disks for the new VM. The image remains in storage and can be used over and over again to create new VMs.

If you have a large number of images that you need to maintain, and would like to make them available throughout your company, you can use a Shared Image Gallery as a repository.

https://docs.microsoft.com/en-us/azure/virtual-machines/windows/shared-image-galleries

# Image Definitions and Versions


## Image definition	

Image definitions are created within a gallery and carry information about the image and requirements for using it internally. This includes whether the image is Windows or Linux, release notes, and minimum and maximum memory requirements. It is a definition of a type of image.

##Image version	

An image version is what you use to create a VM when using a gallery. You can have multiple versions of an image as needed for your environment. Like a managed image, when you use an image version to create a VM, the image version is used to create new disks for the VM. Image versions can be used multiple times.