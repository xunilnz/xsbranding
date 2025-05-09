#!/bin/sh
clear
echo 'Install Xunil Solutions Branding'
echo ' '
echo 'This requires sudo privillages to continue '
read -p "Are you sure? " response
if [ "$response" != "y" ]; then
    echo 'Aborting Xunil Solutions Branding Installation'
    exit
fi
echo ' '
read -p "Which Distro are You Running? 1 arch, 2 mint, 3 ubuntu, 4 debian: " distro
case $distro in
    1)
      echo 'Installing into archlinux'
      sudo cp --recursive plymouth-theme-xunilsolutions/ /usr/share/plymouth/themes/xunilsolutions/
      sudo cp configs/archXunilSolutions.xml /usr/share/gnome-background-properties/
      sudo cp backgrounds/XunilSolutionsArch.jpg /usr/share/bacgrounds/XunilSolutions.jpg
      exit
      ;;
    2)
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
    3)
      echo 'Installing for Ubuntu'
      exit
      ;;
    4)
      echo 'Installing for Debian'
      exit
      ;;
esac

