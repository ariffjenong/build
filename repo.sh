#!/bin/bash
cd /cirrus/rom

rm -rf .repo/local_manifests
repo init --depth=1 --no-repo-verify -u https://github.com/CherishOS/android_manifest.git -b twelve-one -g default,-mips,-darwin,-notdefault
git clone https://github.com/ariffjenong/local_manifest.git --depth=1 -b $ROM_PROJECT .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8