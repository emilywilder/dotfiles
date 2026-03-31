#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

import 'windows.env.just'

[private]
default:
    @just --list windows

# Install PowerShell PROFILE
[windows]
install:
    Copy-Item -Path {{POWERSHELL_CONFIG_PATH}} -Destination {{POWERSHELL_INSTALL_PATH}}

# Uninstall PowerShell PROFILE
[windows]
uninstall:
    Remove-Item -Path {{POWERSHELL_INSTALL_PATH}}
