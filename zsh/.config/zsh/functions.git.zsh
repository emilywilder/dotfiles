#!/bin/zsh

ZSH_FUNCTIONS_BASEDIR=$0:h/functions
fpath+=($ZSH_FUNCTIONS_BASEDIR)

FUNCTIONS=(packsources gittree)

# Load functions
for _f in ${ZSH_FUNCTIONS_BASEDIR}/${FUNCTIONS}; do
    autoload ${_f}
done