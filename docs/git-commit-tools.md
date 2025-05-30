# 📝 Git Commit Tools Summary

Your dotfiles now include a comprehensive set of tools for creating well-structured commit messages following conventional commit standards, optimized for astronomy research workflows.

## 🛠️ Available Tools

### 1. **Commit Template** (`~/.gitmessage`)
- Automatically loads when you run `git commit` without `-m`
- Provides guidelines and examples for conventional commits
- Includes astronomy-specific types and scopes

### 2. **Interactive Commit Helper** (`scripts/git-commit-helper.sh`)
- **Alias:** `gci`
- **Usage:** `gci` or `git-commit-helper.sh`
- Step-by-step guided commit creation
- Input validation and helpful suggestions
- Preview before committing

### 3. **Quick Reference Guide** (`scripts/git-commit-ref.sh`)
- **Alias:** `gcr`
- **Usage:** `gcr` or `git-commit-ref.sh`
- Displays commit format, types, scopes, and examples
- Quick command reference

### 4. **Quick Conventional Commit** (function)
- **Alias:** `qc`
- **Usage:** `qc <type> [scope] <message>`
- **Examples:**
  ```bash
  qc feat photometry "add PSF fitting"
  qc fix "" "correct parsing bug"
  qc data calib "update flat fields"
  ```

### 5. **Smart Commit** (function)
- **Alias:** `gcs`
- **Usage:** `gcs`
- Analyzes staged files and suggests commit type/scope
- Automatically launches interactive helper

### 6. **Git Aliases** (in gitconfig)
- `git cfeat <scope> <message>` - Quick feature commit
- `git cfix <scope> <message>` - Quick fix commit
- `git cdata <scope> <message>` - Quick data commit
- `git cscience <scope> <message>` - Quick science commit
- `git cphotometry <message>` - Photometry commit with staging
- `git cspectro <message>` - Spectroscopy commit with staging
- `git cmsg-help` - Show commit template

## 🎯 Workflow Examples

### Basic Workflow
```bash
# Stage your changes
ga .

# Use interactive helper for guided commit
gci

# Or use smart commit (analyzes files and suggests type)
gcs
```

### Quick Commits
```bash
# Quick conventional commit
qc feat photometry "implement new PSF model"

# Git aliases for common patterns
git cfeat photometry "implement new PSF model"
git cfix jwst "correct WCS parsing"
git cdata calib "add new flat fields"
```

### Reference and Help
```bash
# Show quick reference
gcr

# Show full commit template
git cmsg-help
```

## 🔭 Astronomy-Specific Features

### Types
- `data`: Data processing, calibration, analysis updates
- `science`: Scientific analysis, algorithm improvements
- `paper`: Paper/publication related changes

### Scopes
- **Instruments:** `jwst`, `hst`, `alma`, `vlt`
- **Analysis:** `photometry`, `spectro`, `astrometry`
- **Data:** `calib`, `reduction`, `pipeline`
- **Files:** `fits`, `coords`, `io`
- **Methods:** `stats`, `ml`, `models`

### Quick Astronomy Commits
```bash
# Specific astronomy aliases
git cphotometry "add aperture correction"
git cspectro "improve line fitting"
git cplot "add color-magnitude diagram"
git ccalib "update bias frames"
```

## 🚀 Getting Started

1. **For beginners:** Use `gci` (interactive helper)
2. **For quick commits:** Use `qc type scope "message"`
3. **For analysis:** Use `gcs` (smart commit)
4. **For reference:** Use `gcr` (quick guide)

All tools include validation, helpful suggestions, and follow conventional commit standards optimized for scientific workflows!
