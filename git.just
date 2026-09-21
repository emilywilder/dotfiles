#!/usr/bin/env just --justfile

set shell := ["zsh", "-cu"]
set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]
set unstable # for which() and lists
set lists

# WSL switches
platform := if which('wslinfo') != [] { "wsl" } else { os() }
export GIT_SSH := if platform == "wsl" { "ssh.exe" } else { "ssh" }

git_local_config := "local.config"

[private]
default:
    @just --list git

# Add platform specific git config options.
[unix]
[working-directory: "git/.config/git"]
link-gitconfig:
    ln -sf {{platform}}.config {{git_local_config}}

# Add platform specific git config options.
[windows]
[working-directory: "git/.config/git"]
link-gitconfig:
    New-Item -ItemType HardLink -Path "{{git_local_config}}" -Value "{{platform}}.config"

# Remove localized git config options.
[working-directory: "git/.config/git"]
unlink-gitconfig:
    rm {{git_local_config}}

# Initialize submodules.
[group("repo")]
initialize-submodules:
    @git submodule update --init --recursive

# Update submodules.
[group("repo")]
update-submodules: initialize-submodules
    @git submodule update --remote --merge

# Do a sparse checkout of each submodule.
[unix]
[group("repo")]
sparse-checkout: update-submodules
    @git submodule foreach '$toplevel/sparse-checkout.sh'

# Checkout submodules on initial install.
[unix]
[private]
bootstrap:
    {{
        if path_exists(".git/modules") != "true"
        {
            "just git sparse-checkout"
        }
    }}

# Perform all necessary git operations for dotfiles to function.
[unix]
install: bootstrap link-gitconfig

# Perform all necessary git operations for dotfiles to function. WARNING: does not handle submodules!
[windows]
install: link-gitconfig

# Remove git specific configurations.
uninstall: unlink-gitconfig
