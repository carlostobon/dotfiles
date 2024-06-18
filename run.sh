#!/bin/bash

username=$(whoami)

echo "Making folders..."
mkdir -p "/home/$username/.config/mpv" \
         "/home/$username/.config/picom" \
         "/home/$username/.config/zathura" \
         "/home/$username/.config/yazi" \
         "/home/$username/.config/qutebrowser" \
         "/home/$username/.config/kitty" \
         "/home/$username/.config/wallpaper" \
         "/home/$username/.xmonad" \


linker(){
  local from=$1
  local to=$2

  ln -srf "/home/$username/.dotfiles/$from" "/home/$username/$to"
}

echo "Setting links..."

linker "git/gitconfig" ".gitconfig"
linker "shell/aliasrc" ".aliasrc"
linker "shell/bash_profile" ".bash_profile"
linker "shell/bashrc" ".bashrc"
linker "shell/keyboard" ".keyboard"
linker "vim/vimrc" ".vimrc"

linker "kitty/kitty.conf" ".config/kitty/kitty.conf"
linker "mpv/input.conf" ".config/mpv/input.conf"
linker "picom/picom.conf" ".config/picom/picom.conf"

linker "qutebrowser/autoconfig.yml" ".config/qutebrowser/autoconfig.yml"
linker "qutebrowser/config.py" ".config/qutebrowser/config.py"

linker "yazi/keymap.toml" ".config/yazi/keymap.toml"
linker "yazi/theme.toml" ".config/yazi/theme.toml"
linker "yazi/yazi.toml" ".config/yazi/yazi.toml"

linker "zathura/zathurarc" ".config/zathura/zathurarc"

linker "wallpaper/wallpaper.png" ".config/wallpaper/wallpaper.png"

linker "xmonad/xmonad.hs" ".xmonad/xmonad.hs"

linker "scripts/toolbox.sh" ".binaries/toolbox.sh"
