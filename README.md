# Dotfiles

This repository contains a minimal, portable set of dotfiles focused on essential shell utilities and navigation.

## Features

- Minimalist approach - only essential configurations included
- Cross-platform compatibility (macOS, Linux)
- Simple, easy-to-understand configuration
- Focus on productivity without bloat
- Automatic installation with a single command

## Installation

Clone the repository and run the installer:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

The installer will automatically detect your OS and set up the appropriate configurations.

## Directory Structure

```
.dotfiles/
├── zsh/              # Zsh configuration (essential aliases and functions)
├── macos/            # macOS-specific settings
├── install.sh        # Main installation script
└── README.md         # This file
```

## What's Included

### Zsh Configuration

- **Basic Navigation**: `..`, `...`, `....`, `.....`, `~`, `-` (previous directory)
- **Directory Listing**: `ls`, `ll`, `la` (with macOS color support)
- **Essential Utilities**: 
  - `c` - clear screen
  - `h` - history
  - `path` - display PATH entries line by line
- **Config Shortcuts**:
  - `zrc` - edit zshrc
  - `dot` - navigate to dotfiles directory
- **Core Functions**:
  - `mkcd()` - create directory and enter it
  - `extract()` - extract various archive types
  - `jump()` - navigate to directory containing a file
  - `mkdz()` - create directory and enter it

## Customization

Since this is a minimal starting point, you can add only what you actually need:

- Edit `~/.zshrc` for additional aliases and functions
- Add local configurations as needed
- Install only the tools you actually use

## License

This project is licensed under the MIT License - see the LICENSE file for details.
