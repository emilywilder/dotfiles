#!/usr/bin/env zsh

# FIXME: capture output of git config and check against value
# FIXME: add --bool to git config

TRAPZERR() {
    if [[ "$pipestatus" -gt 0 ]]; then
        echo "Error encountered. Exiting."
        exit 1
    fi
}

config_file="${toplevel:?}/.gitmodules"
config_sparse="submodule.${name:?}.sparseCheckout"
config_branch="submodule.${name:?}.branch"
sparse_file_src="${toplevel:?}/${name:?}.sparse-checkout"
sparse_file_dest="${toplevel:?}/${GIT_DIR:?}/modules/${name:?}/info/sparse-checkout"

if git config --file $config_file --get $config_sparse; then
    echo "Sparse checkout enabled for submodule ${name:?}"
    git sparse-checkout set
    install -Cv $sparse_file_src $sparse_file_dest
else
    echo "Sparse checkout not enabled for submodule ${name:?}"
    git sparse-checkout disable
    [[ -e $sparse_file_dest ]] && (rm -v $sparse_file_dest) || true
fi
branch_name="$(git config --file $config_file --get $config_branch)"
git checkout ${branch_name}
git status | (grep sparse || echo "Not a sparse checkout")
