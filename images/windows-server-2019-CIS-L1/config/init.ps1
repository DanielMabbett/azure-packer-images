Set-Location $PSScriptRoot/Extract

# import settings from one or more GPO backups under "path"
.\LGPO.exe /g "./LGPO_Backup"

# import settings from registry.pol into machine config
.\LGPO.exe /m ".\registry_new.pol"