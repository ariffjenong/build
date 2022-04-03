#!/bin/bash
 cd /cirrus/rom
 . build/envsetup.sh
 lunch cherish_maple_dsds-userdebug
 export CCACHE_DIR=/cirrus/ccache
 export CCACHE_EXEC=$(which ccache)
 export USE_CCACHE=1
 ccache -M 50G
 ccache -z
 #export CHERISH_VANILLA=true
 #export ALLOW_MISSING_DEPENDENCIES=true
 export BUILD_HOSTNAME=linux
 export BUILD_USERNAME=ArifJeNong
 export TZ=Asia/Jakarta
mka bacon -j24 & #dont remove that '&'
sleep 106m #first running
#sleep 105m #second running
#sleep 104m #third running
kill %1
 
#mka bacon -j24
#ccache -s
