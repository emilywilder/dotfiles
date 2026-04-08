LOCALAPPDATA := env('LOCALAPPDATA', '')
WINDOWS_TERMINAL_CONFIG_PATH := join(justfile_directory(), 'windows-terminal', 'settings.json')
WINDOWS_TERMINAL_INSTALL_PATH := join(LOCALAPPDATA, 'Packages', 'Microsoft.WindowsTerminal_8wekyb3d8bbwe', 'LocalState', 'settings.json')
