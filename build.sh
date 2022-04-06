#!/bin/bash
 cd /cirrus/rom
 . build/envsetup.sh
 lunch xdroid_maple_dsds-userdebug
 export CCACHE_DIR=/cirrus/ccache
 export CCACHE_EXEC=$(which ccache)
 export USE_CCACHE=1
 ccache -M 50G
 ccache -z
 export BUILD_HOSTNAME=znxt
 export BUILD_USERNAME=znxt
 export XDROID_BOOT=1080
 export XDROID_MAINTAINER=ArifJeNong
 export TZ=Asia/Jakarta

#get ccache first
make systemimage -j24 &
#make xd  -j24 &
sleep 103m #first running
#sleep 106m
kill %1
 
#build
#make xd -j24
ccache -s
