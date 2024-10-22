Dotfiles
========

Packages to install:

- stow
- zsh
- ohmyzsh
- tmux
- neovim
- xclip (linux)
- rclone (linux)

```
cd dotfiles
stow -vv .
```

To make the rclone unit work, uncomment `user_allow_other` in `/etc/fuse.conf`.
