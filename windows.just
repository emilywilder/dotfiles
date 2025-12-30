#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

import 'windows.env.just'

[private]
default:
    @just --list windows

[windows]
[doc("Install PowerShell PROFILE")]
install:
    Copy-Item -Path {{POWERSHELL_CONFIG_PATH}} -Destination {{POWERSHELL_INSTALL_PATH}}

[windows]
[doc("Uninstall PowerShell PROFILE")]
uninstall:
    Remove-Item -Path {{POWERSHELL_INSTALL_PATH}}
