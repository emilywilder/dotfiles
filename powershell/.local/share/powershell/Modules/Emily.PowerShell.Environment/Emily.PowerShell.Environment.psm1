# Emily.PowerShell.Environment Module
# Scope: $PROFILE.CurrentUserAllHosts (profile.ps1), imported in every shell

# [Environment] → Profile → RunCommands → Login → Logout
# :: Configuration for all shells
# > XDG_* env vars
# > PAGER and EDITOR env vars

# XDG BDS: https://specifications.freedesktop.org/basedir-spec/latest/
# user-specific data files
$env:XDG_DATA_HOME = Join-Path $HOME .local share
# user-specific configuration files
$env:XDG_CONFIG_HOME = Join-Path $HOME .config
# user-specific state files
$env:XDG_STATE_HOME = Join-Path $HOME .local state
# user-specific non-essential data files
$env:XDG_CACHE_HOME = Join-Path $HOME .cache

# less is more
if (Get-Command less -ErrorAction SilentlyContinue) { $env:PAGER = 'less' }
# nvim, falling back to vim
if (Get-Command nvim -ErrorAction SilentlyContinue) { $env:EDITOR = 'nvim' }
elseif (Get-Command vim -ErrorAction SilentlyContinue) { $env:EDITOR = 'vim' }
