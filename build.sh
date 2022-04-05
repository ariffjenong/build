#!/bin/bash

 cd /cirrus/rom
 . build/envsetup.sh
 lunch nad_maple_dsds-userdebug
 export CCACHE_DIR=/cirrus/ccache
 export CCACHE_EXEC=$(which ccache)
 export USE_CCACHE=1
 ccache -M 50G
 ccache -z
 #export ALLOW_MISSING_DEPENDENCIES=true
 export USE_GAPPS=true
 export TZ=Asia/Jakarta
 #curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="$(echo "${var_cache_report_config}")"
#make sepolicy -j24
#make bootimage -j24
#make init -j24
#make services
make nad &  #dont remove that '&'
#sleep 83m #first running
#sleep 100m #second running
sleep 106m #third running
kill %1

#make nad -j30 #finall
ccache -s