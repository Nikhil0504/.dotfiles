# =============
# ZSH Functions
# =============

# Create a new directory and enter it
mkcd() {
  mkdir -p "$@" && cd "$_";
}

# Extract most know archives with one command
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Show all the names (CNs) listed in the SSL certificate for a given domain
getcertnames() {
  if [ -z "${1}" ]; then
    echo "ERROR: No domain specified."
    return 1
  fi

  local domain="${1}"
  echo "Testing ${domain}..."
  echo ""; # newline

  local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
    | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

  if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
    local certText=$(echo "${tmp}" \
      | openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
      no_serial, no_sigdump, no_signame, no_validity, no_version");
    echo "Common Name:"
    echo ""; # newline
    echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
    echo ""; # newline
    echo "Subject Alternative Name(s):"
    echo ""; # newline
    echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
      | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
    return 0;
  else
    echo "ERROR: Certificate not found.";
    return 1;
  fi
}

# Create a .tar.gz archive using `zopfli`, `pigz` or `gzip` for compression
targz() {
  local tmpFile="${@%/}.tar";
  tar -cf "${tmpFile}" --exclude=".DS_Store" "${@}";
  size=$(stat -f"%z" "${tmpFile}");

  local cmd="";
  if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
    # For files < 50 MB, use `zopfli` (best compression but very slow)
    cmd="zopfli";
  else
    if hash pigz 2> /dev/null; then
      # Use `pigz` for parallel gzip compression
      cmd="pigz";
    else
      cmd="gzip";
    fi;
  fi;

  echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
  "${cmd}" -v "${tmpFile}";
  [ -f "${tmpFile}" ] && rm "${tmpFile}";

  zippedSize=$(stat -f"%z" "${tmpFile}.gz");
  echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}

# Start an HTTP server from a directory, optionally specifying the port
server() {
  local port="${1:-8000}";
  python3 -m http.server "$port"
}

# Run `dig` and display the most useful info for DNS queries
digga() {
  dig +nocmd "$1" any +multiline +noall +answer;
}

# Git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# Quick conventional commit with validation
qcommit() {
  local type="$1"
  local scope="$2"
  local message="$3"
  
  if [[ -z "$type" || -z "$message" ]]; then
    echo "Usage: qcommit <type> [scope] <message>"
    echo "Types: feat, fix, docs, data, science, perf, refactor, test, chore, config, paper"
    echo "Example: qcommit feat photometry \"add PSF fitting\""
    echo "Example: qcommit fix \"\" \"correct bug in parser\""
    return 1
  fi
  
  # Validate type
  if [[ ! "$type" =~ ^(feat|fix|docs|data|science|perf|refactor|test|chore|config|paper)$ ]]; then
    echo "Invalid type: $type"
    echo "Valid types: feat, fix, docs, data, science, perf, refactor, test, chore, config, paper"
    return 1
  fi
  
  # Build commit message
  local commit_msg
  if [[ -n "$scope" ]]; then
    commit_msg="$type($scope): $message"
  else
    commit_msg="$type: $message"
  fi
  
  # Check message length
  if [[ ${#commit_msg} -gt 50 ]]; then
    echo "Warning: commit message is ${#commit_msg} chars (recommended max: 50)"
    echo "Message: $commit_msg"
    read -q "REPLY?Continue anyway? (y/N): "
    echo
    if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
      return 1
    fi
  fi
  
  git commit -m "$commit_msg"
}

# Smart commit - analyzes staged files and suggests commit type
smart_commit() {
  if ! git diff --cached --quiet; then
    local staged_files=$(git diff --cached --name-only)
    local commit_type=""
    local suggested_scope=""
    
    # Analyze file types and suggest commit type
    if echo "$staged_files" | grep -q "\.md$\|\.rst$\|\.txt$\|docs/"; then
      commit_type="docs"
    elif echo "$staged_files" | grep -q "test_\|_test\|\.test\|tests/"; then
      commit_type="test"
    elif echo "$staged_files" | grep -q "\.fits$\|\.dat$\|data/"; then
      commit_type="data"
    elif echo "$staged_files" | grep -q "\.py$\|\.ipynb$"; then
      commit_type="feat"
      # Suggest scope based on file paths
      if echo "$staged_files" | grep -q "photometry\|phot"; then
        suggested_scope="photometry"
      elif echo "$staged_files" | grep -q "spectro\|spec"; then
        suggested_scope="spectro"
      elif echo "$staged_files" | grep -q "plot\|viz"; then
        suggested_scope="plotting"
      elif echo "$staged_files" | grep -q "calib"; then
        suggested_scope="calib"
      fi
    elif echo "$staged_files" | grep -q "\.json$\|\.yaml$\|\.yml$\|\.conf$\|config"; then
      commit_type="config"
    else
      commit_type="chore"
    fi
    
    echo "Staged files:"
    echo "$staged_files" | sed 's/^/  /'
    echo
    echo "Suggested commit type: $commit_type"
    if [[ -n "$suggested_scope" ]]; then
      echo "Suggested scope: $suggested_scope"
    fi
    echo
    ~/.dotfiles/scripts/git-commit-helper.sh
  else
    echo "No staged files found. Use 'git add' first."
  fi
}

# Jump to directory containing file
jump() {
  cd "$(dirname "$1")"
}

# Enhanced directory creation that also registers with zoxide
mkdz() {
  mkdir -p "$@" && cd "$_" && command -v zoxide &> /dev/null && zoxide add "$PWD"
}

# Fuzzy find and jump to astronomy directories
astro_jump() {
  if command -v fzf &> /dev/null && command -v zoxide &> /dev/null; then
    local dir=$(zoxide query -l | grep -E "(astro|obs|data|analysis|papers|jwst|hst)" | fzf --prompt="Jump to astronomy directory: ")
    if [[ -n "$dir" ]]; then
      cd "$dir"
    fi
  else
    echo "Requires fzf and zoxide to be installed"
  fi
}

# Show zoxide usage and most visited directories
zoxide_help() {
  if command -v zoxide &> /dev/null; then
    echo "🚀 Zoxide Navigation Help:"
    echo ""
    echo "Commands:"
    echo "  cd <query>     - Smart cd using zoxide (learns your habits)"
    echo "  cdd <path>     - Original cd command (direct path only)"
    echo "  ji <query>     - Interactive directory selection with fzf"
    echo "  ja             - Interactive astronomy directory selection"
    echo "  -              - Go to previous directory"
    echo ""
    echo "Examples:"
    echo "  cd observations    - Jump to most visited 'observations' directory"
    echo "  cd jwst f200w     - Jump to directory matching both 'jwst' and 'f200w'"
    echo "  cdd /exact/path   - Use original cd for exact paths"
    echo ""
    echo "📊 Your most visited directories:"
    zoxide query -l | head -10 | nl
  else
    echo "Zoxide not installed. Using regular cd."
  fi
}

# ===================
# Astronomy Functions
# ===================

# Quick conda environment activation with fuzzy finder
cea() {
  if command -v fzf &> /dev/null; then
    local env=$(conda env list | grep -v '^#' | awk '{print $1}' | grep -v '^$' | fzf --prompt="Select conda environment: ")
    if [[ -n "$env" ]]; then
      conda activate "$env"
    fi
  else
    echo "fzf not installed. Available environments:"
    conda env list
  fi
}

# Create a new conda environment with common astronomy packages
astro_env() {
  if [[ -z "$1" ]]; then
    echo "Usage: astro_env <environment_name> [profile]"
    echo "Profiles: basic, jwst, general, spectroscopy, photometry"
    return 1
  fi
  
  local env_name="$1"
  local profile="${2:-basic}"
  
  echo "Creating astronomy environment: $env_name (profile: $profile)"
  
  # Base packages for all astronomy environments
  local base_packages="python=3.10 numpy scipy matplotlib astropy pandas jupyter ipython notebook"
  local extra_packages=""
  
  case "$profile" in
    "basic")
      extra_packages="photutils specutils regions astroquery"
      ;;
    "jwst")
      extra_packages="photutils specutils regions astroquery jwst stdatamodels asdf"
      ;;
    "general")
      extra_packages="photutils specutils regions astroquery aplpy reproject astroscrappy ccdproc"
      ;;
    "spectroscopy")
      extra_packages="specutils linetools pyspeckit specreduce"
      ;;
    "photometry")
      extra_packages="photutils sep sextractor-python"
      ;;
    *)
      echo "Unknown profile: $profile. Using basic."
      extra_packages="photutils specutils regions astroquery"
      ;;
  esac
  
  conda create -n "$env_name" $base_packages $extra_packages -c conda-forge -c astropy -y
  
  echo ""
  echo "Environment '$env_name' created with profile '$profile'"
  echo "Activate with: conda activate $env_name"
  echo "Installed packages: $base_packages $extra_packages"
}

# Install common astronomy packages in current environment
astro_install() {
  local packages="$*"
  if [[ -z "$packages" ]]; then
    echo "Usage: astro_install <package1> [package2] ..."
    echo "Common packages: photutils, specutils, regions, astroquery, aplpy, reproject"
    echo "                 jwst, stdatamodels, asdf, ccdproc, astroscrappy"
    return 1
  fi
  
  echo "Installing astronomy packages: $packages"
  conda install $packages -c conda-forge -c astropy -y
}

# Quick package installer for common astronomy tools
astro_quick() {
  local preset="$1"
  case "$preset" in
    "core")
      astro_install astropy photutils specutils regions astroquery
      ;;
    "jwst")
      astro_install jwst stdatamodels asdf
      ;;
    "imaging")
      astro_install photutils aplpy reproject astroscrappy ccdproc
      ;;
    "spectroscopy")
      astro_install specutils linetools pyspeckit
      ;;
    *)
      echo "Usage: astro_quick <preset>"
      echo "Presets:"
      echo "  core         - astropy, photutils, specutils, regions, astroquery"
      echo "  jwst         - JWST pipeline and related tools"
      echo "  imaging      - Image processing and visualization"
      echo "  spectroscopy - Spectroscopy analysis tools"
      ;;
  esac
}

# Quick FITS file info
fitsinfo() {
  if [[ -z "$1" ]]; then
    echo "Usage: fitsinfo <fits_file>"
    return 1
  fi
  
  if command -v python3 &> /dev/null; then
    python3 -c "
try:
    from astropy.io import fits
    import sys
    hdul = fits.open('$1')
    print(f'File: $1')
    print(f'Number of HDUs: {len(hdul)}')
    for i, hdu in enumerate(hdul):
        print(f'HDU {i}: {type(hdu).__name__} - {hdu.header.get(\"EXTNAME\", \"PRIMARY\")}')
        if hasattr(hdu, 'data') and hdu.data is not None:
            print(f'  Data shape: {hdu.data.shape}')
            print(f'  Data type: {hdu.data.dtype}')
    hdul.close()
except ImportError:
    print('astropy not available in current environment')
except Exception as e:
    print(f'Error reading FITS file: {e}')
"
  else
    echo "Python not available"
  fi
}

# Quick DS9 launcher (if available)
ds9() {
  if command -v ds9 &> /dev/null; then
    command ds9 "$@" &
  else
    echo "DS9 not found in PATH"
  fi
}

# Search for files by astronomical object name or coordinates
astro_find() {
  if [[ -z "$1" ]]; then
    echo "Usage: astro_find <pattern> [directory]"
    echo "Searches for files containing astronomical object names or patterns"
    return 1
  fi
  
  local search_dir="${2:-.}"
  find "$search_dir" -type f \( -name "*.fits" -o -name "*.fit" -o -name "*.fts" -o -name "*.py" -o -name "*.ipynb" \) -exec grep -l -i "$1" {} \; 2>/dev/null
}

# Convert between coordinate systems (requires astropy)
coord_convert() {
  if [[ $# -lt 3 ]]; then
    echo "Usage: coord_convert <ra> <dec> <frame_to>"
    echo "Example: coord_convert '10h 00m 00s' '+20d 00m 00s' galactic"
    return 1
  fi
  
  python3 -c "
try:
    from astropy.coordinates import SkyCoord
    import astropy.units as u
    coord = SkyCoord('$1', '$2', frame='icrs')
    converted = coord.transform_to('$3')
    print(f'Original (ICRS): {coord.to_string(\"hmsdms\")}')
    print(f'Converted ($3): {converted.to_string(\"decimal\")}')
except ImportError:
    print('astropy not available in current environment')
except Exception as e:
    print(f'Error: {e}')
"
}
