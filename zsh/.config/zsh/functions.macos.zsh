#!/bin/zsh

ZSH_FUNCTIONS_BASEDIR=$0:h/functions
fpath+=($ZSH_FUNCTIONS_BASEDIR)

FUNCTIONS=(attachiso dequarantine)

# Load functions
for _f in ${ZSH_FUNCTIONS_BASEDIR}/${FUNCTIONS}; do
    autoload ${_f}
done