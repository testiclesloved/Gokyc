#!/bin/bash

# GoKYC Ultimate - Standalone Universal Installer
# Repository: https://github.com/testiclesloved/Gokyc.git
# Exclusive access for Cyber Family members only

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration
REPO_URL="https://github.com/testiclesloved/Gokyc.git"
INSTALL_DIR="$HOME/gokyc_ultimate"
BINARY_NAME="gokyc_ultimate"
ZIP_FILE="gokyc_release.zip"
RELEASE_PASSWORD="2922"

# ASCII Banner
show_banner() {
    clear
    echo -e "${PURPLE}"
    cat << 'EOF'
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣶⠖⠀⠀⠲⣶⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⡿⠋⠀⠀⠀⠀⠀⠀⠙⢿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣾⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣷⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣾⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣷⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣿⣿⣿⣇⣤⠶⠛⣛⣉⣙⡛⠛⢶⣄⣸⣿⣿⣿⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣀⣿⣿⣿⡟⢁⣴⣿⣿⣿⣿⣿⣿⣦⡈⢿⣿⣿⣿⣀⡀⠀⠀⠀⠀
⠀⠀⢠⣴⣿⣿⣿⣿⡟⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡌⢿⣿⣿⣿⣿⣦⡄⠀⠀
⠀⣴⣿⣿⡿⠿⢛⣻⡇⢸⡟⠻⣿⣿⣿⣿⣿⡿⠟⢻⡇⣸⣛⡛⠿⣿⣿⣿⣦⠀
⢸⣿⡿⠋⠀⠀⢸⣿⣿⡜⢧⣄⣀⣉⡿⣿⣉⣀⣠⣼⢁⣿⣿⡇⠀⠀⠙⢿⣿⡆
⣿⣿⠁⠀⠀⠀⠈⣿⣿⡇⣿⡿⠛⣿⣵⣮⣿⡟⢻⡿⢨⣿⣿⠀⠀⠀⠀⠈⣿⣿
⢿⡟⠀⠀⠀⠀⠀⠘⣿⣷⣤⣄⡀⣿⣿⣿⣿⢁⣤⣶⣿⣿⠃⠀⠀⠀⠀⠀⣿⡟
⠘⠇⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⡇⢿⣿⣿⣿⢸⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠻⠃
⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⢩⣦⣘⡘⠋⣛⣸⡍⠁⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀
⠀⠀⠘⢿⣷⣤⣤⣄⣤⣤⣶⣿⣿⣿⡿⢿⣿⣿⣿⣷⣤⣤⣠⣤⣴⣾⡿⠁⠀⠀
⠀⠀⠀⠀⠉⠛⠿⠿⠿⡿⠿⠿⠛⠉⠀⠀⠉⠛⠿⠿⣿⠿⠿⠿⠛⠉⠀⠀

I AM MR NOBODY I WORK FOR THE 
Cyber family only!!
EOF
    echo -e "${NC}"
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                        🚀 GoKYC ULTIMATE INSTALLER 🚀                       ║${NC}"
    echo -e "${CYAN}║                   Advanced Router Exploitation Framework                     ║${NC}"
    echo -e "${CYAN}║                          Exclusive Installation                             ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo
}

# Detect operating system (Linux and Termux only)
detect_os() {
    # Check for Termux first (most reliable method)
    if [[ -n "${TERMUX_VERSION:-}" ]] || [[ -d "/data/data/com.termux" ]] || [[ -n "${PREFIX:-}" && "$PREFIX" == *"com.termux"* ]]; then
        echo "termux"
        return
    fi
    
    # Check if running in Termux environment (additional check)
    if command -v pkg >/dev/null 2>&1 && [[ -n "${PREFIX:-}" ]]; then
        echo "termux"
        return
    fi
    
    # Check for standard Linux
    case "$OSTYPE" in
        linux-gnu*|linux-android*)
            echo "linux"
            ;;
        *)
            # Final fallback - check for Android
            if uname -a | grep -qi android || [[ -d "/system/bin" ]]; then
                echo "termux"  # Assume Termux if Android
            else
                echo "unsupported"
            fi
            ;;
    esac
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install dependencies based on OS
install_dependencies() {
    local os="$1"
    
    echo -e "${BLUE}[+] Installing dependencies for $os...${NC}"
    
    case $os in
        "termux")
            echo -e "${YELLOW}[*] Termux detected - installing packages...${NC}"
            
            # Update package lists
            echo -e "${BLUE}[*] Updating Termux repositories...${NC}"
            pkg update -y
            
            # Install essential packages
            echo -e "${BLUE}[*] Installing Go compiler...${NC}"
            pkg install -y golang || {
                echo -e "${RED}[!] Failed to install golang${NC}"
                exit 1
            }
            
            echo -e "${BLUE}[*] Installing network tools...${NC}"
            pkg install -y git wget unzip openssh iproute2 curl || {
                echo -e "${RED}[!] Failed to install network tools${NC}"
                exit 1
            }
            
            # Optional but useful packages
            echo -e "${BLUE}[*] Installing additional tools...${NC}"
            pkg install -y termux-api netcat-openbsd nmap || {
                echo -e "${YELLOW}[!] Some optional packages failed to install (continuing)${NC}"
            }
            
            # Set up storage access
            if [[ ! -d "$HOME/storage" ]]; then
                echo -e "${BLUE}[*] Setting up storage access...${NC}"
                termux-setup-storage || {
                    echo -e "${YELLOW}[!] Storage setup failed (continuing)${NC}"
                }
            fi
            ;;
            
        "linux")
            if command_exists apt-get; then
                echo -e "${YELLOW}[*] Using apt package manager...${NC}"
                sudo apt-get update
                sudo apt-get install -y golang git wget unzip openssh-client iproute2 curl wireless-tools
            elif command_exists yum; then
                echo -e "${YELLOW}[*] Using yum package manager...${NC}"
                sudo yum update -y
                sudo yum install -y golang git wget unzip openssh-clients iproute curl wireless-tools
            elif command_exists pacman; then
                echo -e "${YELLOW}[*] Using pacman package manager...${NC}"
                sudo pacman -Syu --noconfirm
                sudo pacman -S --noconfirm go git wget unzip openssh iproute2 curl wireless_tools
            else
                echo -e "${RED}[!] Unsupported Linux distribution${NC}"
                exit 1
            fi
            ;;
            
        "unsupported")
            echo -e "${RED}[!] Unsupported operating system${NC}"
            echo -e "${CYAN}[*] GoKYC Ultimate supports Linux and Android (Termux) only${NC}"
            echo -e "${CYAN}[*] Detected: $os${NC}"
            echo -e "${CYAN}[*] Please use a supported platform${NC}"
            exit 1
            ;;
            
        *)
            echo -e "${RED}[!] Unknown operating system: $os${NC}"
            echo -e "${CYAN}[*] GoKYC Ultimate supports Linux and Android (Termux) only${NC}"
            exit 1
            ;;
    esac
    
    echo -e "${GREEN}[✓] Dependencies installed successfully${NC}"
}

# Verify Go installation
verify_go() {
    echo -e "${BLUE}[+] Verifying Go installation...${NC}"
    
    # Check if go command exists
    if ! command_exists go; then
        echo -e "${RED}[!] Go is not installed or not in PATH${NC}"
        
        # Try to find Go in common Termux locations
        local termux_go_paths=("$PREFIX/bin/go" "/data/data/com.termux/files/usr/bin/go")
        for go_path in "${termux_go_paths[@]}"; do
            if [[ -x "$go_path" ]]; then
                echo -e "${YELLOW}[*] Found Go at: $go_path${NC}"
                export PATH="$(dirname "$go_path"):$PATH"
                break
            fi
        done
        
        # Check again
        if ! command_exists go; then
            echo -e "${RED}[!] Go installation not found${NC}"
            return 1
        fi
    fi
    
    # Get version
    local go_version
    go_version=$(go version 2>/dev/null | awk '{print $3}' | sed 's/go//' || echo "unknown")
    echo -e "${GREEN}[✓] Go version: $go_version${NC}"
    
    # Set Go environment for Termux
    if [[ "$(detect_os)" == "termux" ]]; then
        export GOOS=linux
        export GOARCH=arm64
        echo -e "${CYAN}[*] Termux Go environment configured${NC}"
    fi
    
    return 0
}

# Extract protected release files
extract_release() {
    echo -e "${BLUE}[+] Extracting GoKYC Ultimate protected files...${NC}"
    
    # Check if zip file exists
    if [[ ! -f "$ZIP_FILE" ]]; then
        echo -e "${RED}[!] Protected release file not found: $ZIP_FILE${NC}"
        echo -e "${CYAN}[*] Make sure you cloned the complete repository${NC}"
        exit 1
    fi
    
    # Prompt for extraction password
    echo -e "${YELLOW}[*] This is a protected Cyber Family release${NC}"
    echo -e "${YELLOW}[*] Enter the release password:${NC}"
    read -s -p "Password: " EXTRACT_PASSWORD
    echo
    
    # Verify password
    if [[ "$EXTRACT_PASSWORD" != "$RELEASE_PASSWORD" ]]; then
        echo -e "${RED}[!] Invalid password - Access Denied${NC}"
        echo -e "${CYAN}[*] Contact the Cyber Family for authorized access${NC}"
        exit 1
    fi
    
    # Extract with password
    if command_exists unzip; then
        if unzip -P "$EXTRACT_PASSWORD" "$ZIP_FILE" >/dev/null 2>&1; then
            echo -e "${GREEN}[✓] Protected files extracted successfully${NC}"
            echo -e "${CYAN}[*] Welcome to the Cyber Family elite system${NC}"
        else
            echo -e "${RED}[!] Extraction failed - corrupted file or wrong password${NC}"
            exit 1
        fi
    else
        echo -e "${RED}[!] unzip command not available${NC}"
        exit 1
    fi
    
    # Clean up zip file for security
    rm -f "$ZIP_FILE"
    echo -e "${GREEN}[✓] Security cleanup completed${NC}"
}

# Build the application
build_application() {
    echo -e "${BLUE}[+] Building GoKYC Ultimate exclusive system...${NC}"
    
    # Verify essential files exist
    local required_files=("gokyc_ultimate.go" "database.json" "usernamesandpass.txt" "asciiart.txt" "auth.json")
    
    echo -e "${YELLOW}[*] Checking essential files...${NC}"
    for file in "${required_files[@]}"; do
        if [[ ! -f "$file" ]]; then
            echo -e "${RED}[!] Essential file missing: $file${NC}"
            echo -e "${CYAN}[*] Available files:${NC}"
            ls -la
            return 1
        else
            echo -e "${GREEN}[✓] Found: $file${NC}"
        fi
    done
    
    # Initialize Go module if not exists
    if [[ ! -f "go.mod" ]]; then
        echo -e "${YELLOW}[*] Initializing Go module...${NC}"
        go mod init github.com/testiclesloved/Gokyc || {
            echo -e "${RED}[!] Failed to initialize Go module${NC}"
            return 1
        }
    fi
    
    # Download dependencies with verbose output
    echo -e "${YELLOW}[*] Downloading Go dependencies...${NC}"
    if ! go mod tidy; then
        echo -e "${RED}[!] Failed to download dependencies${NC}"
        echo -e "${CYAN}[*] Trying with proxy settings...${NC}"
        export GOPROXY=https://proxy.golang.org,direct
        export GOSUMDB=sum.golang.org
        go mod tidy || {
            echo -e "${RED}[!] Dependency download failed${NC}"
            return 1
        }
    fi
    
    # Build the application with verbose output
    echo -e "${YELLOW}[*] Compiling GoKYC Ultimate exclusive system...${NC}"
    echo -e "${CYAN}[*] This may take a few minutes...${NC}"
    
    if go build -v -o "$BINARY_NAME" gokyc_ultimate.go 2>&1; then
        echo -e "${GREEN}[✓] Build completed successfully${NC}"
    else
        echo -e "${RED}[!] Build failed${NC}"
        echo -e "${CYAN}[*] Trying with CGO disabled...${NC}"
        CGO_ENABLED=0 go build -o "$BINARY_NAME" gokyc_ultimate.go || {
            echo -e "${RED}[!] Build failed even with CGO disabled${NC}"
            return 1
        }
    fi
    
    # Make executable
    chmod +x "$BINARY_NAME"
    
    # Verify binary works
    if [[ -x "$BINARY_NAME" ]]; then
        echo -e "${GREEN}[✓] GoKYC Ultimate is ready for exclusive use${NC}"
        return 0
    else
        echo -e "${RED}[!] Binary creation failed${NC}"
        return 1
    fi
}

# Create launch script
create_launcher() {
    echo -e "${BLUE}[+] Creating launch script...${NC}"
    
    cat > "launch_gokyc.sh" << 'EOF'
#!/bin/bash

# GoKYC Ultimate Launcher
# Exclusive access for Cyber Family members only

echo "🚀 Launching GoKYC Ultimate..."
echo "👑 Exclusive Cyber Family System"
echo

# Check if binary exists
if [[ ! -f "./gokyc_ultimate" ]]; then
    echo "❌ GoKYC Ultimate not found"
    echo "💡 Run ./install.sh first"
    exit 1
fi

# Launch with exclusive access
./gokyc_ultimate
EOF
    
    chmod +x "launch_gokyc.sh"
    echo -e "${GREEN}[✓] Launch script created${NC}"
}

# Final setup and instructions
final_setup() {
    echo -e "${GREEN}"
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                    🎉 EXCLUSIVE INSTALLATION COMPLETE! 🎉                   ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    echo -e "${CYAN}📍 Installation Directory: $PWD${NC}"
    echo -e "${CYAN}🚀 Executable: ./$BINARY_NAME${NC}"
    echo -e "${CYAN}🎯 Launcher: ./launch_gokyc.sh${NC}"
    echo
    
    echo -e "${YELLOW}🔧 USAGE (Exclusive Access):${NC}"
    echo -e "${CYAN}  ./$BINARY_NAME${NC}"
    echo -e "${CYAN}  # OR${NC}"
    echo -e "${CYAN}  ./launch_gokyc.sh${NC}"
    echo
    
    echo -e "${YELLOW}🔐 EXCLUSIVE AUTHENTICATION (5 Users Only):${NC}"
    echo -e "${CYAN}  The Elder    → whoarewe1!${NC}"
    echo -e "${CYAN}  Stoic        → whoarewe55j${NC}"
    echo -e "${CYAN}  Sniper       → whoareweyyz${NC}"
    echo -e "${CYAN}  Executioner  → whoarewe77p${NC}"
    echo -e "${CYAN}  Root         → whoamiroot${NC}"
    echo
    
    echo -e "${YELLOW}📊 SYSTEM FEATURES:${NC}"
    echo -e "${CYAN}  - 58+ router operating systems supported${NC}"
    echo -e "${CYAN}  - 1400+ credential combinations tested${NC}"
    echo -e "${CYAN}  - Intelligent adaptive attacks with rate limiting${NC}"
    echo -e "${CYAN}  - Automated admin user creation${NC}"
    echo -e "${CYAN}  - Cross-platform compatibility${NC}"
    echo -e "${CYAN}  - Comprehensive logging and reporting${NC}"
    echo
    
    echo -e "${RED}⚠️  EXCLUSIVE ACCESS WARNING:${NC}"
    echo -e "${YELLOW}- This tool is restricted to 5 authorized users only${NC}"
    echo -e "${YELLOW}- Unauthorized access attempts are logged and monitored${NC}"
    echo -e "${YELLOW}- Use only on networks you own or have permission to test${NC}"
    echo -e "${YELLOW}- For Cyber Family members only - no exceptions${NC}"
    echo
    
    echo -e "${GREEN}✅ GoKYC Ultimate exclusive system is ready!${NC}"
    echo -e "${PURPLE}👑 Welcome to the Digital Elite, Cyber Family Member!${NC}"
    echo
    echo -e "${CYAN}🎯 To start your exclusive session:${NC}"
    echo -e "${CYAN}   ./$BINARY_NAME${NC}"
    echo
}

# Error handling
trap 'echo -e "\n${RED}[!] Installation interrupted${NC}"; exit 130' INT TERM

# Main installation function
main() {
    show_banner
    
    echo -e "${BLUE}[+] Starting GoKYC Ultimate exclusive installation...${NC}"
    echo -e "${CYAN}[*] Cyber Family members only - unauthorized access forbidden${NC}"
    echo
    
    # Detect OS with verbose output
    local os=$(detect_os)
    echo -e "${GREEN}[✓] Detected OS: $os${NC}"
    
    # Show environment info for debugging
    if [[ "$os" == "termux" ]]; then
        echo -e "${CYAN}[*] Termux Environment Details:${NC}"
        echo -e "${CYAN}    TERMUX_VERSION: ${TERMUX_VERSION:-not set}${NC}"
        echo -e "${CYAN}    PREFIX: ${PREFIX:-not set}${NC}"
        echo -e "${CYAN}    HOME: $HOME${NC}"
        echo -e "${CYAN}    PWD: $PWD${NC}"
    fi
    
    # Install dependencies with error handling
    echo -e "${BLUE}[+] Installing dependencies...${NC}"
    if ! install_dependencies "$os"; then
        echo -e "${RED}[!] Dependency installation failed${NC}"
        exit 1
    fi
    
    # Verify Go with detailed output
    echo -e "${BLUE}[+] Verifying Go installation...${NC}"
    if ! verify_go; then
        echo -e "${RED}[!] Go verification failed${NC}"
        echo -e "${CYAN}[*] Trying to install Go manually for Termux...${NC}"
        if [[ "$os" == "termux" ]]; then
            pkg install -y golang
            if ! verify_go; then
                echo -e "${RED}[!] Manual Go installation also failed${NC}"
                exit 1
            fi
        else
            exit 1
        fi
    fi
    
    # Extract protected release
    echo -e "${BLUE}[+] Processing protected release...${NC}"
    if ! extract_release; then
        echo -e "${RED}[!] Release extraction failed${NC}"
        exit 1
    fi
    
    # Build application
    echo -e "${BLUE}[+] Building exclusive system...${NC}"
    if ! build_application; then
        echo -e "${RED}[!] Build process failed${NC}"
        exit 1
    fi
    
    # Create launcher
    create_launcher
    
    # Final setup
    final_setup
}

# Security check - warn if running as root (except Termux)
if [[ $EUID -eq 0 ]] && [[ ! -d "/data/data/com.termux" ]]; then
    echo -e "${YELLOW}[!] Running as root. This is not recommended for security.${NC}"
    echo -e "${YELLOW}[?] Continue anyway? (y/N):${NC}"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}[*] Installation cancelled for security${NC}"
        exit 0
    fi
fi

# Verify we're in a git repository with the protected files
if [[ ! -f "$ZIP_FILE" ]]; then
    echo -e "${RED}[!] Protected release file not found: $ZIP_FILE${NC}"
    echo -e "${CYAN}[*] This installer must be run from the cloned GoKYC repository${NC}"
    echo -e "${CYAN}[*] Installation steps:${NC}"
    echo -e "${CYAN}    1. git clone https://github.com/testiclesloved/Gokyc.git${NC}"
    echo -e "${CYAN}    2. cd Gokyc${NC}"
    echo -e "${CYAN}    3. ./install.sh${NC}"
    echo
    echo -e "${YELLOW}[*] Current directory contents:${NC}"
    ls -la
    exit 1
fi

# Show file verification
echo -e "${CYAN}[*] Verified repository files:${NC}"
echo -e "${GREEN}[✓] install.sh (installer script)${NC}"
echo -e "${GREEN}[✓] $ZIP_FILE (protected release)${NC}"
if [[ -f "README.md" ]]; then
    echo -e "${GREEN}[✓] README.md (documentation)${NC}"
fi

# Run main installation
main "$@"
