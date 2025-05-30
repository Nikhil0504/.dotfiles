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

# Create symbolic link for .vimrc
backup_file "$HOME/.vimrc"
ln -sf "$DOTFILES_DIR/vim/vimrc" "$HOME/.vimrc"
echo -e "${GREEN}✓${NC} Linked .vimrc"

# Create symbolic link for .tmux.conf
backup_file "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
echo -e "${GREEN}✓${NC} Linked .tmux.conf"

# Create symbolic link for .gitconfig
backup_file "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
echo -e "${GREEN}✓${NC} Linked .gitconfig"

# Create symbolic link for global gitignore
backup_file "$HOME/.gitignore_global"
ln -sf "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"
echo -e "${GREEN}✓${NC} Linked .gitignore_global"

# Create symbolic link for git commit template
backup_file "$HOME/.gitmessage"
ln -sf "$DOTFILES_DIR/git/gitmessage" "$HOME/.gitmessage"
echo -e "${GREEN}✓${NC} Linked .gitmessage"

# Create symbolic link for Starship config
backup_file "$HOME/.config/starship.toml"
ln -sf "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
echo -e "${GREEN}✓${NC} Linked starship.toml"

# Create symbolic link for Ghostty config
backup_file "$HOME/.config/ghostty/config"
mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
echo -e "${GREEN}✓${NC} Linked ghostty config"

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# OS-specific setup
if [[ "$OS" == "macos" ]]; then
    echo -e "${YELLOW}Running macOS-specific setup...${NC}"
    source "$DOTFILES_DIR/macos/setup.sh"
elif [[ "$OS" == "linux" ]]; then
    echo -e "${YELLOW}Running Linux-specific setup...${NC}"
    source "$DOTFILES_DIR/linux/setup.sh"
elif [[ "$OS" == "hpc" ]]; then
    echo -e "${YELLOW}Running HPC-specific setup...${NC}"
    source "$DOTFILES_DIR/hpc/setup.sh"
fi

echo -e "${GREEN}Dotfiles installation complete!${NC}"
