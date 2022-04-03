#!/bin/bash
cd /cirrus/rom
    
sync () {
    #rm -rf .repo/local_manifests
    repo init --depth=1 --no-repo-verify -u https://github.com/xdroid-oss/xd_manifest.git -b twelve-dev -g default,-mips,-darwin,-notdefault
    git clone https://github.com/ariffjenong/local_manifest.git --depth=1 -b xdroid .repo/local_manifests
    repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24
}

compile () {
    sync
    echo "done."
}

patch () {
  cd device/sony/maple_dsds
  wget https://raw.githubusercontent.com/Flamefire/android_device_sony_lilac/lineage-19.0/patches/applyPatches.sh
  wget https://raw.githubusercontent.com/Flamefire/android_device_sony_lilac/lineage-19.0/patches/workaround_egl_lib_symbols.patch
  git add . && git commit -m 'apply path'
}

ls -lh
compile
patch

# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
