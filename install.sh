#!/usr/bin/env bash

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the current OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    # Check if we're on an HPC system
    if command -v module &> /dev/null; then
        OS="hpc"
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    echo -e "${RED}Unknown OS type: $OSTYPE${NC}"
    exit 1
fi

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}Setting up dotfiles for ${GREEN}$OS${NC}"
echo -e "${BLUE}=====================================${NC}"

# Get directory of this script
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function to backup existing files
backup_file() {
    local file="$1"
    if [ -f "$file" ] || [ -L "$file" ]; then
        local backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
        mkdir -p "$backup_dir"
        cp "$file" "$backup_dir/$(basename "$file")"
        echo -e "${YELLOW}Backed up existing $(basename "$file") to $backup_dir${NC}"
    fi
}

# Create symbolic links for common configurations
echo -e "${YELLOW}Creating symbolic links...${NC}"

# Create symbolic link for .zshrc
backup_file "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
echo -e "${GREEN}✓${NC} Linked .zshrc"

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# OS-specific setup
if [[ "$OS" == "macos" ]]; then
    echo -e "${YELLOW}Running macOS-specific setup...${NC}"
    source "$DOTFILES_DIR/macos/setup.sh"
fi

echo -e "${GREEN}Dotfiles installation complete!${NC}"
