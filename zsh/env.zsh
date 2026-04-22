#=============
# Environment Variables - Basic
# =============

# Editor settings
export EDITOR="nano"
export VISUAL="nano"
export PAGER="less"

# Basic PATH additions
export PATH="$HOME/.local/bin:$PATH"

# Terminal
export TERM="xterm-256color"

# Locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Java/JDK paths
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS Java paths
    if [[ -d "/opt/homebrew/opt/openjdk/bin" ]]; then
        export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
        export JAVA_HOME="/opt/homebrew/opt/openjdk"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux Java paths
    if [[ -d "/usr/lib/jvm/default-java" ]]; then
        export JAVA_HOME="/usr/lib/jvm/default-java"
        export PATH="$JAVA_HOME/bin:$PATH"
    fi
fi

# Ruby paths (macOS)
if [[ "$OSTYPE" == "darwin"* ]] && [[ -d "/opt/homebrew/opt/ruby/bin" ]]; then
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    export PATH="$(gem environment gemdir)/bin:$PATH"
fi

# Database paths
if [[ "$OSTYPE" == "darwin"* ]]; then
    # MySQL (macOS)
    if [[ -d "/usr/local/mysql/bin" ]]; then
        export PATH="/usr/local/mysql/bin:$PATH"
    fi
    # PostgreSQL (macOS)
    if [[ -d "/opt/homebrew/opt/postgresql/bin" ]]; then
        export PATH="/opt/homebrew/opt/postgresql/bin:$PATH"
    fi
fi

# Less options
export LESS="-R"
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Set proper terminal
export TERM="xterm-256color"

# History settings
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_DUPS      # Don't record duplicate entries
setopt HIST_IGNORE_ALL_DUPS  # Delete old duplicate entries
setopt HIST_IGNORE_SPACE     # Don't record entries starting with space
setopt HIST_SAVE_NO_DUPS     # Don't save duplicate entries
setopt HIST_VERIFY           # Show command with history expansion before running
setopt SHARE_HISTORY         # Share history between all sessions

# Editor settings
# Default to nano for terminal editing
export EDITOR="nano"
export VISUAL="nano"
export PAGER="less"


# Security settings
umask 022  # Default file permissions

# Performance settings
export KEYTIMEOUT=1  # Reduce key timeout for faster mode switching in vi mode

# Locale settings
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Development tools
export HOMEBREW_NO_ANALYTICS=1  # Disable Homebrew analytics
export HOMEBREW_NO_AUTO_UPDATE=1  # Disable automatic updates during install

# ===================
# Astronomy Settings
# ===================

# FITS file handling
export FITS_VERIFY_CHECKSUM=true
export ASTROPY_USE_SYSTEM_TIMEZONE=1

# Jupyter settings
export JUPYTER_CONFIG_DIR="$HOME/.jupyter"
export JUPYTER_DATA_DIR="$HOME/.local/share/jupyter"

# Python settings for astronomy
export PYTHONUNBUFFERED=1  # Ensure Python output is not buffered
export ASTROPY_CACHE_DIR="$HOME/.astropy/cache"

# STPSF Path
export STPSF_PATH=$HOME/Software/stpsf-data  

# PIXEDFIT path
export PIXEDFIT_HOME="$HOME/Software/piXedfit"

# DS9 settings
export DS9_TITLE="DS9"

# Increase memory limits for large datasets
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS specific settings
    ulimit -n 4096  # Increase file descriptor limit
fi

export SPS_HOME="$HOME/Astronomy_Research/fsps"
