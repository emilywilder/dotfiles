# .zshenv → .zprofile → .zshrc → [.zlogin] → .zlogout
# :: Configuration for interactive login shells
# > environment variables for applications that don't need their own module
#   and need to be interactive

# PAGER
# -F or --quit-if-one-screen
# -R or --RAW-CONTROL-CHARS
export LESS='-FR'
