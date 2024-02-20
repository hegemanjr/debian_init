#!/bin/bash
 
# Updates
sudo apt update
sudo apt upgrade -y

# Add bash aliases
cd ~ && wget https://gist.githubusercontent.com/hegemanjr/6db134604a312ed2d9de65b6fe033a54/raw/.bash_aliases

# Install apps with apt and snap
echo "Install apps with apt and snap"
sudo apt install curl flameshot gparted handbrake obs-studio gimp filezilla vlc slack neofetch -y

dl_dir=~/Downloads

if [ ! -d "$dl_dir" ]; then
    echo "Directory does not exist. Creating..."
    mkdir -pv "$dl_dir"
    echo "Directory created."
else
    echo "Directory already exists."
fi

read -p "Do you want to install GitKraken? (y/n) " install_gitkraken

if [[ $install_gitkraken =~ ^[Yy]$ ]]; then
  echo "Installing GitKraken..."
  cd ~/Downloads
  wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
  sudo apt install ./gitkraken-amd64.deb
else
  echo "Skipping GitKraken."
fi



read -p "Do you want to install Discord? (y/n) " install_discord

if [[ $install_discord =~ ^[Yy]$ ]]; then
  echo "Installing Discord..."
  cd ~/Downloads
  wget https://discord.com/api/download?platform=linux&format=deb
  sudo apt install ./discord-*.deb -y
else
  echo "Skipping Discord."
fi

read -p "Do you want to install Discord? (y/n) " install_discord

if [[ $install_discord =~ ^[Yy]$ ]]; then
  echo "Installing Discord..."
  cd ~/Downloads
  wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
  sudo apt install ./discord.deb
else
  echo "Skipping Discord."
fi


read -p "Do you want to install Brave Browser? (y/n) " install_brave

if [[ $install_brave =~ ^[Yy]$ ]]; then
  echo "Installing Brave Browser..."
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install brave-browser
else
  echo "Skipping Brave Browser."
fi

read -p "Do you want to adjust clock so it works with Windows dual boot? (y/n) " adjust_clock

if [[ $adjust_clock =~ ^[Yy]$ ]]; then
  echo "Adjusting clock so it works with Windows dual boot..."
  # adjust clock so it works with Windows dual boot
  timedatectl set-local-rtc 1
else
  echo "Skipping adjust clock."
fi

read -p "Do you want to install DisplayLink? First download the 'Synaptics APT Repository' package from https://www.synaptics.com/products/displaylink-graphics/downloads/ubuntu to  (y/n) " install_displaylink

if [[ $install_displaylink =~ ^[Yy]$ ]] && [[ -f ~/Downloads/synaptics-repository-keyring.deb ]]; then
  echo "Installing DisplayLink..."
  sudo apt install ~/Downloads/synaptics-repository-keyring.deb
  sudo apt update
  sudo apt install displaylink-driver
else
  echo "Skipping DisplayLink."
fi


read -p "Do you want to install MakeMKV? First, download both files from https://forum.makemkv.com/forum/viewtopic.php?t=224, then type (y/n) " install_makemkv

if [[ $install_makemkv =~ ^[Yy]$ ]]; then
  echo "Installing MakeMKV..."
  cd ~/Downloads
  tar -xzf ~/Downloads/makemkv-oss-*.tar.gz
  tar -xzf ~/Downloads/makemkv-bin-*.tar.gz

  cd "$(find ~/Downloads/ -type d -name 'makemkv-oss-*' -print -quit)"

  ./configure
  make
  sudo make install

  cd "$(find ~/Downloads/ -type d -name 'makemkv-bin-*' -print -quit)"

  make
  sudo make install

  sudo apt install ffmpeg

else
  echo "Skipping MakeMKV."
fi
