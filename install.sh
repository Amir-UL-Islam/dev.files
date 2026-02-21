#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

OS=""

detect_os() {
  if [[ "$(uname -s)" == "Darwin" ]]; then
    OS="macos"
    return
  fi

  if [[ -f /etc/os-release ]]; then
    # shellcheck disable=SC1091
    source /etc/os-release
    if [[ "${ID:-}" == "fedora" ]]; then
      OS="fedora"
      return
    fi
  fi

  echo "Unsupported OS. Supported: macOS, Fedora."
  exit 1
}

require_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is required. Install it from https://brew.sh and re-run."
    exit 1
  fi
}

require_dnf() {
  if ! command -v dnf >/dev/null 2>&1; then
    echo "dnf is required on Fedora. Please install it and re-run."
    exit 1
  fi
}

require_sudo() {
  if ! command -v sudo >/dev/null 2>&1; then
    echo "sudo is required to install packages."
    exit 1
  fi
}

backup_if_exists() {
  local path="$1"
  if [[ -e "$path" || -L "$path" ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$path" "$BACKUP_DIR/"
  fi
}

link_file() {
  local src="$1"
  local dest="$2"
  backup_if_exists "$dest"
  ln -sfn "$src" "$dest"
}

install_brew_bundle() {
  brew bundle --file "$ROOT_DIR/Brewfile"
}

dnf_install_if_available() {
  local pkg="$1"
  if dnf list --available "$pkg" >/dev/null 2>&1; then
    sudo dnf -y install "$pkg"
  else
    echo "Warning: Fedora package not found: $pkg"
  fi
}

install_fedora_packages() {
  local packages=(
    cmake
    gnutls
    gpgme
    poppler
    evince
    go
    java-latest-openjdk
    java-1.8.0-openjdk
    gradle
    jetty
    lsd
    lynx
    maven
    nodejs
    mongosh
    mysql-server
    neovim
    sqlite
    python3
    python3.10
    python3.11
    python3.12
    pandoc
    sshs
    tmux
    vim
    yarnpkg
    sshpass
    alacritty
    kitty
    wkhtmltopdf
    nerd-fonts
    hack-fonts
    testcontainers-desktop
    mongodb-org
  )

  for pkg in "${packages[@]}"; do
    dnf_install_if_available "$pkg"
  done
}

install_vim_plug() {
  local plug_path="$HOME/.local/share/nvim/site/autoload/plug.vim"
  if [[ ! -f "$plug_path" ]]; then
    curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
      -o "$plug_path"
  fi
}

install_nvim_plugins() {
  nvim --headless +PlugInstall +qall
}

install_coc_extensions() {
  nvim --headless +CocInstall +qall
}

main() {
  detect_os

  if [[ "$OS" == "macos" ]]; then
    require_brew
  else
    require_dnf
    require_sudo
  fi

  mkdir -p "$HOME/.config/nvim"
  mkdir -p "$HOME/.config/kitty"
  mkdir -p "$HOME/.local/share/nvim/site/autoload"

  if [[ "$OS" == "macos" ]]; then
    install_brew_bundle
  else
    install_fedora_packages
  fi

  link_file "$ROOT_DIR/tmux.conf" "$HOME/.tmux.conf"
  link_file "$ROOT_DIR/init.vim" "$HOME/.config/nvim/init.vim"
  link_file "$ROOT_DIR/zshrc" "$HOME/.zshrc"
  link_file "$ROOT_DIR/zprofile" "$HOME/.zprofile"
  link_file "$ROOT_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
  link_file "$ROOT_DIR/kitty/theme.conf" "$HOME/.config/kitty/theme.conf"

  install_vim_plug
  install_nvim_plugins
  install_coc_extensions

  echo "Done. Backups (if any) are in: $BACKUP_DIR"
}

main "$@"
