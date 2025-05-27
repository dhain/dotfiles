case "$TERM" in
  xterm-*)
    export COLORTERM=truecolor
    alias ls="ls --color=auto"
    alias grep="grep --color=auto"
    alias diff="diff --color=auto"
    ;;
esac

if [ -e "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi


if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init - | sed s/precmd/precwd/g)"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="shain"

plugins=(git)
source $ZSH/oh-my-zsh.sh
