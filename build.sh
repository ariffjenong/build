#!/bin/bash
# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
env

 cd /cirrus/rom
 . build/envsetup.sh
 lunch dot_maple_dsds-user
 export CCACHE_DIR=/cirrus/ccache
 export CCACHE_EXEC=$(which ccache)
 export USE_CCACHE=1
 ccache -M 50G
 ccache -z
 #export ALLOW_MISSING_DEPENDENCIES=true
 #export SELINUX_IGNORE_NEVERALLOWS=true
 export BUILD_HOSTNAME=ArifJeNong
 export BUILD_USERNAME=ArifJeNong
 export WITH_GAPPS=true
 export TZ=Asia/Jakarta
 #curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="$(echo "${var_cache_report_config}")"
#make sepolicy -j24
#make bootimage -j24
#make init -j24
#make services
#make systemimage &
make bacon -j24 & #dont remove that '&'
#sleep 50m #first running
sleep 104m #second running
#sleep 106m #third running
kill %1
 
#make bacon -j24
ccache -s
