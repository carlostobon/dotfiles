#!/bin/env bash

echo "Making folders..."
folders=(
  ".config/kitty"
  ".config/qutebrowser"
  ".config/xmonad"
  ".vim/config"
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

[ -e "$HOME/.vim/modules" ] && rm "$HOME/.vim/modules"
[ -e "$HOME/.vim/customizations" ] && rm "$HOME/.vim/customizations"
linker "vim/modules" ".vim/modules"
linker "vim/customizations" ".vim/customizations"

[ -e "$HOME/.config/mpv" ] && rm "$HOME/.config/mpv"
linker "mpv" ".config/mpv"

[ -e "$HOME/.config/yazi" ] && rm "$HOME/.config/yazi"
linker "yazi" ".config/yazi"

[ -e "$HOME/.config/zathura" ] && rm "$HOME/.config/zathura"
linker "zathura" ".config/zathura"

[ -e "$HOME/.config/wallpaper" ] && rm "$HOME/.config/wallpaper"
linker "wallpaper" ".config/wallpaper"

[ -e "$HOME/.config/picom" ] && rm "$HOME/.config/picom"
linker "picom" ".config/picom"

linker "kitty/kitty.conf" ".config/kitty/kitty.conf"
linker "xmonad/xmonad.hs" ".config/xmonad/xmonad.hs"
linker "git/gitconfig" ".gitconfig"

linker "qutebrowser/config.py" ".config/qutebrowser/config.py"
linker "qutebrowser/autoconfig.yml" ".config/qutebrowser/autoconfig.yml"

linker "scripts/toolbox" ".binaries/toolbox"
linker "scripts/ship" ".binaries/ship"
linker "scripts/video" ".binaries/video"
linker "scripts/shadcn" ".binaries/shadcn"
