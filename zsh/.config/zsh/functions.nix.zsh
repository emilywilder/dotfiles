nix-deps() {
    if [ $# -eq 1 ]; then
        nix derivation show $1 |
            jq -r '.[].inputDrvs | keys.[] |
                match(".*?-(.*)\\.drv"; "g").captures[0].string'
    else
        echo "usage: ${funcstack[-1]} <packageName>" >&2
        return 1
    fi
}

nix-get-pname() {
    if [ $# -eq 1 ]; then
        nix derivation show $1 |
          jq '.[].env.pname'
    else
        echo "usage: ${funcstack[-1]} <installable>" >&2
        return 1
    fi
}

nix-get-flake-outpaths() {
    if [ $# -eq 1 ]; then
        local _dir
        if _dir="$(nix build "${1}" --print-out-paths --no-link)"; then
            find "$_dir"
        fi
    else
        echo "usage: ${funcstack[-1]} <nixpkgs#name>" >&2
        return 1
    fi
}