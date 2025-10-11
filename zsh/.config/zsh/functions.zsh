ZSH_FUNCTIONS_BASEDIR=$0:h/functions
fpath+=($ZSH_FUNCTIONS_BASEDIR)

supported_programs=(
    git
    nix
    python
)

_functions_athena=(zebesmount)
_functions_git=(packsources gittree)
_functions_macos=(attachiso dequarantine)
_functions_nix=(nix-deps nix-get-pname nix-get-flake-outpaths)
_functions_python=(python_ensurepip pip_updateall)

_functions_to_load=()

# check for OS specific functions
case "${OSTYPE}" in
    darwin*)
        _functions_to_load+=(${(A)_functions_macos})
    ;;
esac

# check that these programs exist before loading their functions
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
for _f in ${ZSH_FUNCTIONS_BASEDIR}/${_functions_to_load}; do
    autoload ${_f}
done