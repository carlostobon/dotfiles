#!/bin/bash

function create_dir() {
  folder_name="$1"
  echo "creating folder $folder_name"
  mkdir -p $HOME/$folder_name ||
    error "error creating folder $folder_name"
}

function create_link() {
  target="$1"
  path="$2"
  echo "creating link $target -> $path"
  ln -srf $target $HOME/$path ||
    error "error creating link $target"
}

targets=("vimrc" "bashrc" "bash_profile" "aliasrc" "keyboard" "gitconfig")

for target in "${targets[@]}"; do
  create_link $target .$target
done

create_dir ".xmonad"
create_link "xmonad.hs" ".xmonad/xmonad.hs"

create_dir ".config/picom"
create_link "picom.conf" ".config/picom/picom.conf"

create_dir ".config/zathura"
create_link "zathurarc" ".config/zathura/zathurarc"

create_dir ".config/ranger"
create_link "rc.conf" ".config/ranger/rc.conf"
create_link "rifle.conf" ".config/ranger/rifle.conf"

create_dir ".config/qutebrowser"
create_link "config.py" ".config/qutebrowser/config.py"
create_link "autoconfig.yml" ".config/qutebrowser/autoconfig.yml"
