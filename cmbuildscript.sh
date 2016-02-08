#!/bin/bash
# Add ~/bin to path
export PATH=$PATH:~/bin

NumThreads=`grep 'processor' /proc/cpuinfo | wc -l`
echo ""
echo ""
echo "CyanogenMod 12.1 Build Script for Galaxy Core Prime."
echo ""
echo ""

while [ "$progress" != "finished" ]; do
echo "1) Sync sources."
echo "2) make clean."
echo "3) Build ROM."
echo "4) Exit script."
echo ""
echo ""
echo "Sync sources. - Downloads the latest CyanogenMod source. Important you run this before attempting to build."
echo "make clean - Deletes the 'OUT' folder so ROM can be built from scratch. Optional, but recommended."
echo "Build CM. - Self explainatory."
echo "Close - Exits this script."
echo ""
echo ""
echo -n "Select an option: "
read option
echo ""
echo ""

case  $option in
  1)
    echo "Attempting to sync sources..."
    mkdir CM-12.1 && cd CM-12.1
    repo init -u https://github.com/CyanogenMod/android.git -b cm-12.1
    curl --create-dirs -L -o .repo/local_manifests/local_manifest.xml -O -L https://raw.githubusercontent.com/PlatinumMaster/android_local_manifest/cm-12.1/local_manifest.xml
    repo sync -j$NumThreads
    ;;
  2)
    echo "Cleaning the OUT directory..."
    make clean -j$NumThreads
    ;;
  3)
    echo "Building ROM..."
    . build/envsetup.sh && brunch cm_cprimeltemtr-userdebug
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
