#!/bin/bash
 cd /cirrus/rom

 . build/envsetup.sh
 lunch cherish_maple_dsds-user
 export CCACHE_DIR=/cirrus/ccache
 export CCACHE_EXEC=$(which ccache)
 export USE_CCACHE=1
 ccache -M 50G
 ccache -z
 export BUILD_HOSTNAME=znxt
 export BUILD_USERNAME=znxt
 export TZ=Asia/Jakarta
#make sepolicy -j24
#make bootimage -j24
#make systemimage &
make installclean
mka bacon -j30 & #dont remove that '&'
#sleep 108m #first running
sleep 90m #second running
#sleep 105m #third running
#sleep 104m #fourth running
kill %1
 
#mka bacon -j24
ccache -s
