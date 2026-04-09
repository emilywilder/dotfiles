# Readline

## Start with emacs readline (this includes ^D exit)
Set-PSReadLineOption -EditMode Emacs

## Use arrow keys to move between words
Set-PSReadlineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
Set-PSReadlineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord

## Set tab completion to emulate ZSH
## Source: https://gist.github.com/MeganaD/fe3894b39697da767b8b19b3e0bc047b
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

## Put cursor at end of line for history selection
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# Variables

## Provide variables for WSL home directories
Set-Variable -Name "nixos_home" -Value "\\wsl.localhost\NixOS\home\$env:username"

# Hooks

## atuin
if ( Get-Command atuin )
{
    atuin init powershell | Out-String | Invoke-Expression
}

## fzf
if ( Get-InstalledModule -Name PSFzf )
{
    Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
    Set-PsFzfOption -TabCompletionPreviewWindow 'right|down|hidden'
}
