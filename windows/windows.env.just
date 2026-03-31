POWERSHELL_CONFIG_PATH := join(justfile_directory(), "powershell", ".config", "powershell", "Microsoft.PowerShell_profile.ps1")
# env('PROFILE') doesn't work
POWERSHELL_INSTALL_PATH := '$PROFILE'
LOCALAPPDATA := env('LOCALAPPDATA', '')
WINDOWS_TERMINAL_CONFIG_PATH := join(justfile_directory(), 'windows-terminal', 'settings.json')
WINDOWS_TERMINAL_INSTALL_PATH := join(LOCALAPPDATA, 'Packages', 'Microsoft.WindowsTerminal_8wekyb3d8bbwe', 'LocalState', 'settings.json')
