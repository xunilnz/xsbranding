#!/bin/sh
clear
DISTRO=$( cat /etc/*-release | tr [:upper:] [:lower:] | grep -Poi '(debian|ubuntu|red hat|centos|arch|mint)' | uniq )
if [ -z $DISTRO ]; then
    DISTRO='unknown'
    echo "Unknown Distribution, can't install"
    exit
fi
echo "Install Xunil Solutions Branding on $DISTRO"
echo ' '
echo 'This requires sudo privillages to continue & Plymouth must be installed'
read -p "Are you sure? " response
if [ "$response" != "y" ]; then
    echo 'Aborting Xunil Solutions Branding Installation'
    exit
fi
echo ' '
#read -p "Which Distro are You Running? 1 arch, 2 mint, 3 ubuntu, 4 debian: " distro
case $DISTRO in
    arch)
      echo 'Installing into Arch Linux'
      sudo cp --recursive plymouth-theme-xunilsolutions/ /usr/share/plymouth/themes/xunilsolutions/
      sudo cp configs/archXunilSolutions.xml /usr/share/gnome-background-properties/
      sudo cp backgrounds/XunilSolutionsArch.jpg /usr/share/backgrounds/XunilSolutions.jpg
      sudo cp backgrounds/XSArchPlymouth.png /usr/share/plymouth/themes/xunilsolutions/img.png
      sudo plymouth-set-default-theme -l
      sudo plymouth-set-default-theme -R xunilsolutions
      exit
      ;;
    mint)
      echo 'Installing for Linux Mint'
      sudo cp backgrounds/XunilSolutions.jpg /usr/share/backgrounds/
      sudo cp --recursive plymouth-theme-xunilsolutions/ /usr/share/plymouth/themes/xunilsolutions/
      sudo ln -sfn /usr/share/backgrounds/XunilSolutions.jpg /usr/share/backgrounds/linuxmint/default_background.jpg
      sudo cp configs/linuxmint.xml /usr/share/cinnamon-background-properties/
      sudo cp configs/linuxmint-wallpapers.xml /usr/share/cinnamon-background-properties/
      echo 'Installing plymouth bootloader theme'
      sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/xunilsolutions/xunilsolutions.plymouth 200
      echo 'Select the Xunil Theme to continue.'
      sudo update-alternatives --config default.plymouth
      echo 'Rebuilding bootloader to display new theme.'
      sudo update-initramfs -u
    echo 'Done..'
      exit
      ;;
    ubuntu)
      echo 'Sorry, script for Ubuntu has not been done yet'
      exit
      ;;
    debian)
      echo 'Sorry, script for Debian has not been done yet'
      exit
      ;;
    centos)
      echo 'Sorry, script for Centos has not been done yet'
      exit
      ;;
    "red hat")
      echo 'Sorry, script for Red hat has not been done yet'
      exit
      ;;

esac

