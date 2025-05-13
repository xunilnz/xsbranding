#!/bin/sh
clear
DISTRO=$( cat /etc/*-release | tr [:upper:] [:lower:] | grep -Poi '(debian|ubuntu|red hat|centos|arch|mint)' | uniq )
if [ -z $DISTRO ]; then
    DISTRO='unknown'
    echo "Unknown Distribution, can't install"
    exit
fi
WHO=$(whoami)
if [ "$WHO" != "root" ]
then
    echo ""
    echo "You must run this as sudo"
    echo ""
    echo "eg:  ~ sudo ./install.sh"
    echo ""
    exit 0
fi
echo "This will install Xunil Solutions Branding on your $DISTRO linux"
echo ""
echo "By continuing, you agree you are doing so at your own risk!"
echo ""
read -p "Are you sure you want to continue? (y/n) " response
if [ "$response" != "y" ]; then
    echo 'Aborting Xunil Solutions Branding Installation'
    exit
fi
echo ' '
case $DISTRO in
    arch)
      echo 'Installing into Arch Linux'
      cp --recursive plymouth-theme-xunilsolutions/ /usr/share/plymouth/themes/xunilsolutions/
      cp configs/archXunilSolutions.xml /usr/share/gnome-background-properties/
      cp backgrounds/XunilSolutionsArch.jpg /usr/share/backgrounds/XunilSolutions.jpg
      cp backgrounds/XSArchPlymouth.png /usr/share/plymouth/themes/xunilsolutions/img.png
      plymouth-set-default-theme -l
      plymouth-set-default-theme -R xunilsolutions
      echo 'Done...'
      echo 'Your next reboot will show custom boot screen'
      exit
      ;;
    mint) # todo: Detect Mint Flavor, Cinnamon, Mate, XCFE, LMDE etc..
    echo 'Installing for Linux Mint (Cinnamon)'
      cp backgrounds/XunilSolutions.jpg /usr/share/backgrounds/
      cp --recursive plymouth-theme-xunilsolutions/ /usr/share/plymouth/themes/xunilsolutions/
      ln -sfn /usr/share/backgrounds/XunilSolutions.jpg /usr/share/backgrounds/linuxmint/default_background.jpg
      cp configs/linuxmint.xml /usr/share/cinnamon-background-properties/
      cp configs/linuxmint-wallpapers.xml /usr/share/cinnamon-background-properties/
      echo 'Installing plymouth bootloader theme'
      update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/xunilsolutions/xunilsolutions.plymouth 200
      echo 'Select the Xunil Theme to continue.'
      update-alternatives --config default.plymouth
      echo 'Rebuilding bootloader to display new theme.'
      update-initramfs -u
      echo 'Done..'
      echo 'Your next reboot will show custom boot screen'
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

