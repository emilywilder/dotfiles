#!/usr/bin/env just --justfile

set shell := ["zsh", "-cu"]

set unstable # for which()
platform := if which('wslinfo') != "" { "wsl" } else { os() }
git_local_config := "local.config"

[private]
default:
    @just --list git

# Add platform specific git config options.
[unix]
[working-directory: "git/.config/git"]
unlink-gitconfig:
    rm {{git_local_config}}

# Remove localized git config options.
[unix]
[working-directory: "git/.config/git"]
link-gitconfig:
    ln -sf {{platform}}.config {{git_local_config}}
