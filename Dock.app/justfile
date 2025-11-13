#!/usr/bin/env just --justfile

set unstable
set shell := ["zsh", "-cu"]
set script-interpreter := ["zsh"]

DockShelvesPath := join("$HOME", "'Dock Shelves'")
SetFile := which("SetFile")

[private]
default:
    @just --list

[macos]
[script]
add:
    Shelves=() ; \ls Shelves | while read Shelf ; do Shelves+=($Shelf) ; done
    _restart="--no-restart"
    for Shelf in ${Shelves}; do
        \mkdir -p {{DockShelvesPath}}/${Shelf}
        \cp -TRv Shelves/${Shelf} {{DockShelvesPath}}/${Shelf}
        {{SetFile}} -a C {{DockShelvesPath}}/${Shelf}
        if [[ "$Shelf" == "${Shelves[-1]}" ]]; then _restart="--restart" ; fi
        \dockutil --add {{DockShelvesPath}}/${Shelf} --view grid --display folder --replacing ${Shelf} ${_restart}
    done

[macos]
[script]
remove:
    Shelves=() ; \ls Shelves | while read Shelf ; do Shelves+=($Shelf) ; done
    for Shelf in ${Shelves}; do
        if [[ "$Shelf" == "${Shelves[-1]}" ]]; then _restart="--restart" ; fi
        \dockutil --remove "${Shelf}" ${_restart}
    done
