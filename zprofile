if [ -e /opt/homebrew ]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi
if [ -e /usr/local/cuda ]; then
    export PATH="/usr/local/cuda/bin:$PATH"
fi
if [ -e "$HOME/.pyenv" ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

export PATH="$HOME/bin:$PATH"
export LESS='-R --mouse'
