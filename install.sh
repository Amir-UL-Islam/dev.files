#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

require_macos() {
  if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "This installer is macOS-only."
    exit 1
  fi
}

require_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is required. Install it from https://brew.sh and re-run."
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
  require_macos
  require_brew

  mkdir -p "$HOME/.config/nvim"
  mkdir -p "$HOME/.config/kitty"
  mkdir -p "$HOME/.local/share/nvim/site/autoload"

  install_brew_bundle

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

