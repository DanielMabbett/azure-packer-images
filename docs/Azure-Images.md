# Overview

Welcome to the Azure Images Wiki!

Here is the place to understand all about the Azure Images project and its components.

## Getting Started
If you are new to this project the best thing to do is to look at the Getting Started section.

### [Tools](/Azure-Images/Getting-Started/Tools)

First place that is best to start is firstly to learn about the tooling required for Azure Images to exist:

* Packer 
* Azure CLI

### [Azure Concepts](/Azure-Images/Getting-Started/Azure-Concepts)

Then it is next a good idea to understand basic concepts of Azure, such as: 

* Virtual Machines
* Storage Accounts
* Shared Image Gallery
* Image Definitions and Versions

### [Packer Pipeline Implementation](/Azure-Images/Getting-Started/Packer-Pipeline-Implementation)
**This is more specific to how packer and azure devops are set up for this project**

Above contains the link to understand how a packer pipeline works and understanding/ interpreting the `json` configuration file that Packer uses.



## Images

### [Center for Internet Security Standard Images](/Azure-Images/Images/Center-for-Internet-Security-Standard-Images)

These images are based on the CIS Standards for virtual machines, and provide a benchmark for security standards across Azure VMs.

- [Windows Server 2019   L1   Member Server   Non Domain Joined](/Azure-Images/Images/Center-for-Internet-Security-Standard-Images/Windows-Server-2019-%2D-L1-%2D-Member-Server-%2D-Non-Domain-Joined)

- [Windows Server 2019   L2   Member Server   Non Domain Joined](/Azure-Images/Images/Center-for-Internet-Security-Standard-Images/Windows-Server-2019-%2D-L2-%2D-Member-Server-%2D-Non-Domain-Joined)


## [How To's](/Azure-Images/How-To's)

Useful documentation for performing various tasks to be added here:

[How To Migrate Azure Images Client Side](/Azure-Images/How-To's/How-To-Migrate-Azure-Images-Client%2DSide)

[How to Change the target Azure Subscription for all pipelines](/Azure-Images/How-To's/How-to-Change-the-target-Azure-Subscription-for-all-pipelines)