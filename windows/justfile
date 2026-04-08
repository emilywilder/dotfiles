#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

import 'env.just'

# Windows OS configuration
[group("modules")]
mod system
# Package management : scoop
[group("modules")]
mod scoop
# Package management : winget
[group("modules")]
mod winget

[private]
default:
    @just --list

# Install
[windows]
install: profile-install pwsh-dsc pwsh-winget-client scoop::import winget::install

# Uninstall
[windows]
uninstall: profile-uninstall

# Install PowerShell PROFILE
[windows]
[group("profile")]
profile-install:
    Copy-Item -Path {{POWERSHELL_CONFIG_PATH}} -Destination $PROFILE

# Uninstall PowerShell PROFILE
[windows]
[group("profile")]
profile-uninstall:
    Remove-Item -Path $PROFILE

# install Microsoft.WinGet.Client powershell module
[windows]
[group("powershell")]
pwsh-winget-client:
    Install-Module -Scope CurrentUser Microsoft.WinGet.Client

# Source: https://learn.microsoft.com/en-us/powershell/dsc/reference/psdscresources/overview?view=dsc-2.0
# install PSDscResources powershell module
[windows]
[group("powershell")]
pwsh-dsc:
    Install-Module PSDscResources
