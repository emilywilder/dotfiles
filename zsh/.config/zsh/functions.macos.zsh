attachiso() {
    hdiutil attach -imagekey diskimage-class=CRawDiskImage -nomount $1
}

dequarantine() {
    [ -n "$1" ] && find "$1" -type f -xattrname com.apple.quarantine -exec xattr -d com.apple.quarantine {} \; -print
}
