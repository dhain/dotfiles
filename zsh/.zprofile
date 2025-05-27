if [ -e "$HOME/.cargo" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -e "$HOME/.pyenv" ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
fi

if [ -e "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [ -e "$HOME/.localzprofile" ]; then
  source "$HOME/.localzprofile"
fi
