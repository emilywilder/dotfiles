# Emily.PowerShell.RunCommands Module
# Scope: $PROFILE.CurrentUserCurrentHost (Microsoft.PowerShell_profile.ps1), imported only if Test-InteractiveShell

# Environment → Profile → [RunCommands] → Login → Logout
# :: Configuration for interactive shells
# > PSReadLine settings

# History
$HistoryFile = Join-Path $env:XDG_STATE_HOME powershell history
$HistoryCount = 12000

# Ensure directory for HistoryFile exists
New-Item -ItemType Directory -Force -Path (Split-Path $HistoryFile) | Out-Null

# Set PSReadLine history options
Set-PSReadLineOption -HistorySavePath $HistoryFile -MaximumHistoryCount $HistoryCount
# commands to be appended to the history file, and new shells read history (SHARE_HISTORY)
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally

# don't cycle through options (NO_AUTO_MENU)
Set-PSReadLineKeyHandler -Key Tab -Function Complete
