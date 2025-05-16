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


install_latest_nodejs() {
  TAG="$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name')"
  curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${TAG}/install.sh" | PROFILE=/dev/null bash
  . "$HOME/.nvm/nvm.sh"
  nvm install --lts
}


add_wezterm_apt_repo() {
  curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
  echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
  sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
  sudo apt update
}


install_kitty_macos() {
  curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
}


install_kitty_linux() {
  curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin dest="$HOME/.local/stow"
  stow -vv -d "$HOME/.local/stow" -t "$HOME/.local" kitty.app
}


bootstrap_common() {
  if [ ! -e "dotfiles" ]; then
    git clone --recurse-submodules git@github.com:dhain/dotfiles.git
  fi
  [ -e ".local/bin" ] || mkdir -p ".local/bin"
  [ -e ".local/share" ] || mkdir -p ".local/share"
  [ -e ".local/lib" ] || mkdir -p ".local/lib"
  [ -e ".config" ] || mkdir ".config"
  [ -e ".tmux/plugins" ] || mkdir -p ".tmux/plugins"
  [ -e ".oh-my-zsh" ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
  [ -e ".oh-my-zsh/themes" ] || mkdir ".oh-my-zsh/themes"
  [ -e ".nvm/nvm.sh" ] || install_latest_nodejs
}


bootstrap_linux_pre() {
  [ -e "/etc/apt/sources.list.d/wezterm.list" ] || add_wezterm_apt_repo
  APT_PKGS=
  command_exists make || APT_PKGS="$APT_PKGS build-essential"
  command_exists stow || APT_PKGS="$APT_PKGS stow"
  command_exists jq || APT_PKGS="$APT_PKGS jq"
  command_exists zsh || APT_PKGS="$APT_PKGS zsh"
  command_exists tmux || APT_PKGS="$APT_PKGS tmux"
  command_exists nvim || APT_PKGS="$APT_PKGS neovim"
  command_exists rg || APT_PKGS="$APT_PKGS ripgrep"
  command_exists xclip || APT_PKGS="$APT_PKGS xclip"
  command_exists rclone || APT_PKGS="$APT_PKGS rclone"
  command_exists convert || APT_PKGS="$APT_PKGS imagemagick"
  command_exists wezterm || APT_PKGS="$APT_PKGS wezterm"
  [ -z "$APT_PKGS" ] || sudo apt install -y $APT_PKGS

  grep -qE '^user_allow_other' /etc/fuse.conf || sudo sed -i 's/^#\s*user_allow_other/user_allow_other/' /etc/fuse.conf
  grep -qE '^user_allow_other' /etc/fuse.conf || echo "user_allow_other" | sudo tee -a /etc/fuse.conf >/dev/null
  [ -e "$HOME/.config/systemd/user" ] || mkdir -p "$HOME/.config/systemd/user"
}


bootstrap_linux_post() {
  command_exists kitty || install_kitty_linux
}


bootstrap_macos_pre() {
  command_exists brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  BREW_PREFIX="$(brew --prefix)"

  BREW_PKGS=
  command_exists stow || BREW_PKGS="$BREW_PKGS stow"
  command_exists jq || BREW_PKGS="$BREW_PKGS jq"
  [ -e "$BREW_PREFIX/bin/zsh" ] || BREW_PKGS="$BREW_PKGS zsh"
  [ -e "$BREW_PREFIX/bin/tmux" ] || BREW_PKGS="$BREW_PKGS tmux"
  [ -e "$BREW_PREFIX/bin/nvim" ] || BREW_PKGS="$BREW_PKGS neovim"
  [ -e "$BREW_PREFIX/bin/rg" ] || BREW_PKGS="$BREW_PKGS ripgrep"
  [ -e "$BREW_PREFIX/bin/convert" ] || BREW_PKGS="$BREW_PKGS imagemagick"
  [ -e "/Applications/WezTerm.app" ] || BREW_PKGS="$BREW_PKGS wezterm"
  [ -z "$BREW_PKGS" ] || brew install $BREW_PKGS
}


bootstrap_macos_post() {
  [ -e "/Applications/kitty.app" ] || install_kitty_macos
}


cd "$HOME"

STOW_PKGS="git bin zsh tmux nvim wezterm"
if [ "$(uname)" = "Darwin" ]; then
  bootstrap_macos_pre
else
  bootstrap_linux_pre
  STOW_PKGS="$STOW_PKGS systemd"
fi
bootstrap_common
stow -vv -d "$HOME/dotfiles" -t "$HOME" $STOW_PKGS
if [ "$(uname)" = "Darwin" ]; then
  bootstrap_macos_post
else
  bootstrap_linux_post
fi

cd -
