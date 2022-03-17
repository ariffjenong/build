#!/bin/bash

cd ~/$ROM_PROJECT
repo init --depth=1 --no-repo-verify -u https://github.com/ariffjenong/android.git -b lineage-19.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/ariffjenong/local_manifest.git --depth=1 -b LOS19 .repo/local_manifests
cd .repo/manifests
sed -i '/darwin/d' default.xml
( find . -type f -name '*.xml' | xargs sed -i '/darwin/d' ) || true
git commit -a -m "Bump" || true
cd ../
sed -i '/darwin/d' manifest.xml
cd ../
