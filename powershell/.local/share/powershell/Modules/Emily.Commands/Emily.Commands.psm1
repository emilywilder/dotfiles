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

    # long list sorted by mtime
    function lst { Get-ChildItem -File @args | Sort-Object LastWriteTime }
}

# shorthand for nvim
if (Get-Command nvim -ErrorAction SilentlyContinue) { Set-Alias -Name vi -Value nvim }

# show paths in top-down format
function paths { $env:Path -split [IO.Path]::PathSeparator }

# use GNU diffutils for diff
if (Get-Command diff.exe -ErrorAction SilentlyContinue) {
    Remove-BuiltinAlias diff
    function diff { diff.exe -u --color @args }
}

# Formats Bytes with human readable prefixes
# [AI:Claude]
function Format-Size([long]$Bytes) {
    switch ($Bytes) {
        { $_ -ge 1TB } { '{0:N1} TB' -f ($_ / 1TB); break }
        { $_ -ge 1GB } { '{0:N1} GB' -f ($_ / 1GB); break }
        { $_ -ge 1MB } { '{0:N1} MB' -f ($_ / 1MB); break }
        { $_ -ge 1KB } { '{0:N1} KB' -f ($_ / 1KB); break }
        default        { "$_ B" }
    }
}

# disk usage of directory entries, sorted by size
# [AI:Claude] generated from `du -sh -- * | sort -h`
function dus {
    Get-ChildItem @args | ForEach-Object {
        $bytes = if ($_.PSIsContainer) {
            (Get-ChildItem $_ -Recurse -File -Force -ErrorAction SilentlyContinue |
                    Measure-Object Length -Sum).Sum
        } else { $_.Length }
        [pscustomobject]@{ Bytes = [long]$bytes; Name = $_.Name }
    } | Sort-Object Bytes |
            Select-Object @{ N = 'Size'; E = { Format-Size $_.Bytes } }, Name
}

Export-ModuleMember -Function * -Alias *
