#!/bin/bash

# ===================
# Git Commit Quick Reference
# ===================

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}📝 Git Commit Message Quick Reference${NC}"
echo -e "${BLUE}====================================${NC}\n"

echo -e "${YELLOW}Format:${NC} ${GREEN}<type>(<scope>): <subject>${NC}"
echo -e "${YELLOW}        ${NC}"
echo -e "${YELLOW}        <body>${NC}"
echo -e "${YELLOW}        ${NC}"
echo -e "${YELLOW}        <footer>${NC}\n"

echo -e "${PURPLE}🏷️  Types:${NC}"
echo -e "  ${GREEN}feat${NC}     ✨ New feature or functionality"
echo -e "  ${GREEN}fix${NC}      🐛 Bug fix"
echo -e "  ${GREEN}docs${NC}     📚 Documentation changes"
echo -e "  ${GREEN}data${NC}     📊 Data processing/analysis updates"
echo -e "  ${GREEN}science${NC}  🔬 Scientific analysis/algorithms"
echo -e "  ${GREEN}perf${NC}     ⚡ Performance improvements"
echo -e "  ${GREEN}refactor${NC} ♻️  Code restructuring"
echo -e "  ${GREEN}test${NC}     🧪 Adding or modifying tests"
echo -e "  ${GREEN}chore${NC}    🔧 Maintenance, dependencies"
echo -e "  ${GREEN}config${NC}   ⚙️  Configuration changes"
echo -e "  ${GREEN}paper${NC}    📄 Paper/publication related\n"

echo -e "${CYAN}🔭 Astronomy Scopes:${NC}"
echo -e "  ${YELLOW}pipeline${NC}   photometry   spectro     plotting"
echo -e "  ${YELLOW}io${NC}         utils        models      calib"
echo -e "  ${YELLOW}jwst${NC}       hst          fits        coords"
echo -e "  ${YELLOW}stats${NC}      ml           analysis    reduction\n"

echo -e "${PURPLE}📋 Guidelines:${NC}"
echo -e "  • Subject: imperative mood, lowercase, max 50 chars"
echo -e "  • Body: explain what & why, wrap at 72 chars"
echo -e "  • Footer: reference issues, breaking changes\n"

echo -e "${GREEN}💡 Examples:${NC}"
echo -e "  ${CYAN}feat(photometry): add PSF fitting for crowded fields${NC}"
echo -e "  ${CYAN}fix(jwst): correct WCS header parsing for NIRCam${NC}"
echo -e "  ${CYAN}data(calib): update flat field corrections${NC}"
echo -e "  ${CYAN}science(spectro): improve continuum fitting algorithm${NC}\n"

echo -e "${YELLOW}🚀 Quick Commands:${NC}"
echo -e "  ${GREEN}gci${NC}        Start interactive commit helper"
echo -e "  ${GREEN}g cmsg-help${NC} Show commit template"
echo -e "  ${GREEN}g cfeat${NC}     Quick feature commit: g cfeat scope \"message\""
echo -e "  ${GREEN}g cfix${NC}      Quick fix commit: g cfix scope \"message\""
echo -e "  ${GREEN}g cdata${NC}     Quick data commit: g cdata scope \"message\""
echo -e "  ${GREEN}g cscience${NC}  Quick science commit: g cscience scope \"message\""
