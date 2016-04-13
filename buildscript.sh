#!/bin/bash
# Add ~/bin to path
export PATH=$PATH:~/bin

bold=$(tput bold)
normal=$(tput sgr0)

NumThreads=`grep 'processor' /proc/cpuinfo | wc -l`
echo ""
echo ""
echo -e "${bold}\e[36mWelcome to the CyanogenMod 13.0 Build Script for the Samsung Galaxy Core Prime (G360T/G360T1)!${normal}\e[0m"
echo ""
echo -e "${bold}\e[36mOptions:"

while [ "$progress" != "finished" ]; do
echo "1) Sync sources."
echo "2) 'make clean'."
echo "3) Build ROM."
echo "4) Exit script."
echo ""
echo -n "Select an option:${normal}"
read option
echo ""
echo ""

case  $option in
  1)
    echo "Attempting to sync sources..."
    repo init -u https://github.com/CyanogenMod/android.git -b cm-13.0
    curl --create-dirs -L -o .repo/local_manifests/local_manifest.xml -O -L https://raw.githubusercontent.com/PlatinumMaster/android_local_manifest/cm-13.0/local_manifest.xml
    repo sync -j$NumThreads
    ;;
  2)
    echo "Cleaning the OUT directory..."
    make clean -j$NumThreads
    ;;
  3)
    echo "Building ROM..."
    . build/envsetup.sh && brunch cprimeltemtr
    progress=finished
    ;;
  4)
	echo "Exiting."
    progress=finished
	;;
  *)
    echo "Error: not defined!"
esac
echo ""
echo ""
done
