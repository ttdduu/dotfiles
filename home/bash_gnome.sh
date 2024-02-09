#!/usr/bin/bash

# fuera del script:
# sudo git clone https://github.com/ttdduu/ubuntu_reinstall.git

sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt upgrade
sudo apt install neovim

for i in bspwm polybar vifm zsh libfreetype-dev libx11-dev libpango1.0-0 libxft-dev libfontconfig1 build-essential fonts-open-sans fonts-noto make dmenu feh fzf okular gdebi-core sxiv ipython3 sox praat xdg-utils ripgrep pandoc gvfs-backends maim breeze-icon-theme libxcb-xinerama0 flake8 zstd xournalpp curl; do sudo apt-get install $i; done

# .vim tiene /autoload con plug.vim, /my-snippets con snips y /plugged al ppio vacío, no sé qué hay que poner manualmente y qué no, pero así estamos.

cd /home/ttdduu/.config && git clone https://git.suckless.org/st
cd /home/ttdduu/ubuntu_reinstall
cp st-scrollback-20210507-4536f46.diff st-scrollback-mouse-20220127-2c5edf2.diff st-nordtheme-0.8.5.diff /home/ttdduu/.config/st
cp .Xauthority .Xmodmap .Xresources .fehbg .flake8 .gitconfig .vim .zshenv .xinitrc /home/ttdduu/
mkdir /home/ttdduu/zsh
cp .zalias .zshrc .zshenv /home/ttdduu/.config/zsh
sudo rm -rf /home/ttdduu/.config/vifm
sudo cp vifm .config/
sudo rm -rf /etc/X11/xorg.conf.d
sudo cp xorg.conf.d /etc/X11/
sudo cp bspwm /home/ttdduu/.config/
sudo cp sxhkd /home/ttdduu/.config/
sudo cp polybar /home/ttdduu/.config/

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/ttdduu/.oh-my-zsh/plugins/zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir external_drives && cd external_drives
mkdir android ntfs ext4

cd /home/ttdduu/.config/st
patch -p1 < st-nordtheme-0.8.5.diff
patch -p1 < st-scrollback-20210507-4536f46.diff
patch -p1 < st-scrollback-mouse-20220127-2c5edf2.diff
# entrar a condig.def.h y poner tamaño de letra en 16 o 18 y el cursor
# sudo make clean install

# fin, de acá en más en zsh y bspwm
