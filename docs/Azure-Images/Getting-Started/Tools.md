[[_TOC_]]

-----

# Tools 
-----
## Packer 

### Overview
HashiCorp Packer (or just Packer) is an easy-to-use tool that automates the creation of any type of machine image. 

It embraces modern configuration management by encouraging you to use automated scripts to install and configure the software
within your Packer-made images. 

It promotes immutable architecture, that is, architecture that is ready-to-go and unchanging once running. Instead of configuring everything after the virtual machine is running in Azure, which takes up resources and time, (Imagine spinning up 100 servers and then having to configure them even with an automated tool) it works by "baking in" your configuration and installed packages, so its just a simple case of "spinning" up your servers and having them ready to go.

Some people would say its similar to SCCM Desktop Image Deployments. 

Hashicorp do a good job of explaining this further in their documentation:

https://www.packer.io/docs

### Installation

#### MacOS / Linux

The easiest way to install this would be using [homebrew](https://brew.sh/):

```bash
brew install packer
```

or you can download the package directly from [hashicorp](https://www.packer.io/downloads)

#### Windows

The easiest way to install this would be using [chocolatey](https://chocolatey.org/):

```powershell
choco install packer
```

or you can download the package directly from [hashicorp](https://www.packer.io/downloads)

-----

## Azure CLI


### Overview
While Azure CLI is not necessary to perform a packer build, it is used within the Azure DevOps pipelines, and can be useful for authentication.

Azure CLI stands for Azure Command Line Interface, it is one of the principle programmatic ways to interact with Azure.

https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest

### Installation

#### MacOS / Linux

The easiest way to install this would be using [homebrew](https://brew.sh/):

```bash
brew install az-cli
```

or you can download the package directly from [hashicorp](https://www.packer.io/downloads)

#### Windows

The easiest way to install this would be using [chocolatey](https://chocolatey.org/):

```powershell
choco install azure-cli
```

or you can download the package directly from [microsoft](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)