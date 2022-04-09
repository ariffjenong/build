#!/bin/bash

 cd /cirrus/rom
 . build/envsetup.sh
 lunch bliss_maple_dsds-user
 export CCACHE_DIR=/cirrus/ccache
 export CCACHE_EXEC=$(which ccache)
 export USE_CCACHE=1
 ccache -M 50G
 ccache -z
 export BUILD_HOSTNAME=znxt
 export BUILD_USERNAME=znxt
 #export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
 export TZ=Asia/Jakarta
 make installclean
blissify -g maple_dsds &
#make nad &  #dont remove that '&'
#sleep 108m #first running
#sleep 106m #second running
#sleep 104m #third running
sleep 89m #fourth running
kill %1

#blissify -g maple_dsds #finall
ccache -s