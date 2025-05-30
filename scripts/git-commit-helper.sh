#!/usr/bin/env bash

# ===================
# Git Commit Helper Script
# ===================
# Interactive script to help create well-formatted commit messages

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Git Commit Helper${NC}"
echo -e "${CYAN}Creating a well-formatted commit message...${NC}"
echo ""

# Check if there are staged changes
if ! git diff --cached --quiet; then
    echo -e "${GREEN}✓ Staged changes detected${NC}"
else
    echo -e "${YELLOW}⚠ No staged changes found. Stage some files first with 'git add'${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}Select commit type:${NC}"
echo "1) feat      - New feature or functionality"
echo "2) fix       - Bug fix"  
echo "3) docs      - Documentation changes"
echo "4) style     - Formatting, no code change"
echo "5) refactor  - Code restructuring"
echo "6) test      - Adding or modifying tests"
echo "7) chore     - Maintenance, dependencies"
echo "8) perf      - Performance improvements"
echo "9) data      - Data processing/analysis updates"
echo "10) science  - Scientific analysis/algorithms"
echo "11) paper    - Paper/publication related"
echo "12) config   - Configuration changes"
echo ""

read -p "Enter choice (1-12): " type_choice

case $type_choice in
    1) commit_type="feat" ;;
    2) commit_type="fix" ;;
    3) commit_type="docs" ;;
    4) commit_type="style" ;;
    5) commit_type="refactor" ;;
    6) commit_type="test" ;;
    7) commit_type="chore" ;;
    8) commit_type="perf" ;;
    9) commit_type="data" ;;
    10) commit_type="science" ;;
    11) commit_type="paper" ;;
    12) commit_type="config" ;;
    *) echo -e "${RED}Invalid choice${NC}"; exit 1 ;;
esac

echo ""
echo -e "${BLUE}Common scopes for astronomy:${NC}"
echo "pipeline, photometry, spectro, plotting, io, utils, models"
echo "calib, jwst, hst, fits, coords, stats, ml"
echo ""
read -p "Enter scope (optional, press enter to skip): " scope

echo ""
read -p "Enter short description (imperative mood, <50 chars): " subject

# Validate subject length
if [ ${#subject} -gt 50 ]; then
    echo -e "${YELLOW}⚠ Subject is ${#subject} characters. Consider shortening.${NC}"
fi

echo ""
echo -e "${BLUE}Enter detailed description (optional):${NC}"
echo -e "${CYAN}Explain what and why, not how. Press Ctrl+D when done.${NC}"
body=$(cat)

# Construct commit message
if [ -n "$scope" ]; then
    commit_msg="$commit_type($scope): $subject"
else
    commit_msg="$commit_type: $subject"
fi

if [ -n "$body" ]; then
    commit_msg="$commit_msg

$body"
fi

echo ""
echo -e "${BLUE}Preview of commit message:${NC}"
echo -e "${GREEN}================================${NC}"
echo "$commit_msg"
echo -e "${GREEN}================================${NC}"
echo ""

read -p "Commit with this message? (y/N): " confirm

if [[ $confirm =~ ^[Yy]$ ]]; then
    git commit -m "$commit_msg"
    echo -e "${GREEN}✓ Commit created successfully!${NC}"
else
    echo -e "${YELLOW}Commit cancelled${NC}"
fi
