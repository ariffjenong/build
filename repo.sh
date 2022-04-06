#!/bin/bash
cd /cirrus/rom
    
sync () {
    #rm -rf .repo/local_manifests
    repo init --depth=1 --no-repo-verify -u https://github.com/BlissRoms/platform_manifest.git -b arcadia -g default,-mips,-darwin,-notdefault
    git clone https://github.com/ariffjenong/local_manifest.git --depth 1 -b $ROM_PROJECT .repo/local_manifests
    repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24
}

compile () {
    sync
    echo "done."
}

cherry_pick () {
  cd build
  git fetch https://github.com/LineageOS/android_build refs/changes/79/322579/1 && git cherry-pick FETCH_HEAD
  cd ../bionic
  git fetch https://github.com/LineageOS/android_bionic refs/changes/80/322580/2 && git cherry-pick FETCH_HEAD
  cd ../build/soong
  git fetch https://github.com/LineageOS/android_build_soong refs/changes/78/322578/1 && git cherry-pick FETCH_HEAD
}

ls -lh
compile
cherry_pick

# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
