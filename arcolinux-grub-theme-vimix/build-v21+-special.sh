#!/bin/bash
#https://wiki.archlinux.org/index.php/DeveloperWiki:Building_in_a_Clean_Chroot

search=arcolinux
echo "We will start building "$search "now."
echo "###########################################################"
echo

echo "################################################################"
echo "#########        Let us build this package      ################"
echo "################################################################"

echo "Select"
echo "2. makepkg"
echo "1. chroot"
echo "0. Do nothing"
echo "Type the number..."
read CHOICE

case $CHOICE in

    2 )
    # or via makepkg
    makepkg --sign

    #or
    #makepkg
    #gpg --detach-sign $search*pkg.tar.xz
      ;;
    1 )
    #### via clean chroot

    CHROOT=$HOME/Documents/chroot-arcolinux
    arch-nspawn $CHROOT/root pacman -Syu
    makechrootpkg -c -r $CHROOT

    echo "Signing the package"
    echo "###########################################################"
    echo
    gpg --detach-sign $search*pkg.tar.xz

      ;;
    0 )
        echo "########################################"
        echo "We did nothing as per your request"
        echo "########################################"
        ;;

    * )
    echo "#################################"
		echo "Choose the correct number"
    echo "#################################"
		;;
esac

echo "Moving created files to repo"
echo "###########################################################"
echo
mv $search*pkg.tar.xz ../../arcolinux_repo/x86_64/
mv $search*pkg.tar.xz.sig ../../arcolinux_repo/x86_64/

echo "Cleaning up"
echo "###########################################################"
echo

echo "deleting unnecessary folders"
echo "###########################################################"
echo

rm -rf pkg src

echo "deleting unnecessary files"
echo "###########################################################"
echo

sudo rm -r grub2-themes


echo "################################################################"
echo "###################    build done         ######################"
echo "################################################################"
