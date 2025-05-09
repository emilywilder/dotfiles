packsources() {
    if [ -n "$1" -a -n "$2" ]; then
        _sources_path="$1"
        _package_path="$2"
        if [ -d "$_sources_path" -a -d "$_package_path" ]; then
            _githash="$(git rev-parse master)"
            if ! git archive --verbose --format=tgz --output="${_package_path}/${_sources_path}-${_githash}.tgz" master $_sources_path; then
                return 1

            fi
        else
            echo "<$_sources_path> or <$_package_path> does not exist" >&2
            return 1
        fi
    else
        echo "usage: $FUNCNAME <sources path> <package path>" >&2
        return 1
    fi
}

gittree() {
    git log \
        --graph \
        --full-history \
        --all \
        --color \
        --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"
}