This is the tools directory for where you would place packages and applications that would be required for Image builds.

## FAQ

1) Why don't we just put this in the image directories under `config` and upload as a packer step?

The problem with this particularly with Windows is that WinRM uploads files and folders much slower than linux with ssh. 
It's so slow that it is actually not recommended. Instead it is better to use a http request to download the files. 

This directory is designed to be seperate to the `packer build` jobs, it acts as a place to: 
* keep a copy of the tooling 
* as a source to upload to azure blob storage

The best thing to do is to copy the tools in this directory to Azure Blob Storage and utilise azcopy to bring down the 
tools to your build VM.