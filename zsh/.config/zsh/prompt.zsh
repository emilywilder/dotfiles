autoload colors vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '⎇  %b'
zstyle ':vcs_info:*' get-revision true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

# uses a ternary expression as defined in
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Conditional-Substrings-in-Prompts

_prev_cmd_status='%(?.️%F{green}.%F{red})⏺%F{white} '

RPROMPT='%(?..%F{red}↳ %?%F{white})%(2L. ↓%L.)'

PROMPT='%B%F{green}%~%f %B%F{cyan}${vcs_info_msg_0_}%f
${_prev_cmd_status}%F{white}%n@%m %# %f%b'
