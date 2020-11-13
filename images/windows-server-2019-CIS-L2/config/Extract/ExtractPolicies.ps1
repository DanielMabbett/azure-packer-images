$url = "https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/LGPO.zip"
$output = "$PSScriptRoot\LGPO.zip"
$start_time = Get-Date

Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Expand-Archive -LiteralPath $output -DestinationPath $PSScriptRoot -Verbose


# Extract 

cd C:\Extract

.\LGPO.exe /b C:\Extract

# # Remember to rename it to LGPO_Backup


.\LGPO.exe /parse /m C:\Extract\LGPO_Backup\DomainSysvol\GPO\Machine\registry.pol >> C:\Extract\lgpo.txt

# Once you have made your changes, you will need to build a new registry.pol file that you can use to import. Run this command:

.\LGPO.exe /r C:\Extract\lgpo.txt /w C:\Extract\registry_new.pol

# Next, import the settings to ensure the changes have taken effect (flip back the settings in gpedit.msc, run import, and then close/reopen gpedit.msc)

# LGPO.exe /m C:\Temp\registry_new.pol