#!/usr/bin/env bash

# Linux specific setup script

echo "Setting up Linux specific configurations..."

# Detect package manager
if command -v apt-get &> /dev/null; then
    PKG_MGR="apt"
elif command -v dnf &> /dev/null; then
    PKG_MGR="dnf"
elif command -v yum &> /dev/null; then
    PKG_MGR="yum"
elif command -v pacman &> /dev/null; then
    PKG_MGR="pacman"
else
    echo "Unable to detect package manager. Manual installation required."
    exit 1
fi

echo "Detected package manager: $PKG_MGR"

# Install essential packages based on package manager
echo "Installing essential packages..."

if [ "$PKG_MGR" = "apt" ]; then
    sudo apt-get update
    sudo apt-get install -y git vim tmux curl wget htop tree jq unzip build-essential python3 python3-pip nodejs npm zsh
    
    # Install zoxide from GitHub releases (not in Ubuntu repos by default)
    if ! command -v zoxide &> /dev/null; then
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi
    
    # Install starship
    if ! command -v starship &> /dev/null; then
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi
elif [ "$PKG_MGR" = "dnf" ] || [ "$PKG_MGR" = "yum" ]; then
    sudo $PKG_MGR update -y
    sudo $PKG_MGR install -y git vim tmux curl wget htop tree jq unzip gcc make python3 python3-pip nodejs zsh
elif [ "$PKG_MGR" = "pacman" ]; then
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm git vim tmux curl wget htop tree jq unzip base-devel python python-pip nodejs npm zsh
fi

# Install modern utilities if not on minimal system (check with exa as indicator)
if ! command -v exa &> /dev/null; then
    echo "Installing modern CLI utilities..."
    if [ "$PKG_MGR" = "apt" ]; then
        # For Ubuntu/Debian, some tools might need PPA or direct installation
        sudo apt-get install -y ripgrep fd-find bat
        # exa might need to be installed from release binary or cargo
        if command -v cargo &> /dev/null; then
            cargo install exa
        fi
    elif [ "$PKG_MGR" = "dnf" ] || [ "$PKG_MGR" = "yum" ]; then
        sudo $PKG_MGR install -y ripgrep fd-find bat exa
    elif [ "$PKG_MGR" = "pacman" ]; then
        sudo pacman -S --noconfirm ripgrep fd bat exa
    fi
fi

# Install Oh My Zsh if requested
read -p "Do you want to install Oh My Zsh? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Set zsh as default shell if it isn't already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting Zsh as default shell..."
    chsh -s $(which zsh)
fi

echo "Linux setup complete!"
