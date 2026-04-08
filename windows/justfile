#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

# Windows OS configuration
[group("modules")]
mod system
# Package management : scoop
[group("modules")]
mod scoop
# Package management : winget
[group("modules")]
mod winget
# PowerShell configuration
[group("modules")]
mod powershell

[private]
default:
    @just --list

# Install
[windows]
install: powershell::install scoop::import winget::install
