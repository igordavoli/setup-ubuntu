#! /bin/bash

GIT_HUB_EMAIL=igordavoli@gmail.com

PACKEGES=(
"build-essential"
"curl"
"fonts-firacode"
"git"
"gnome-tweaks"
"nodejs"
"npm"
"vlc"
)

SNAPS=(
"code --classic" 
"dbeaver-ce" 
"discord" 
"insomnia" 
"spotify"
)


VSCODE_EXTENSIONS=(
"cschlosser.doxdocgen"
"dbaeumer.vscode-eslint"
"dracula-theme.theme-dracula"
"eamodio.gitlens"
"esbenp.prettier-vscode"
"foxundermoon.shell-format"
"MS-vsliveshare.vsliveshare"
"PKief.material-icon-theme"
"redhat.vscode-yaml"
"streetsidesoftware.code-spell-checker"
"streetsidesoftware.code-spell-checker-portuguese-brazilian"
"styled-components.vscode-styled-components"
"TabNine.tabnine-vscode"
"ue.alphabetical-sorter"
)

GNOME_CONFIGS=(
"desktop.interface gtk-theme 'Nordic'"
"desktop.interface icon-theme 'Papirus'"
"desktop.wm.preferences button-layout 'close,minimize,maximize:'"
"shell.extensions.dash-to-dock dash-max-icon-size 42"
"shell.extensions.dash-to-dock dock-position 'BOTTOM'"
"shell.extensions.dash-to-dock extend-height false"
"shell.extensions.dash-to-dock isolate-monitors true"
"shell.extensions.dash-to-dock isolate-workspaces true"
)

# update and upgrade packages
sudo apt update -y
sudo apt upgrade -y

# install packages
for ((i = 0; i < ${#PACKEGES[@]}; i++))
do
    sudo snap install ${PACKEGES[$i]}
done

# install snaps
for ((i = 0; i < ${#SNAPS[@]}; i++))
do
    sudo snap install ${SNAPS[$i]}
done

# install vscode extensions
for ((i = 0; i < ${#VSCODE_EXTENSIONS[@]}; i++))
do
    code --install-extension ${VSCODE_EXTENSIONS[$i]}
done

# install n 
sudo npm i n

# install node lts
sudo n lts

# update terminal settings
source ~/.bashrc

# install yarn
npm i yarn

# install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb -y
rm ./google-chrome-stable_current_amd64.deb

# install nordic theme
git clone https://github.com/EliverLara/Nordic.git
mv Nordic/ /usr/share/themes/

# install papurus icons
add-apt-repository ppa:papirus/papirus
apt install papirus-icon-theme -y

# # set theme configs
for ((i = 0; i < ${#GNOME_CONFIGS[@]}; i++))
do
    gsettings set org.gnome.${GNOME_CONFIGS[$i]}
done

# generate github ssh key
ssh-keygen -t rsa -b 4096 -C $GIT_HUB_EMAIL -f $HOME/.ssh/github



