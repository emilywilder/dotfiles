# Exit a shell with ^D
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

# Set tab completion to emulate ZSH
# Source: https://gist.github.com/MeganaD/fe3894b39697da767b8b19b3e0bc047b
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# Provide variables for WSL home directories
Set-Variable -Name "nixos_home" -Value "\\wsl.localhost\NixOS\home\$env:username"
