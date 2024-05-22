#!/bin/bash

username=$(whoami)

echo "Making folders..."
mkdir -p "/home/$username/.config/mpv" \
         "/home/$username/.config/picom" \
         "/home/$username/.config/zathura" \
         "/home/$username/.config/ranger" \
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

linker "qutebrowser/autoconfig.yml" ".config/picom/picom.conf"
linker "qutebrowser/config.py" ".config/picom/config.py"

linker "ranger/rc.conf" ".config/ranger/rc.conf"
linker "ranger/rifle.conf" ".config/ranger/rifle.py"

linker "zathura/zathura.rc" ".config/zathura/zathura.rc"

linker "wallpaper/wallpaper.png" ".config/wallpaper/wallpaper.png"

linker "xmonad/xmonad.sh" ".xmonad/xmonad.hs"


# Make dirs and set links
find scripts -type d -exec mkdir -p "/home/$username/."{} \;
find scripts -type f -exec ln -srf {} "/home/$username/."{} \;
