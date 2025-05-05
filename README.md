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


rclone
------

To make the rclone unit work, uncomment `user_allow_other` in `/etc/fuse.conf`.


Nerd Fonts
----------

To get vim to display all the glyphs out of the box, install a Nerd Font.

```
mkdir ~/.local/share/fonts
cd ~/.local/share/fonts
unzip ~/Downloads/DejaVuSansMono.zip
```

Then select it as default monospace font.
