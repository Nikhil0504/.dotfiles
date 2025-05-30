#!/usr/bin/env bash

# macOS specific setup script

echo "Setting up macOS specific configurations..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zshrc.local
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed."
fi

# Install essential packages
echo "Installing essential packages..."
brew install git vim tmux eza ripgrep fd bat jq htop wget curl tree fzf zoxide starship

# Install utilities for setting default applications
brew install duti defaultbrowser

# Install programming languages and tools
brew install python node go 

# Install GUI applications if not headless
if [ -d "/Applications" ]; then
    echo "Installing GUI applications..."
    
    # Modern terminal: Ghostty
    echo "Installing Ghostty terminal..."
    brew install --cask ghostty
    
    # Modern editor: Zed
    echo "Installing Zed editor..."
    brew install --cask zed
    
    # Modern browser: Zen Browser
    echo "Installing Zen Browser..."
    brew install --cask zen-browser
    
    # Optional: Install traditional alternatives as backup
    # brew install --cask iterm2 visual-studio-code google-chrome
fi

# Set macOS defaults
echo "Setting macOS defaults..."

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Use column view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "macOS setup complete!"

# Set default applications
echo "Setting up default applications..."
"$HOME/.dotfiles/macos/set-defaults.sh"

# Restart affected applications
for app in "Finder" "Dock" "SystemUIServer"; do
    killall "${app}" &> /dev/null
done
