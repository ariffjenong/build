#!/bin/bash

 cd /cirrus/rom
 . build/envsetup.sh
 lunch nad_maple_dsds-userdebug
 export CCACHE_DIR=/cirrus/ccache
 export CCACHE_EXEC=$(which ccache)
 export USE_CCACHE=1
 ccache -M 50G
 ccache -z
 export USE_GAPPS=true
 export TZ=Asia/Jakarta
make systemimage &
#make nad &  #dont remove that '&'
#sleep 107m #first running
#sleep 106m #second running
sleep 105m #third running
#sleep 104m #fourth running
kill %1

#make nad -j30 #finall
ccache -s