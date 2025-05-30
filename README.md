# Dotfiles

This repository contains my personal dotfiles for configuring various tools and environments across different systems.

## Features

- Cross-platform compatibility (macOS, Linux, HPC)
- Modular organization of configuration files
- Automatic installation with a single command
- Platform-specific configurations
- Extensive Vim, Tmux, Git, and Zsh configurations

## Components

- **Zsh**: Shell configuration with aliases, functions, and environment setup
- **Vim**: Feature-rich Vim configuration
- **Git**: Git configuration with useful aliases and settings
- **Tmux**: Terminal multiplexer configuration
- **OS-specific settings**: Configurations for macOS and Linux
- **HPC settings**: Special configurations for High-Performance Computing environments

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
├── git/              # Git configuration
├── hpc/              # HPC-specific settings
├── linux/            # Linux-specific settings
├── macos/            # macOS-specific settings
├── scripts/          # Utility scripts
├── tmux/             # Tmux configuration
├── vim/              # Vim configuration
├── zsh/              # Zsh configuration
├── install.sh        # Main installation script
└── README.md         # This file
```

## Customization

### Local Customizations

Each configuration supports local customization through `.local` files that are not tracked by Git:

- `~/.zshrc.local`: Local Zsh settings
- `~/.vimrc.local`: Local Vim settings
- `~/.tmux.conf.local`: Local Tmux settings
- `~/.gitconfig.local`: Local Git settings

### Environment Detection

The dotfiles automatically detect which environment they're running in:

- macOS (laptop)
- Linux (desktop)
- HPC (cluster)

## Key Features

### Zsh Configuration

- Custom aliases and functions
- Environment variables
- Platform-specific settings

### Vim Configuration

- Sensible defaults
- Key mappings
- Syntax highlighting
- Auto-indentation

### Git Configuration

- Useful aliases
- Default settings
- Global gitignore

### Tmux Configuration

- Custom key bindings
- Status bar configuration
- Mouse support

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

These dotfiles were inspired by and borrow from various sources including:
- [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
- [Thoughtbot's dotfiles](https://github.com/thoughtbot/dotfiles)
- [The Ultimate Vim Configuration](https://github.com/amix/vimrc)
