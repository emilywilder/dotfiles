# Emily.PowerShell.Profile Module
# Scope: $PROFILE.CurrentUserAllHosts (profile.ps1), imported in every shell

# Environment → [Profile] → RunCommands → Login → Logout
# :: Configuration for login shells
# > path variables

$_path = @(
# home/bin
    Join-Path $HOME bin
# rust
    Join-Path $HOME .cargo bin
)

# macOS specific
if ($IsMacOS) {
    $_path += @(
    # MacPorts
        '/opt/local/bin'
        '/opt/local/sbin'
    # texlive
        '/Library/TeX/texbin'
    # JetBrains Toolbox
        Join-Path $HOME 'Library/Application Support/JetBrains/Toolbox/scripts'
    )
}

$_path = @(
# user specific paths
    $_path
# existing path without duplicates
    $env:PATH -split [IO.Path]::PathSeparator | Where-Object { $_ -notin $_path }
)

# export path for child processes
$env:PATH = $_path -join [IO.Path]::PathSeparator

Remove-Variable _path
