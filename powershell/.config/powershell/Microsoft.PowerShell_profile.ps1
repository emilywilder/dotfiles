# Exit a shell with ^D
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

# Provide variables for WSL home directories
Set-Variable -Name "nixos_home" -Value "\\wsl.localhost\NixOS\home\$env:username"