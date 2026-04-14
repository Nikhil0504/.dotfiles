# =============
# ZSH Aliases - Essential Only
# =============

# Basic navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"         # Go to previous directory

# Directory listing (macOS)
alias ls="ls -G"
alias ll="ls -lh"
alias la="ls -lha"

# Basic utilities
alias c="clear"
alias h="history"
alias path="echo $PATH | tr ':' '\\n'"

# Quickly edit config files
alias zrc="$EDITOR ~/.zshrc"
alias dot="cd ~/.dotfiles"
