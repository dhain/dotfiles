#!/bin/sh

set -e

# Make sure important variables exist if not already defined
#
# $USER is defined by login(1) which is not always executed (e.g. containers)
# POSIX: https://pubs.opengroup.org/onlinepubs/009695299/utilities/id.html
USER=${USER:-$(id -u -n)}
# $HOME is defined at the time of login, but it could be unset. If it is unset,
# a tilde by itself (~) will not be expanded to the current user's home directory.
# POSIX: https://pubs.opengroup.org/onlinepubs/009696899/basedefs/xbd_chap08.html#tag_08_03
HOME="${HOME:-$(getent passwd $USER 2>/dev/null | cut -d: -f6)}"
# macOS does not have getent, but this works even if $HOME is unset
HOME="${HOME:-$(eval echo ~$USER)}"


command_exists() {
  command -v "$@" >/dev/null 2>&1
}


bootstrap_common() {
  if [ ! -e "dotfiles" ]; then
    git clone --recurse-submodules git@github.com:dhain/dotfiles.git
  fi
  [ -e ".local" ] || mkdir ".local"
  [ -e ".config" ] || mkdir ".config"
  [ -e ".tmux/plugins" ] || mkdir -p ".tmux/plugins"
  [ -e ".oh-my-zsh" ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
  [ -e ".oh-my-zsh/themes" ] || mkdir ".oh-my-zsh/themes"
}


bootstrap_linux_pre() {
  APT_PKGS=
  command_exists make || APT_PKGS="$APT_PKGS build-essential"
  command_exists stow || APT_PKGS="$APT_PKGS stow"
  command_exists zsh || APT_PKGS="$APT_PKGS zsh"
  command_exists tmux || APT_PKGS="$APT_PKGS tmux"
  command_exists nvim || APT_PKGS="$APT_PKGS neovim"
  command_exists rg || APT_PKGS="$APT_PKGS ripgrep"
  command_exists xclip || APT_PKGS="$APT_PKGS xclip"
  command_exists rclone || APT_PKGS="$APT_PKGS rclone"
  [ -z "$APT_PKGS" ] || sudo apt install -y $APT_PKGS

  grep -qE '^user_allow_other' /etc/fuse.conf || sudo sed -i 's/^#\s*user_allow_other/user_allow_other/' /etc/fuse.conf
  grep -qE '^user_allow_other' /etc/fuse.conf || echo "user_allow_other" | sudo tee -a /etc/fuse.conf >/dev/null
  [ -e "$HOME/.config/systemd/user" ] || mkdir -p "$HOME/.config/systemd/user"
}


bootstrap_macos_pre() {
  command_exists brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  BREW_PREFIX="$(brew prefix)"

  BREW_PKGS=
  command_exists stow || BREW_PKGS="$BREW_PKGS stow"
  [ -e "$BREW_PREFIX/bin/zsh" ] || BREW_PKGS="$BREW_PKGS zsh"
  [ -e "$BREW_PREFIX/bin/tmux" ] || BREW_PKGS="$BREW_PKGS tmux"
  [ -e "$BREW_PREFIX/bin/nvim" ] || BREW_PKGS="$BREW_PKGS neovim"
  [ -e "$BREW_PREFIX/bin/rg" ] || BREW_PKGS="$BREW_PKGS ripgrep"
  [ -z "$BREW_PKGS" ] || brew install $BREW_PKGS
}


cd "$HOME"

STOW_PKGS="git bin zsh tmux nvim"
if [ "$(uname)" = "Darwin" ]; then
  bootstrap_macos_pre
else
  bootstrap_linux_pre
  STOW_PKGS="$STOW_PKGS systemd"
fi
bootstrap_common
stow -vv -d "$HOME/dotfiles" -t "$HOME" $STOW_PKGS

cd -
