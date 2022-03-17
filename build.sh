#!/bin/bash
# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
env

 cd ~/$ROM_PROJECT
 . build/envsetup.sh
 lunch lineage_maple_dsds-userdebug
 export SELINUX_IGNORE_NEVERALLOWS=true
 export CCACHE_DIR=~/znxt/ccache
 export CCACHE_EXEC=$(which ccache)
 export USE_CCACHE=1
 ccache -M 15G
 ccache -z
 export ALLOW_MISSING_DEPENDENCIES=true
 export WITH_GMS=false
 export BUILD_HOSTNAME=ArifJeNong
 export BUILD_USERNAME=ArifJeNong
 export TZ=Asia/Jakarta
 #curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="$(echo "${var_cache_report_config}")"
#make sepolicy -j24
#make bootimage -j24
#make init -j24
#make services
make bacon -j24 &  #dont remove that '&'
#sleep 50m #first running
#sleep 90m #second running
sleep 103m #third running
kill %1
 
#make bacon -j12
#curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Build $(cd ~/$ROM_PROJECT/out/target/product/maple_dsds/ && ls *maple*UNOFFICIAL*.zip) Completed!"
      
ccache -s