#!/usr/bin/zsh
# waypaperを起動し、その全ての出力を/dev/nullに捨てる
sed -i 's/#ffffff/ffffff/g' $HOME/.config/waypaper/config.ini
waypaper > /dev/null 2>&1