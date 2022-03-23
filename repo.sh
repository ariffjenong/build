#!/bin/bash
cd /cirrus/rom

ls -lh .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
