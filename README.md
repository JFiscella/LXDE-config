# LXDE config/joey

![megingjard](terminal.png)

this is my LXDE config!

## about

makes LXDE more like OS X, best when used with OS X keyboard ofc

### table of contents

i. [lxde-rc.xml](#lxde-rc.xml)

ii. [autostart](#autostart)

iii. [install](#install)

iv. [deploy](#deploy-new-version-to-git)

v. [additional](#additional-stuff)

## sections

### lxde-rc.xml

lxde-rc.xml is the openbox configuration i use

a lot of it tries to replicate common keystrokes from OS X 

a big addition here is the **wmctrl-switch-by-application**, which lets you switch by application using super+` which mimics OS X behavior.

i switch my desktop using super+1, super+2, super+n... etc so that's there

also, the shutter program allows you to take screenshots like OS X

so super+shift+4 is a selection screenshot

super+shift+5 is an EMACS-like keybind,

super+shift+5 -> space = window screenshot

super+shift+5 -> 5 = full-screen screenshot

some other basic stuff, like super+q quits programs is included

### autostart

my autostart controls some low-level mouse and keyboard stuff,

#### mouse

the touchpad settings i use are DetectPalm=1 and also i disable the touchpad while typing for 1 second (might lower this in the future 1 second is literally forever)

#### keyboard

i take away the capslock lock and replace that keybind with escape for vim and navigation purposes. it's great

this is achieved through .caps_esc which runs at login


## install

there are some prereqs,

### prerequisites

wmctrl

```
apt-get install wmctrl
```

shutter

```
apt-get install shutter
```

now, clone this repo to ~/.config/joey

link up wmctrl-switch-by-application:

```
ln -s wmctrl-switch-by-application /usr/bin/wmctrl-switch-by-application 
```

place autostart in its correct path:

```
cp autostart ~/.config/lxsession/LXDE/autostart
```

place lxde-rc.xml in its correct path:

```
cp lxde-rc.xml ~/.config/openbox/lxde-rc.xml
```

you should back those files up first before copying them over tbh

reconfigure openbox

```
openbox --reconfigure
```

## deploy new version to git

if we made changes to the live configuration files, they need to be added to this directory first:

copy `~/.config/openbox/lxde-rc.xml` to this directory

copy `~/.config/lxsession/LXDE/autostart` to this directory

```
git push
```

## additional stuff

gvim

```
apt-get install vim-gnome
```

synapse

```
apt-get install synapse
```

