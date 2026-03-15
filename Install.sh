#!/bin/bash

# ─────────────────────────────────────────────
#   C/C++ Dev Tools Installer
#   Auto-detects distro and installs resources
# ─────────────────────────────────────────────

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

print_banner() {
    echo -e "${CYAN}${BOLD}"
    echo "  ██████╗    ██████╗     ██████╗ "
    echo " ██╔════╝   ██╔════╝    ██╔════╝ "
    echo " ██║        ██║         ██║      "
    echo " ██║        ██║         ██║      "
    echo " ╚██████╗██╗╚██████╗██╗ ╚██████╗ "
    echo "  ╚═════╝╚═╝ ╚═════╝╚═╝  ╚═════╝ "
    echo -e "${NC}"
    echo -e "${BOLD}  C/C++ Development Tools Installer${NC}"
    echo -e "  ─────────────────────────────────\n"
}

log_info()    { echo -e "${GREEN}[INFO]${NC}  $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC}  $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }
log_section() { echo -e "\n${CYAN}${BOLD}>>> $1${NC}"; }

# ─── Check root / sudo ───────────────────────
check_privileges() {
    if [ "$EUID" -ne 0 ]; then
        if ! command -v sudo &>/dev/null; then
            log_error "This script must be run as root or with sudo."
            exit 1
        fi
        SUDO="sudo"
        log_warn "Not running as root — using sudo."
    else
        SUDO=""
    fi
}

# ─── Detect Distro ───────────────────────────
detect_distro() {
    log_section "Detecting Distribution"

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO_NAME="${NAME}"
        DISTRO_ID="${ID}"
        DISTRO_ID_LIKE="${ID_LIKE:-}"
        DISTRO_VERSION="${VERSION_ID:-unknown}"
    elif command -v lsb_release &>/dev/null; then
        DISTRO_NAME=$(lsb_release -ds)
        DISTRO_ID=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
        DISTRO_ID_LIKE=""
        DISTRO_VERSION=$(lsb_release -rs)
    elif [ -f /etc/redhat-release ]; then
        DISTRO_NAME=$(cat /etc/redhat-release)
        DISTRO_ID="rhel"
        DISTRO_ID_LIKE="rhel"
        DISTRO_VERSION="unknown"
    else
        log_error "Cannot detect distribution. Exiting."
        exit 1
    fi

    log_info "Distro   : ${DISTRO_NAME}"
    log_info "ID       : ${DISTRO_ID}"
    log_info "Based on : ${DISTRO_ID_LIKE:-${DISTRO_ID}}"
    log_info "Version  : ${DISTRO_VERSION}"
}

# ─── Package Lists ───────────────────────────
PACKAGES_DEBIAN="build-essential gcc g++ gdb cmake make git clang clang-format clangd valgrind libstdc++-dev"
PACKAGES_FEDORA="gcc gcc-c++ gdb cmake make git clang clang-tools-extra valgrind libstdc++-devel"
PACKAGES_ARCH="base-devel gcc gdb cmake git clang valgrind"
PACKAGES_OPENSUSE="gcc gcc-c++ gdb cmake make git clang valgrind libstdc++-devel"
PACKAGES_ALPINE="build-base gcc g++ gdb cmake make git clang valgrind"
PACKAGES_VOID="base-devel gcc gdb cmake git clang valgrind"
PACKAGES_GENTOO="sys-devel/gcc sys-devel/gdb dev-util/cmake dev-vcs/git sys-devel/clang dev-util/valgrind"

# ─── Install Functions ───────────────────────

install_debian_based() {
    log_section "Debian/Ubuntu-based System Detected"
    log_info "Updating package lists..."
    $SUDO apt-get update -y
    log_info "Installing C/C++ development tools..."
    $SUDO apt-get install -y $PACKAGES_DEBIAN
}

install_fedora_based() {
    log_section "Fedora/RHEL/CentOS-based System Detected"
    if command -v dnf &>/dev/null; then
        log_info "Using dnf..."
        $SUDO dnf groupinstall -y "Development Tools"
        $SUDO dnf install -y $PACKAGES_FEDORA
    elif command -v yum &>/dev/null; then
        log_info "Using yum..."
        $SUDO yum groupinstall -y "Development Tools"
        $SUDO yum install -y $PACKAGES_FEDORA
    else
        log_error "Neither dnf nor yum found."
        exit 1
    fi
}

install_arch_based() {
    log_section "Arch-based System Detected"
    log_info "Updating and installing via pacman..."
    $SUDO pacman -Syu --noconfirm
    $SUDO pacman -S --noconfirm $PACKAGES_ARCH
}

install_opensuse_based() {
    log_section "openSUSE-based System Detected"
    log_info "Installing via zypper..."
    $SUDO zypper refresh
    $SUDO zypper install -y $PACKAGES_OPENSUSE
}

install_alpine_based() {
    log_section "Alpine Linux Detected"
    log_info "Installing via apk..."
    $SUDO apk update
    $SUDO apk add $PACKAGES_ALPINE
}

install_void_based() {
    log_section "Void Linux Detected"
    log_info "Installing via xbps-install..."
    $SUDO xbps-install -Syu
    $SUDO xbps-install -y $PACKAGES_VOID
}

install_gentoo_based() {
    log_section "Gentoo-based System Detected"
    log_info "Installing via emerge..."
    $SUDO emerge --sync
    $SUDO emerge -av $PACKAGES_GENTOO
}

# ─── Verify Installation ─────────────────────
verify_install() {
    log_section "Verifying Installation"
    local tools="gcc g++ gdb cmake make git clang"
    local all_ok=true

    for tool in $tools; do
        if command -v "$tool" &>/dev/null; then
            local ver
            ver=$("$tool" --version 2>/dev/null | head -n1)
            log_info "${tool}: ${ver}"
        else
            log_warn "${tool} not found in PATH."
            all_ok=false
        fi
    done

    echo ""
    if $all_ok; then
        echo -e "${GREEN}${BOLD}✔  All tools installed successfully!${NC}"
    else
        echo -e "${YELLOW}${BOLD}⚠  Some tools may not be installed. Check the warnings above.${NC}"
    fi
}

# ─── Main ─────────────────────────────────────
main() {
    print_banner
    check_privileges
    detect_distro
    route_install
    verify_install

    echo -e "\n${CYAN}Happy coding in C/C++! 🚀${NC}\n"
}

main