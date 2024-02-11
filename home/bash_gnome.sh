#!/usr/bin/bash

sudo apt install vifm
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt upgrade
sudo apt install neovim

#for i in bspwm polybar vifm zsh libfreetype-dev libx11-dev libpango1.0-0 libxft-dev libfontconfig1 build-essential fonts-open-sans fonts-noto make dmenu feh fzf okular gdebi-core sxiv ipython3 sox praat xdg-utils ripgrep pandoc gvfs-backends maim breeze-icon-theme libxcb-xinerama0 flake8 zstd xournalpp curl; do sudo apt-get install $i; done

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/ttdduu/.oh-my-zsh/plugins/zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd /home/ttdduu/.config/st
patch -p1 < st-nordtheme-0.8.5.diff
patch -p1 < st-scrollback-20210507-4536f46.diff
patch -p1 < st-scrollback-mouse-20220127-2c5edf2.diff
# sudo make clean install

type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)\ncurl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \\n&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \\n&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \\n&& sudo apt update \\n&& sudo apt install gh -y

git clone https://github.com/baskerville/backlight.git /home/ttdduu/.config/backlight
cd $HOME/.config/backlight
chmod +x backlight.c
pushd backlight && sudo make && sudo make install;popd
