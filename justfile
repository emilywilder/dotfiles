#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

powershell_config_path := join(justfile_directory(), "powershell", ".config", "powershell")
powershell_profile := join(powershell_config_path, "Microsoft.PowerShell_profile.ps1")

[private]
default:
    @just --list

[unix]
[doc("stow packages to $HOME")]
install +FILES="*/":
    @stow --verbose --target="${HOME}" --restow {{FILES}}

[unix]
[doc("unstow packages from $HOME")]
uninstall +FILES="*/":
    @stow --verbose --target="${HOME}" --delete {{FILES}}

[windows]
[doc("Copy-Item <powershell_profile> to $PROFILE")]
install:
    Copy-Item -Path {{powershell_profile}} -Destination $PROFILE

[windows]
[doc("Remove-Item $PROFILE")]
uninstall:
    Remove-Item -Path $PROFILE
