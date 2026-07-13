#!/usr/bin/env bash
# VibeGuard: Security Skills for Vibe Coders - Installer
# Supports: Claude Code (.claude/skills/), Cursor (.cursor/rules/), OpenCode (.opencode/skills/)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SOURCE="${SCRIPT_DIR}/skills"
INSTALL_COUNT=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_ok()   { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_err()  { echo -e "${RED}[ERROR]${NC} $1"; }

install_to_target() {
    local target_dir="$1"
    local label="$2"

    if [[ ! -d "$target_dir" ]]; then
        log_info "Creating ${label} directory: ${target_dir}"
        mkdir -p "$target_dir"
    fi

    for skill_dir in "${SKILLS_SOURCE}"/*/; do
        if [[ -d "$skill_dir" ]]; then
            local skill_name
            skill_name="$(basename "$skill_dir")"
            local dest_dir="${target_dir}/${skill_name}"

            if [[ -d "$dest_dir" ]]; then
                log_warn "Overwriting existing skill: ${skill_name}"
                rm -rf "$dest_dir"
            fi

            cp -r "$skill_dir" "$dest_dir"
            ((INSTALL_COUNT++)) || true
            log_ok "Installed ${skill_name} -> ${dest_dir}"
        fi
    done
}

detect_and_install() {
    local installed_something=false

    # Claude Code
    if command -v claude &> /dev/null || [[ -d "$HOME/.claude" ]]; then
        log_info "Claude Code detected."
        install_to_target "$HOME/.claude/skills" "Claude Code"
        installed_something=true
    fi

    # Cursor
    if command -v cursor &> /dev/null || [[ -d "$HOME/.cursor" ]] || [[ -d "$HOME/Library/Application Support/Cursor" ]]; then
        log_info "Cursor detected."
        # Cursor uses .cursor/rules/ for rules, but we can also put skills in .cursor/skills/
        install_to_target "$HOME/.cursor/skills" "Cursor"
        installed_something=true
    fi

    # OpenCode
    if command -v opencode &> /dev/null || [[ -d "$HOME/.opencode" ]] || [[ -d "$HOME/.config/opencode" ]]; then
        log_info "OpenCode detected."
        local opencode_dir="${HOME}/.opencode"
        if [[ -d "$HOME/.config/opencode" ]]; then
            opencode_dir="$HOME/.config/opencode"
        fi
        install_to_target "${opencode_dir}/skills" "OpenCode"
        installed_something=true
    fi

    if [[ "$installed_something" == false ]]; then
        log_warn "No supported editor detected. Installing to fallback locations."
        install_to_target "$HOME/.claude/skills" "Claude Code (fallback)"
        install_to_target "$HOME/.cursor/skills" "Cursor (fallback)"
        install_to_target "$HOME/.opencode/skills" "OpenCode (fallback)"
    fi
}

print_summary() {
    echo ""
    echo "========================================"
    echo "  VibeGuard Installed"
    echo "========================================"
    echo "Total skills installed: ${INSTALL_COUNT}"
    echo ""
    echo "Next steps:"
    echo "  1. Restart your AI coding assistant"
    echo "  2. Type a security-related request to auto-activate a skill"
    echo "  3. Or reference a skill directly: 'Use the owasp-code-review skill'"
    echo ""
    echo "Skills included:"
    ls -1 "${SKILLS_SOURCE}" | sed 's/^/  - /'
    echo ""
}

main() {
    echo "========================================"
    echo "  VibeGuard Installer"
    echo "========================================"
    echo ""

    if [[ ! -d "$SKILLS_SOURCE" ]]; then
        log_err "Skills source directory not found: ${SKILLS_SOURCE}"
        log_err "Make sure you run this script from the extracted pack directory."
        exit 1
    fi

    detect_and_install
    print_summary
}

main "$@"
