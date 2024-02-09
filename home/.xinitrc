#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#exec xterm -geometry 80x66+0+0 -name login

#AGREGADAS POR MI

#xset r rate 175 50 # reducir delay de teclas

# unclutter -idle 1 -jitter 2 -root &

#setxkbmap -option caps:swapescape


#aqui me pongo a cantar
### Make some devices default
#parlante
#pacmd set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
#mic
#pacmd set-default-source alsa_input.pci-0000_00_1f.3.analog-stereo
#


exec bspwm

