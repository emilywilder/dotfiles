# Emily.PowerShell.Login Module
# Scope: $PROFILE.CurrentUserCurrentHost (Microsoft.PowerShell_profile.ps1), imported only if Test-InteractiveShell

# Environment → Profile → RunCommands → [Login] → Logout
# :: Configuration for interactive login shells
# > environment variables for applications that don't need their own module
#   and need to be interactive

# PAGER
# -F or --quit-if-one-screen
# -R or --RAW-CONTROL-CHARS
$env:LESS = '-FR'
