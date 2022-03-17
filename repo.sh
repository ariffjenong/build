#!/bin/bash

cd ~/$ROM_PROJECT
rm -rf .repo/local_manifests
repo init --depth=1 --no-repo-verify --partial-clone --clone-filter=blob:limit=10M -u https://github.com/ariffjenong/android.git -b lineage-19.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/ariffjenong/local_manifest.git --depth=1 -b LOS19 .repo/local_manifests
repo forall -j"$(nproc)" -c "git reset --hard m/pie && git clean -fdx"
repo sync frameworks/base -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8