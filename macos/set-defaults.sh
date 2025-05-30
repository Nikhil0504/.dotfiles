#!/usr/bin/env bash

# ===================
# macOS Default Applications Setup
# ===================
# Set Zed, Zen Browser, and Ghostty as default applications

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Setting up default applications for modern development...${NC}\n"

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}This script is only for macOS${NC}"
    exit 1
fi

# Function to check if app is installed
check_app() {
    local app_name="$1"
    if [ -d "/Applications/$app_name.app" ]; then
        echo -e "${GREEN}✓${NC} $app_name is installed"
        return 0
    else
        echo -e "${YELLOW}!${NC} $app_name is not installed"
        return 1
    fi
}

# Set default terminal to Ghostty (if installed)
if check_app "Ghostty"; then
    echo "Setting Ghostty as default terminal..."
    # Note: There's no built-in way to set default terminal on macOS
    # Users need to manually set it in System Preferences > General > Default web browser
    echo -e "${YELLOW}Manual step:${NC} Set Ghostty as default in System Preferences if desired"
fi

# Set Zen Browser as default browser (if installed)
if check_app "Zen Browser"; then
    echo "Setting Zen Browser as default web browser..."
    # This sets Zen as default browser
    if command -v defaultbrowser &> /dev/null; then
        defaultbrowser zen
        echo -e "${GREEN}✓${NC} Zen Browser set as default"
    else
        echo -e "${YELLOW}Manual step:${NC} Set Zen Browser as default in System Preferences > General > Default web browser"
        echo "Or install defaultbrowser: brew install defaultbrowser"
    fi
fi

# Set file associations for Zed
if check_app "Zed"; then
    echo "Setting file associations for Zed editor..."
    
    # Common development file extensions
    file_types=(
        "public.plain-text"
        "public.source-code"
        "public.script"
        "public.shell-script"
        "com.netscape.javascript-source"
        "public.python-script"
        "public.ruby-script"
        "public.perl-script"
        "public.c-source"
        "public.c-plus-plus-source"
        "public.objective-c-source"
        "com.sun.java-source"
        "public.php-script"
        "public.json"
        "public.xml"
        "public.yaml"
        "org.gnu.gnu-tar-archive"
        "public.log"
        "public.comma-separated-values-text"
    )
    
    for file_type in "${file_types[@]}"; do
        duti -s dev.zed.Zed "$file_type" all 2>/dev/null || true
    done
    
    # Specific file extensions
    extensions=(
        ".txt" ".md" ".py" ".js" ".ts" ".html" ".css" ".json" ".yaml" ".yml"
        ".sh" ".zsh" ".bash" ".fish" ".rs" ".go" ".java" ".c" ".cpp" ".h"
        ".hpp" ".rb" ".php" ".pl" ".swift" ".kt" ".scala" ".r" ".sql"
        ".log" ".conf" ".cfg" ".ini" ".toml" ".xml" ".csv" ".tsv"
    )
    
    for ext in "${extensions[@]}"; do
        duti -s dev.zed.Zed "$ext" all 2>/dev/null || true
    done
    
    echo -e "${GREEN}✓${NC} File associations set for Zed"
else
    echo -e "${YELLOW}Zed not found, skipping file associations${NC}"
fi

echo -e "\n${GREEN}Default applications setup complete!${NC}"
echo -e "${YELLOW}Note:${NC} Some settings may require logging out and back in to take effect"

# Show current defaults for verification
echo -e "\n${YELLOW}Current browser default:${NC}"
if command -v defaultbrowser &> /dev/null; then
    defaultbrowser
else
    echo "Install 'defaultbrowser' to check: brew install defaultbrowser"
fi
