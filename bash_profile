# _               _                      __ _ _
#| |__   __ _ ___| |__  _ __  _ __ ___  / _(_) | ___
#| '_ \ / _` / __| '_ \| '_ \| '__/ _ \| |_| | |/ _ \
#| |_) | (_| \__ \ | | | |_) | | | (_) |  _| | |  __/
#|_.__/ \__,_|___/_| |_| .__/|_|  \___/|_| |_|_|\___|
#                      |_|

# Load bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Initiate graphical server if not running yet
 if [ "$(tty)" = "/dev/tty1" ]; then
  pgrep -x xmonad || exec startx
 fi
 . "$HOME/.cargo/env"
