ZSH_FUNCTIONS_BASEDIR=$0:h/functions
fpath+=($ZSH_FUNCTIONS_BASEDIR)

() {
    readonly supported_programs=(
        git
        nix
        python
    )

    readonly _functions_athena=(zebesmount)
    readonly _functions_git=(packsources gittree)
    readonly _functions_macos=(attachiso dequarantine)
    readonly _functions_nix=(nix-deps nix-get-pname nix-get-flake-outpaths)
    readonly _functions_python=(python_ensurepip pip_updateall)

    local _functions_to_load=()

    # check for OS specific functions
    case "${OSTYPE}" in
        darwin*)
            _functions_to_load+=(${(A)_functions_macos})
        ;;
    esac

    # check that these programs exist before loading their functions
    local _prog
    for _prog in $supported_programs; do
        if which ${_prog} >/dev/null; then
            # construct variable expansion necessary to reference the array
            # specific to the iterated program
            local _varname="\${(A)_functions_$_prog}"
            # use eval to dereference the constructed variable
            _functions_to_load+=($(eval echo $_varname))
        fi
    done

    # check for machine specific functions
    case "$(hostname -s)" in
        athena)
            _functions_to_load+=(${(A)_functions_athena})
        ;;
    esac

    # Load functions
    local _f
    for _f in ${ZSH_FUNCTIONS_BASEDIR}/${_functions_to_load}; do
        autoload ${_f}
    done
}