ZSH_FUNCTIONS_BASEDIR=$0:h/functions
fpath+=($ZSH_FUNCTIONS_BASEDIR)

# find and set for autoload all appropriate functions
# this is done in an anonymous function to not pollute the shell namespace
() {
    readonly supported_programs=(
        git
        nix
        python
    )

    readonly functions_athena=(zebesmount bootstrap-nix)
    readonly functions_git=(packsources gittree jetbrains-get-gitignore)
    readonly functions_macos=(attachiso dequarantine plist2jq open)
    readonly functions_nix=(nix-deps nix-get-pname nix-get-flake-outpaths nix-search-names)
    readonly functions_python=(python_ensurepip pip_updateall)

    local functions_to_load=()

    # check for OS specific functions
    case "${OSTYPE}" in
        darwin*)
            functions_to_load+=(${(A)functions_macos})
        ;;
    esac

    # check that these programs exist before loading their functions
    local _program
    for _program in $supported_programs; do
        if which ${_program} >/dev/null; then
            # construct variable expansion necessary to reference the array
            # specific to the iterated program
            local _varname="\${(A)functions_$_program}"
            # use eval to dereference the constructed variable
            functions_to_load+=($(eval echo $_varname))
        fi
    done

    # check for machine specific functions
    case "$(hostname -s)" in
        athena)
            functions_to_load+=(${(A)functions_athena})
        ;;
    esac

    # Load functions
    local _function
    for _function in ${ZSH_FUNCTIONS_BASEDIR}/${functions_to_load}; do
        autoload ${_function}
    done
}
