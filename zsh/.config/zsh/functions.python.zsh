#!/bin/zsh

ZSH_FUNCTIONS_BASEDIR=$0:h/functions
fpath+=($ZSH_FUNCTIONS_BASEDIR)

FUNCTIONS=(python_ensurepip pip_updateall)

# Load functions
for _f in ${ZSH_FUNCTIONS_BASEDIR}/${FUNCTIONS}; do
    autoload ${_f}
done