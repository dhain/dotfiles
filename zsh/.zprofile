if [ -e "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -e "$HOME/.pyenv" ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init - | sed s/precmd/precwd/g)"
fi

if [ -e "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if [ -e "$HOME/.cargo" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -e "$HOME/.localzprofile" ]; then
    source "$HOME/.localzprofile"
fi
