#!/bin/env bash

echo "Making folders..."
folders=(
  ".config/mpv"
  ".config/picom"
  ".config/zathura"
  ".config/yazi"
  ".config/qutebrowser"
  ".config/kitty"
  ".config/wallpaper"
  ".vim/config"
  ".xmonad"
)

for folder in "${folders[@]}"; do
  mkdir -p "$HOME/$folder"
done

linker(){
  local from="$1"
  local to="$2"

  ln -srf "$HOME/.dotfiles/$from" "$HOME/$to"
}

echo "Setting links..."

linker "shell/aliasrc" ".aliasrc"
linker "shell/bash_profile" ".bash_profile"
linker "shell/bashrc" ".bashrc"
linker "shell/keyboard" ".keyboard"
linker "shell/inputrc" ".inputrc"

linker "vim/vimrc" ".vimrc"
linker "vim/keymaps.vim" ".vim/config/keymaps.vim"
linker "vim/pluggins.vim" ".vim/config/pluggins.vim"
linker "vim/settings.vim" ".vim/config/settings.vim"
linker "vim/shortcuts.vim" ".vim/config/shortcuts.vim"
linker "vim/functions.vim" ".vim/config/functions.vim"
linker "vim/modules" ".vim/modules"
linker "vim/customizations" ".vim/customizations"

linker "mpv/input.conf" ".config/mpv/input.conf"
linker "mpv/mpv.conf" ".config/mpv/mpv.conf"

linker "qutebrowser/autoconfig.yml" ".config/qutebrowser/autoconfig.yml"
linker "qutebrowser/config.py" ".config/qutebrowser/config.py"
linker "qutebrowser/gruvbox.py" ".config/qutebrowser/gruvbox.py"

linker "yazi/keymap.toml" ".config/yazi/keymap.toml"
linker "yazi/theme.toml" ".config/yazi/theme.toml"
linker "yazi/yazi.toml" ".config/yazi/yazi.toml"

linker "zathura/zathurarc" ".config/zathura/zathurarc"

linker "wallpaper/wallpaper.png" ".config/wallpaper/wallpaper.png"

linker "git/gitconfig" ".gitconfig"

linker "xmonad/xmonad.hs" ".xmonad/xmonad.hs"

linker "picom/picom.conf" ".config/picom/picom.conf"

linker "kitty/kitty.conf" ".config/kitty/kitty.conf"

linker "scripts/toolbox" ".binaries/toolbox"
linker "scripts/ship" ".binaries/ship"
linker "scripts/video" ".binaries/video"
linker "scripts/shadcn" ".binaries/shadcn"
linker "scripts/shadcn" ".binaries/shadcn"
