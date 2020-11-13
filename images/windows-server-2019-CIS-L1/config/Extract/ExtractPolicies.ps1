# Extract 

cd $PSScriptRoot

.\LGPO.exe /b $PSScriptRoot

# Remember to rename it to LGPO_Backup


.\LGPO.exe /parse /m C:\Extract\LGPO_Backup\DomainSysvol\GPO\Machine\registry.pol >> C:\Extract\lgpo.txt

# Once you have made your changes, you will need to build a new registry.pol file that you can use to import. Run this command:

.\LGPO.exe /r C:\Extract\lgpo.txt /w C:\Extract\registry_new.pol

# Next, import the settings to ensure the changes have taken effect (flip back the settings in gpedit.msc, run import, and then close/reopen gpedit.msc)

# LGPO.exe /m C:\Temp\registry_new.pol