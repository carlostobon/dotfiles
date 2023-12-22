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

# Hidden files in shell
shells=("bashrc" "bash_profile" "aliasrc" "keyboard")
for target in "${shells[@]}"; do
  create_link "shell/$target" .$target
done

create_link "vim/vimrc" ".vimrc"
create_link "git/gitconfig" ".gitconfig"

create_dir ".xmonad"
create_link "xmonad/xmonad.hs" ".xmonad/xmonad.hs"

create_dir ".config/mpv"
create_link "mpv/input.conf" ".config/mpv/input.conf"

# Iterate over targets (.config)
targets=("picom" "zathura" "ranger" "qutebrowser" "kitty")
for target in "${targets[@]}"; do
  ## create dir
  create_dir ".config/$target"

  ## get all files
  files=$(find $target -type f)

  ## generate links
  for file in $files; do
    create_link $file ".config/$file"
  done
done


# Dowload and place binaries
# Prompt here
echo "Do you want to download \& install binaries? (y/N)"
read answer

if [ "$answer" == "y" ]; then
  mkdir binaries
  cd binaries

  bins=("duer" "ww")

  echo "installing binaries..."
  for item in "${bins[@]}"; do
    curl -O "https://server.numericaltools.com/bins/$item" &
  done
  wait

  for item in "${bins[@]}"; do
    chmod +x "$item"
  done
  cd ../
  echo "binaries installed successfully..."
else
  echo "Ok no binaries will be installed!"
fi

# Set links for scripts and binaries
echo "setting links for scripts and binaries..."
targets=("scripts" "binaries")
for target in "${targets[@]}"; do
  create_dir ".$target"
  files=$(find $target -type f)
  for file in $files; do
    create_link $file ".$file"
  done
done
