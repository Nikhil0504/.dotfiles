# 🎯 Modern Applications Update

Your dotfiles have been updated to use modern, fast applications instead of traditional ones:

## 🔄 Application Changes

| Traditional | Modern Alternative | Why? |
|-------------|-------------------|------|
| VS Code | **Zed** | Faster, native performance, better for large codebases |
| Google Chrome | **Zen Browser** | Privacy-focused, less resource-heavy, cleaner UI |
| iTerm2 | **Ghostty** | GPU-accelerated, faster rendering, modern terminal |

## 📦 Installation Updates

### macOS Setup (`macos/setup.sh`)
- ✅ Installs Ghostty instead of iTerm2
- ✅ Installs Zed instead of VS Code  
- ✅ Installs Zen Browser instead of Chrome
- ✅ Includes `duti` and `defaultbrowser` for setting file associations
- ✅ Automatically runs default applications setup

### Environment Configuration (`zsh/env.zsh`)
- ✅ Sets Zed as preferred GUI editor (`$GUI_EDITOR`)
- ✅ Creates `edit` and `e` aliases for Zed
- ✅ Falls back to VS Code if Zed not available

### Aliases (`zsh/aliases.zsh`)
- ✅ `z` - Quick Zed launch
- ✅ `zd` - Open current directory in Zed  
- ✅ `zen` - Launch Zen Browser
- ✅ `gt` - Quick Ghostty launch
- ✅ Various macOS application shortcuts

## ⚙️ New Configurations

### Ghostty Terminal (`ghostty/config`)
- 🎨 Astronomy-friendly color scheme
- ⚡ Optimized for performance
- 🔧 macOS-native key bindings
- 📊 Good for viewing data files and terminal plots
- 🖼️ Image support for matplotlib in terminal

### Default Applications (`macos/set-defaults.sh`)
- 📝 Sets Zed as default for code files
- 🌐 Sets Zen Browser as default browser
- 📁 Associates development file types with Zed
- ⚙️ Configures macOS file associations

## 🚀 Quick Usage

### Zed Editor
```bash
ze                   # Launch Zed (fixed conflict with zoxide)
zd                   # Open current directory  
edit myfile.py       # Edit file in Zed
e .                  # Open current dir in Zed
```

### Zen Browser
```bash
zen                  # Launch Zen Browser
browser              # Alternative launcher
```

### Ghostty Terminal  
```bash
gt                   # Launch Ghostty
term                 # Alternative launcher
```

## 🔧 Manual Steps After Installation

1. **Set Zen Browser as default** (if not automatic):
   - System Preferences > General > Default web browser

2. **Configure Ghostty** (optional):
   - Customize colors in `~/.config/ghostty/config`
   - Adjust font size, opacity, etc.

3. **Zed Extensions** (optional):
   - Install language servers for your preferred languages
   - Configure themes and settings in Zed preferences

## 📋 Backup Information

- Your old configurations are backed up with timestamps
- Traditional apps aren't removed - they're just not installed by default
- You can still install them manually if needed:
  ```bash
  brew install --cask iterm2 visual-studio-code google-chrome
  ```

## 🎯 Benefits for Astronomy Workflows

- **Zed**: Faster for large Python codebases and Jupyter notebooks
- **Zen Browser**: Better for research - less tracking, faster loading
- **Ghostty**: Superior for terminal-based tools (DS9, command-line analysis)
- **All**: Lower memory usage = more resources for your computations

Run `install.sh` to apply all these changes!
