#!/usr/bin/env bash

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}=====================================${NC}"
echo -e "${CYAN}     DOTFILES DRY RUN MODE${NC}"
echo -e "${CYAN}=====================================${NC}"
echo -e "${YELLOW}This will show what would happen without making any changes${NC}"
echo ""

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

echo -e "${BLUE}Detected OS: ${GREEN}$OS${NC}"
echo ""

# Get directory of this script
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo -e "${BLUE}Dotfiles directory: ${GREEN}$DOTFILES_DIR${NC}"
echo ""

# Function to check what would be backed up
check_backup() {
    local file="$1"
    local basename_file=$(basename "$file")
    if [ -f "$file" ] || [ -L "$file" ]; then
        if [ -L "$file" ]; then
            local link_target=$(readlink "$file")
            echo -e "${YELLOW}  📁 Would backup existing symlink:${NC} $basename_file -> $link_target"
        else
            local file_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo "unknown")
            echo -e "${YELLOW}  📁 Would backup existing file:${NC} $basename_file (${file_size} bytes)"
        fi
        echo -e "${CYAN}     Backup location:${NC} ~/.dotfiles_backup/YYYYMMDD_HHMMSS/$basename_file"
    else
        echo -e "${GREEN}  ✓ No existing file:${NC} $basename_file"
    fi
}

# Function to show what symlink would be created
show_symlink() {
    local source="$1"
    local target="$2"
    local basename_file=$(basename "$target")
    echo -e "${BLUE}  🔗 Would create symlink:${NC} $basename_file -> $source"
}

echo -e "${YELLOW}Checking configuration files...${NC}"

# Check .zshrc
echo -e "\n${BLUE}1. Zsh Configuration (.zshrc):${NC}"
check_backup "$HOME/.zshrc"
show_symlink "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# Check .vimrc
echo -e "\n${BLUE}2. Vim Configuration (.vimrc):${NC}"
check_backup "$HOME/.vimrc"
show_symlink "$DOTFILES_DIR/vim/vimrc" "$HOME/.vimrc"

# Check .tmux.conf
echo -e "\n${BLUE}3. Tmux Configuration (.tmux.conf):${NC}"
check_backup "$HOME/.tmux.conf"
show_symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# Check .gitconfig
echo -e "\n${BLUE}4. Git Configuration (.gitconfig):${NC}"
check_backup "$HOME/.gitconfig"
show_symlink "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"

# Check .gitignore_global
echo -e "\n${BLUE}5. Global Git Ignore (.gitignore_global):${NC}"
check_backup "$HOME/.gitignore_global"
show_symlink "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"

# Check if .config directory exists
echo -e "\n${BLUE}6. Config Directory:${NC}"
if [ -d "$HOME/.config" ]; then
    echo -e "${GREEN}  ✓ ~/.config directory already exists${NC}"
else
    echo -e "${YELLOW}  📁 Would create ~/.config directory${NC}"
fi

# Show OS-specific setup that would run
echo -e "\n${BLUE}7. OS-Specific Setup:${NC}"
if [[ "$OS" == "macos" ]]; then
    echo -e "${CYAN}  🍎 Would run macOS setup:${NC}"
    echo -e "     • Install/update Homebrew"
    echo -e "     • Install essential packages: git, vim, tmux, exa, ripgrep, fd, bat, jq, htop, wget, curl, tree, fzf"
    echo -e "     • Install programming tools: python, node, go"
    echo -e "     • Install GUI apps: iTerm2, VS Code, Chrome (if not headless)"
    echo -e "     • Configure macOS system preferences"
    echo -e "     • Set up GNU utilities over BSD defaults"
elif [[ "$OS" == "linux" ]]; then
    echo -e "${CYAN}  🐧 Would run Linux setup:${NC}"
    echo -e "     • Detect package manager (apt/dnf/yum/pacman)"
    echo -e "     • Update package lists"
    echo -e "     • Install essential packages and development tools"
    echo -e "     • Install modern CLI utilities"
    echo -e "     • Optionally install Oh My Zsh"
    echo -e "     • Set Zsh as default shell if needed"
elif [[ "$OS" == "hpc" ]]; then
    echo -e "${CYAN}  🖥️  Would run HPC setup:${NC}"
    echo -e "     • Create local directories (~/.local/bin, ~/.config)"
    echo -e "     • Install Miniconda if not present"
    echo -e "     • Install essential Python packages (numpy, scipy, matplotlib, pandas, jupyterlab)"
    echo -e "     • Set up module system integration"
fi

# Check for existing dotfiles repository
echo -e "\n${BLUE}8. Repository Status:${NC}"
if [ -d "$DOTFILES_DIR/.git" ]; then
    echo -e "${GREEN}  ✓ Git repository detected${NC}"
    cd "$DOTFILES_DIR"
    local branch=$(git branch --show-current 2>/dev/null || echo "unknown")
    local status=$(git status --porcelain 2>/dev/null)
    echo -e "${CYAN}     Current branch:${NC} $branch"
    if [ -z "$status" ]; then
        echo -e "${GREEN}     Working tree is clean${NC}"
    else
        echo -e "${YELLOW}     Working tree has changes${NC}"
    fi
else
    echo -e "${YELLOW}  ⚠️  No git repository found${NC}"
fi

echo -e "\n${CYAN}=====================================${NC}"
echo -e "${CYAN}        DRY RUN COMPLETE${NC}"
echo -e "${CYAN}=====================================${NC}"
echo ""
echo -e "${GREEN}To actually run the installation:${NC}"
echo -e "  ./install.sh"
echo ""
echo -e "${YELLOW}All your existing files will be safely backed up before any changes are made.${NC}"
