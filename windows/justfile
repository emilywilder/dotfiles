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
install: profile-install pwsh-winget-client scoop::import winget::import

# Uninstall
[windows]
uninstall: profile-uninstall

# Install PowerShell PROFILE
[windows]
[group("profile")]
profile-install:
    Copy-Item -Path {{POWERSHELL_CONFIG_PATH}} -Destination {{POWERSHELL_INSTALL_PATH}}

# Uninstall PowerShell PROFILE
[windows]
[group("profile")]
profile-uninstall:
    Remove-Item -Path {{POWERSHELL_INSTALL_PATH}}

# install Microsoft.WinGet.Client powershell module
[windows]
[group("powershell")]
pwsh-winget-client:
    Install-Module -Scope CurrentUser Microsoft.WinGet.Client
