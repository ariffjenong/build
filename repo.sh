#!/bin/bash

cd /rom
rm -rf .repo/local_manifests
repo init --depth=1 --no-repo-verify -u https://github.com/ariffjenong/android.git -b lineage-19.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/ariffjenong/local_manifest.git --depth=1 -b LOS19 .repo/local_manifests
repo forall -c "git reset --hard && git clean -fdx"