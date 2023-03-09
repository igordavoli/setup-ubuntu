#! /bin/bash

# script for configure my ubuntu 22.04 jammy jelyfish pc
GIT_HUB_EMAIL=igordavoli@gmail.com

SSH_DIR=$HOME/.ssh

USERNAME=igordavoli

SSH_CONFIG_CONTENT=\
	"Host github.com
	    HostName github.com
	    User git
	    IdentityFile ~/.ssh/github
	"
PACKEGES=(
	"build-essential"
	"curl"
	"fonts-firacode"
	"git"
	"gnome-tweaks"
	"nodejs"
	"npm"
	"vlc"
# "corectrl"
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
	"sohamkamani.code-eol"
)

VSCODE_OPTIONS="{
    \"tabnine.experimentalAutoImports\": true,
	\"workbench.colorTheme\": \"Dracula\",
    \"editor.fontFamily\": \"Fira Code\",
    \"files.insertFinalNewline\":true,
    \"editor.renderWhitespace\": \"all\",
    \"files.trimTrailingWhitespace\": true,
    \"files.trimFinalNewlines\": true,
	\"material-icon-theme.activeIconPack\": \"nest\",
    \"files.eol\": \"\n\"
}"

GNOME_CONFIGS=(
	"desktop.interface gtk-theme 'Nordic'"
	"desktop.interface icon-theme 'Papirus'"
	"desktop.wm.preferences button-layout 'close,minimize,maximize:'"
	"desktop.background picture-uri '/home/igordavoli/Pictures/Wallpapers/montains.jpeg'"
	"shell.extensions.dash-to-dock dash-max-icon-size 36"
	"shell.extensions.dash-to-dock dock-position 'BOTTOM'"
	"shell.extensions.dash-to-dock extend-height false"
	"shell.extensions.dash-to-dock dock-fixed false"
	"shell.extensions.dash-to-dock isolate-monitors true"
	"shell.extensions.dash-to-dock isolate-workspaces true"
	"shell.extensions.dash-to-dock show-mounts false"
	"shell.extensions.dash-to-dock show-mounts-network false"
	"shell.extensions.dash-to-dock show-mounts-only-mounted true"
	"shell.extensions.ding show-home false"
)

# update and upgrade packages
# sudo add-apt-repository ppa:ernstp/mesarc -y
sudo apt update -y
sudo apt upgrade -y

# install packages
for ((i = 0; i < ${#PACKEGES[@]}; i++))
do
	sudo apt install ${PACKEGES[$i]} -y
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

# set vscode configs
echo -e $VS_CODE_VSCODE_OPTIONS | tee -a $HOME/.config/Code/User/settings.json > /dev/null

# install n
sudo npm i -g n

# install node lts
sudo n lts

# update terminal settings
source ~/.bashrc

# install yarn
npm i yarn

# install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
rm ./google-chrome-stable_current_amd64.deb

# install nordic theme
git clone https://github.com/EliverLara/Nordic.git
sudo mv Nordic/ /usr/share/themes/

# install papurus icons
sudo add-apt-repository ppa:papirus/papirus
sudo apt install papirus-icon-theme -y

# set theme configs
mkdir -p Pictures/Wallpapers
wget -c https://i.imgur.com/SBKjnxm.jpeg -O /home/igordavoli/Pictures/Wallpapers/montains.jpeg

for ((i = 0; i < ${#GNOME_CONFIGS[@]}; i++))
do
	gsettings set org.gnome.${GNOME_CONFIGS[$i]}
done

gsettings set org.gnome.shell favorite-apps "['snap-store_ubuntu-software.desktop', 'org.gnome.Nautilus.desktop', 'code_code.desktop', 'google-chrome.desktop', 'discord_discord.desktop', 'dbeaver-ce_dbeaver-ce.desktop', 'insomnia_insomnia.desktop', 'vlc.desktop', 'spotify_spotify.desktop']"
# fix cedilla issue in english intl keyboards
echo GTK_IM_MODULE=cedilla | sudo tee -a  /etc/environment > /dev/null

# set corectrl to initialize with startup and don't request root permissions
# cp /usr/share/applications/org.corectrl.corectrl.desktop ~/.config/autostart/org.corectrl.corectrl.desktop
# echo \
# "[User permissions]
# Identity=unix-group:$USERNAME
# Action=org.corectrl.*
# ResultActive=yes" \
# | sudo tee -a  /etc/polkit-1/localauthority/50-local.d/90-corectrl.pkla > /dev/null

# GRUB_CMDLINE_LINUX_DEFAULT="<other_params>... amdgpu.ppfeaturemask=0xffffffff"
# grub-mkconfig -o /boot/grub/grub.cfg

# generate github ssh key
ssh-keygen -t rsa -b 4096 -C $GIT_HUB_EMAIL -f $SSH_DIR/github
touch $SSH_DIR/config && echo -e $SSH_CONFIG_CONTENT> SSH_DIR/config
cat SSH_DIR/github.pub
