python_ensurepip() {
    python -m ensurepip --default-pip --user
}

pip_updateall() {
    echo "Finding out of date packages in pip..."
    pip list -o --format json | jq '.[].name' -r | while read a ; do
        echo "Installing $a..."
        pip install -U $a
    done
}
