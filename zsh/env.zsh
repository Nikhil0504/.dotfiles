# =============
# Environment Variables
# =============

# XDG Base Directory specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Homebrew paths (macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ -d "/opt/homebrew/bin" ]]; then
        export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
    elif [[ -d "/usr/local/bin" ]]; then
        export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    fi
fi

# Go path
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Rust path
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Zoxide (smart cd replacement)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# Starship prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# Node Version Manager (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Anaconda/Conda configuration
# Try multiple common conda installation paths
CONDA_PATHS=(
    "$HOME/anaconda3"
    "$HOME/miniconda3"
    "/opt/anaconda3"
    "/opt/miniconda3"
    "/opt/homebrew/Caskroom/miniforge/base"
    "/opt/homebrew/Caskroom/miniconda/base"
    "/usr/local/Caskroom/miniforge/base"
    "/usr/local/Caskroom/miniconda/base"
)

# Find and initialize conda
for conda_path in "${CONDA_PATHS[@]}"; do
    if [[ -d "$conda_path" ]]; then
        # Initialize conda for zsh
        if [[ -f "$conda_path/etc/profile.d/conda.sh" ]]; then
            source "$conda_path/etc/profile.d/conda.sh"
        fi
        
        # Add conda to PATH if not already there
        if [[ ":$PATH:" != *":$conda_path/bin:"* ]]; then
            export PATH="$conda_path/bin:$PATH"
        fi
        
        # Set conda environment variables
        export CONDA_PREFIX="$conda_path"
        break
    fi
done

# Conda configuration
export CONDA_AUTO_ACTIVATE_BASE=false  # Don't auto-activate base environment
export CONDA_CHANGEPS1=false          # Don't let conda change the prompt

# Python path 
# Use a more flexible approach for Python site-packages
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
    export PYTHONPATH="$PYTHONPATH:$HOME/.local/lib/python${PYTHON_VERSION}/site-packages"
fi

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
# Default to vim for terminal editing
export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"

# GUI Editor (Zed)
if command -v zed &> /dev/null; then
    export GUI_EDITOR="zed"
    alias edit="zed"
    alias e="zed"
elif command -v code &> /dev/null; then
    export GUI_EDITOR="code"
    alias edit="code"
    alias e="code"
fi

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

# Matplotlib backend for remote/headless environments
#export MPLBACKEND="Agg"  # Use when no display is available

# FITS file handling
export FITS_VERIFY_CHECKSUM=true
export ASTROPY_USE_SYSTEM_TIMEZONE=1

# Jupyter settings
export JUPYTER_CONFIG_DIR="$HOME/.jupyter"
export JUPYTER_DATA_DIR="$HOME/.local/share/jupyter"

# Python settings for astronomy
export PYTHONUNBUFFERED=1  # Ensure Python output is not buffered
export ASTROPY_CACHE_DIR="$HOME/.astropy/cache"

# Common astronomy data directories (customize these paths as needed)
# Uncomment and modify these paths based on your directory structure
# export ASTRO_DATA="$HOME/Data"
# export ASTRO_OBSERVATIONS="$HOME/Observations"
# export ASTRO_REDUCTIONS="$HOME/Reductions" 
# export ASTRO_ANALYSIS="$HOME/Analysis"
# export ASTRO_PAPERS="$HOME/Papers"


# DS9 settings
export DS9_TITLE="DS9"

# Increase memory limits for large datasets
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS specific settings
    ulimit -n 4096  # Increase file descriptor limit
fi
