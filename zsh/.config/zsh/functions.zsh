
python_ensurepip() {
    python -m ensurepip --default-pip --user
}

attachiso() {
    hdiutil attach -imagekey diskimage-class=CRawDiskImage -nomount $1
}

dequarantine() {
    [ -n "$1" ] && find "$1" -type f -xattrname com.apple.quarantine -exec xattr -d com.apple.quarantine {} \; -print
}

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

pip_updateall() {
    echo "Finding out of date packages in pip..."
    pip list -o --format json | jq '.[].name' -r | while read a ; do 
        echo "Installing $a..."
        pip install -U $a
    done
}

zebesmount() {
    if [ -n "$1" -a -n "$2" ]; then
        _remotepath="$1"
        _volname="$2"
        _mountpoint="/Volumes/${_volname}"
        _remotemountpoint="${_host}:${_remotepath}"
        _host="zebes"
        if [ -d "$_mountpoint" ]; then
            echo "Removing $_mountpoint..."
            rmdir "$_mountpoint"
        fi
        if sudo install -d -o $USER "$_mountpoint"; then
            sshfs "$_remotemountpoint" "$_mountpoint" -o volname="$_volname"
        fi
    else
        echo "usage: $FUNCNAME <mountpoint> <volname>" >&2
        return 1
    fi
}
