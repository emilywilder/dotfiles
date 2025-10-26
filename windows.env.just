POWERSHELL_CONFIG_PATH := join(justfile_directory(), "powershell", ".config", "powershell", "Microsoft.PowerShell_profile.ps1")
# env('PROFILE') doesn't work
POWERSHELL_INSTALL_PATH := '$PROFILE'
