# =============
# ZSH Aliases
# =============

# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"         # Go to previous directory (need -- for dash)

# Zoxide (smart cd) aliases
if command -v zoxide &> /dev/null; then
    # Replace cd with zoxide, but keep original cd available
    alias cd="z"         # Smart cd using zoxide
    alias cdd="command cd"  # Original cd command (cd direct)
    alias j="z"          # Jump to directory (alternative)
    alias ji="zi"        # Interactive jump with fzf
    alias ja="astro_jump" # Jump to astronomy directories
else
    # Fallback if zoxide not available
    alias j="cd"         # Fallback to regular cd
fi

# Directory listing
if command -v eza &> /dev/null; then
    # Use eza if available (modern replacement for exa)
    alias ls="eza"
    alias ll="eza -l"
    alias la="eza -la"
    alias lt="eza -T"  # Tree view
    alias lg="eza -la --git"  # Show git status
else
    # Fallback to standard ls with colors
    alias ls="ls --color=auto"
    alias ll="ls -lh"
    alias la="ls -lha"
fi

# Git shortcuts
alias g="git"
alias ga="g add"
alias gap="ga --patch"
alias gb="g branch"
alias gba="gb --all"
alias gc="g commit"
alias gca="gc --amend --no-edit"
alias gce="gc --amend"
alias gci="~/.dotfiles/scripts/git-commit-helper.sh"  # Interactive commit helper
alias gcr="~/.dotfiles/scripts/git-commit-ref.sh"     # Commit message reference
alias gcs="smart_commit"                              # Smart commit with file analysis
alias qc="qcommit"                                    # Quick conventional commit
alias gco="g checkout"
alias gcb="gc -b"
alias gclo="g clone --recursive"
alias gcl="g clean -fd"
alias gd="g diff"
alias gds="g diff --staged"
alias gi="g init"
alias gl='g log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
alias gm="g merge"
alias gp="g push"
alias grb="g rebase"
alias gri="g rebase -i"
alias gr="g reset"
alias grh="g reset --hard HEAD"
alias gs="g status"
alias gst="g stash"
alias gsp="g stash pop"
alias gsl="g stash list"
alias gu="g pull"
alias gun="g reset --soft HEAD~1"

# Vim
alias v="vim"
alias vi="vim"

# Quickly edit config files
alias zrc="$EDITOR ~/.zshrc"
alias vrc="$EDITOR ~/.vimrc"
alias trc="$EDITOR ~/.tmux.conf"
alias dot="cd ~/.dotfiles"

# System commands
alias df="df -h" # human-readable sizes
alias free="free -m" # show sizes in MB
alias du="du -h" # human-readable sizes
alias duf="du -sh * | sort -hr" # disk usage of current directory, sorted

# Process management
if command -v htop &> /dev/null; then
    alias top="htop"
fi
alias psg="ps aux | grep" # search processes
alias killall="killall -v" # verbose killall

# Useful shortcuts
alias h="history"
alias j="jobs -l"
alias p="ps aux"
alias c="clear"
alias path="echo $PATH | tr : '\n'"

# Python
alias py="python"
alias py3="python3"
alias pip="pip3"
alias ven="python3 -m venv"
alias act="source venv/bin/activate"

# npm
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install -g"
alias nr="npm run"
alias ns="npm start"
alias nt="npm test"

# docker
alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"

# Show all listening ports
alias por="netstat -tulanp"

# macOS specific aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias shf='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hif='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
    alias fdn='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
    alias chr="open -a 'Google Chrome'"
    alias saf="open -a Safari"
    alias ff="open -a Firefox"
    alias vs="open -a 'Visual Studio Code'"
    alias fin="open -a Finder"
    alias pre="open -a Preview"
    alias cop="pwd | pbcopy" # copy current path to clipboard
fi

# Development workflow
alias ser="python3 -m http.server 8000" # start HTTP server
alias wtf="curl wttr.in/austin" # terminal weather
alias ip="curl ipinfo.io/ip" # get external IP
alias lip="ipconfig getifaddr en0" # get local IP (macOS)
alias spt="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"

# File operations
alias mkd="mkdir -pv" # create parent directories and be verbose
alias cp="cp -v" # verbose copy
alias mv="mv -v" # verbose move
alias rm="rm -v" # verbose remove
alias ln="ln -v" # verbose link

# Archive operations
alias tzp="tar -czf" # create tar.gz
alias tuz="tar -xzf" # extract tar.gz
alias zip="zip -r" # recursive zip

# Network utilities
alias png="ping -c 5" # ping 5 times by default
alias pgg="ping google.com" # quick ping to google
alias wgt="wget -c" # continue partial downloads
alias cur="curl -L" # follow redirects

# Quick edits and navigation
alias hos="sudo $EDITOR /etc/hosts"
alias zcf="$EDITOR ~/.zshrc"
alias als="$EDITOR ~/.dotfiles/zsh/aliases.zsh"
alias fun="$EDITOR ~/.dotfiles/zsh/functions.zsh"
alias rel="source ~/.zshrc" # reload zsh config

# Miscellaneous useful aliases
alias wek="date +%V" # get week number
alias tim="echo 'Timer started. Stop with Ctrl-D.' && date && time cat && date"
alias epo="date +%s" # get unix timestamp
alias iso="date +%Y-%m-%dT%H:%M:%S%z" # ISO 8601 date
alias tst="date '+%Y-%m-%d %H:%M:%S'"

# ===================
# Astronomy Aliases
# ===================

# Conda environment management
alias cac="conda activate"  # activate environment
alias cda="conda deactivate"  # deactivate environment
alias cel="conda env list"  # list environments
alias cec="conda env create"  # create environment
alias cer="conda env remove"  # remove environment
alias cii="conda install"  # install package
alias cil="conda list"  # list packages
alias cse="conda search"  # search packages

# Python/Jupyter shortcuts
alias jup="jupyter notebook"  # start jupyter notebook
alias jla="jupyter lab"  # start jupyter lab
alias ipy="ipython"  # start ipython
alias pip="pip3"  # use pip3 by default

# Common astronomy directories (customize these paths)
alias ar="cd ~/Astronomy_Research/"  # code repositories
alias galfit="~/Software/galfit"
# Navigation help
alias zh="zoxide_help"  # Show zoxide usage and stats
alias zl="zoxide query -l"  # List all zoxide directories

# FITS file operations
alias fts="ls *.fits 2>/dev/null || echo 'No FITS files found'"
alias fti="fitsinfo"  # quick FITS info function

# Quick astropy/astronomy tools
alias apy="python -c 'import astropy; print(astropy.__version__)'"
alias npy="python -c 'import numpy; print(numpy.__version__)'"
alias spy="python -c 'import scipy; print(scipy.__version__)'"
alias mpl="python -c 'import matplotlib; print(matplotlib.__version__)'"
# DS9 and visualization
alias d9="ds9 &"  # launch DS9 in background

# Useful astronomy calculations
alias jd="python -c 'from astropy.time import Time; import sys; print(Time(sys.argv[1] if len(sys.argv)>1 else \"now\").jd)'"
alias mjd="python -c 'from astropy.time import Time; import sys; print(Time(sys.argv[1] if len(sys.argv)>1 else \"now\").mjd)'"

# =============
# Modern Applications
# =============

# Zed editor shortcuts
if command -v zed &> /dev/null; then
    alias ze="zed"          # Quick zed launch (avoid conflict with zoxide 'z')
    alias zd="zed ."        # Open current directory in zed
    alias zf="zed --new"    # Open new zed window
fi

# Zen Browser shortcuts
alias zen="open -a 'Zen Browser'"
alias browser="zen"

# Ghostty terminal shortcuts
if command -v ghostty &> /dev/null; then
    alias gt="ghostty"      # Quick ghostty launch
    alias term="ghostty"    # Alternative terminal launcher
fi

# macOS specific application launchers
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Open current directory in Finder
    alias finder="open ."
    alias f="open ."
    
    # Open applications
    alias preview="open -a Preview"
    alias calculator="open -a Calculator"
    alias activity="open -a 'Activity Monitor'"
fi
