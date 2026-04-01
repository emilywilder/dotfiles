#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

[private]
default:
    @just --list system

# Run Windows OS configuration changes
[windows]
[confirm("This will run system wide configuration changes. Are you sure? (y/N)")]
setup: disable-hibernate

# Notes: https://forums.malwarebytes.com/topic/299350-disable-fast-startup/
# Disable hibernate and fast startup
[windows]
[group("settings")]
disable-hibernate:
    sudo powercfg.exe /hibernate off
