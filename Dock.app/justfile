#!/usr/bin/env just --justfile

set unstable
set shell := ["zsh", "-cu"]
set script-interpreter := ["zsh"]

DockShelvesPath := join("$HOME", "'Dock Shelves'")
HM_ShelvesPath := join(DockShelvesPath, "'Home Manager'")
HM_AppsPath := join("$HOME", "Applications", "'Home Manager Apps'")

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

[macos]
[script]
populate-home-manager:
    if [[ -e {{HM_ShelvesPath}} && -e {{HM_AppsPath}} ]]; then
        find {{HM_ShelvesPath}} -maxdepth 1 -mindepth 1 -type l -delete
        for app in {{HM_AppsPath}}/* ; do
            print "Adding ${app:t}..."
            ln -s {{HM_AppsPath}}/${app:t} {{HM_ShelvesPath}}/${app:t}
        done
    fi
