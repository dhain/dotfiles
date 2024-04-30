brew="$(brew --prefix 2>/dev/null || true)"
if [ "$brew" ]; then
    export PATH="$brew/bin:$brew/sbin:$PATH"
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
