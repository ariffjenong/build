#!/bin/bash
cd /cirrus/rom
    
sync () {
    #rm -rf .repo/local_manifests
    repo init --depth=1 --no-repo-verify -u https://github.com/xdroid-oss/xd_manifest.git -b xdroid-dev -g default,-mips,-darwin,-notdefault
    git clone https://github.com/ariffjenong/local_manifest.git --depth=1 -b xdroid .repo/local_manifests
    repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24
}

compile () {
    sync
    echo "done"
}

ls -lh
compile

# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
env
