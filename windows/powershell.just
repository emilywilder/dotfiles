#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

POWERSHELL_CONFIG_PATH := join( \
    justfile_directory(), \
    "powershell", \
    ".config", \
    "powershell", \
    "Microsoft.PowerShell_profile.ps1" \
)

[private]
default:
    @just --list powershell

# Install PowerShell config
[windows]
install: profile modules

# Install PowerShell PROFILE
[windows]
[group("powershell")]
profile:
    Copy-Item -Path {{POWERSHELL_CONFIG_PATH}} -Destination $PROFILE

#
# •───────•°•❀  modules  ❀•°•───────•
#

# PowerShell modules
[windows]
[private]
modules: mod-winget-client mod-dsc mod-psfzf

[windows]
[private]
install-module mod *options:
    Install-Module {{mod}} {{options}}

# install Microsoft.WinGet.Client powershell module
[windows]
[group("modules")]
mod-winget-client: (install-module "Microsoft.WinGet.Client" "-Scope CurrentUser")

# Source: https://learn.microsoft.com/en-us/powershell/dsc/reference/psdscresources/overview?view=dsc-2.0
# install PSDscResources powershell module
[windows]
[group("modules")]
mod-dsc: (install-module "PSDscResources")

# install PSFzf powershell module
[windows]
[group("modules")]
mod-psfzf: (install-module "PSFzf")
