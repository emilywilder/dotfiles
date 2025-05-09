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
