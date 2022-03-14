#!/bin/bash
cd ~/$ROM_PROJECT
repo init --depth=1 --no-repo-verify -u git://github.com/NusantaraProject-ROM/android_manifest.git -b 12 -g default,-mips,-darwin,-notdefault
git clone https://github.com/ariffjenong/local_manifest.git --depth 1 -b $ROM_PROJECT .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24
