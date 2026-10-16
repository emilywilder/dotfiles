# Emily.Commands Module
# My custom command aliases and functions

# Removes a built-in alias so a function of the same name can take its place
# (aliases take precedence over functions during command lookup)
# [AI:Claude]
function Remove-BuiltinAlias([string]$Name) {
    Remove-Item -Path "alias:$Name" -Force -ErrorAction SilentlyContinue
    Remove-Alias -Name $Name -Scope Global -Force -ErrorAction SilentlyContinue
}

# ls
if (Get-Command eza -ErrorAction SilentlyContinue) {
    # eza

    # use eza for ls and show icons
    Remove-BuiltinAlias ls
    function ls { eza --icons=auto @args }

    # quick long list
    function l { ls -lhM --git @args }

    # long list of directories
    function lsd { l -D @args }

    # long list sorted by size
    function lss { l --sort=size --color-scale=size @args }

    # long list sorted by mtime
    function lst { l --sort=date --color-scale=age @args }
} else {
    # PowerShell approximations

    # quick long list
    Set-Alias -Name l -Value Get-ChildItem

    # long list of directories
    function lsd { Get-ChildItem -Directory @args }

    # long list sorted by size
    function lss { Get-ChildItem -File @args | Sort-Object Length }

}


Export-ModuleMember -Function * -Alias *
