#!/usr/bin/env just --justfile

set shell := ["zsh", "-cu"]
set unstable # for which()

# WSL switches
platform := if which('wslinfo') != "" { "wsl" } else { os() }
export GIT_SSH :=  if platform == "wsl" { "ssh.exe" } else { "ssh" }

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

# Initialize submodules.
[group("repo")]
initialize-submodules:
    @git submodule update --init --recursive

# Update submodules.
[group("repo")]
update-submodules: initialize-submodules
    @git submodule update --remote --merge

# Do a sparse checkout of each submodule.
[group("repo")]
sparse-checkout: update-submodules
    @git submodule foreach '$toplevel/sparse-checkout.sh'
