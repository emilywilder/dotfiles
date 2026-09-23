function Set-Readline() {
    ## Start with emacs readline (this includes ^D exit)
    Set-PSReadLineOption -EditMode Emacs

    ## Use arrow keys to move between words
    Set-PSReadlineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
    Set-PSReadlineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord
    Set-PSReadlineKeyHandler -Key Ctrl+a -Function BeginningOfLine
    Set-PSReadlineKeyHandler -Key Ctrl+e -Function EndOfLine

    ## Set tab completion to emulate ZSH
    ## Source: https://gist.github.com/MeganaD/fe3894b39697da767b8b19b3e0bc047b
    Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

    ## Put cursor at end of line for history selection
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
}

function Set-Hooks() {
    # OMP
    $config = "~/.config/omp/catppuccin_frappe.omp.json"
    oh-my-posh init pwsh --config "$config" | Invoke-Expression
}

if ( [Environment]::UserInteractive ) {
    Set-Readline
    Set-Hooks
}
