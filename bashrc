if [[ ! $- == *i* ]]; then
    . /etc/profile
    return
fi

export EDITOR=vim
export WORKON_HOME=$HOME/.virtualenvs
. /usr/local/bin/virtualenvwrapper.sh
