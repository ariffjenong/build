#!/bin/bash

cd ~/$ROM_PROJECT
rm -fv .repo/local_manifests/*
repo init --depth=1 --no-repo-verify --partial-clone --clone-filter=blob:limit=10M -u https://github.com/ariffjenong/android.git -b lineage-19.1 -g default,-mips,-darwin,-notdefault
wget https://raw.githubusercontent.com/ariffjenong/local_manifest/LOS19/roomservices.xml -O .repo/local_manifests/roomservices.xml
repo forall -j"$(nproc)" -c "git reset --hard m/pie && git clean -fdx"
repo sync frameworks/base