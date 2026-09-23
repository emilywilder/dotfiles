function Set-Readline
{
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
}

if ( [Environment]::UserInteractive )
{
    Set-Readline
}
