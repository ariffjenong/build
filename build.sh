#!/bin/bash
# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
env

 cd ~/rom
 . build/envsetup.sh
 lunch bliss_maple_dsds-userdebug
 #export SELINUX_IGNORE_NEVERALLOWS=true
 export CCACHE_DIR=~/znxt/ccache
 export CCACHE_EXEC=$(which ccache)
 export USE_CCACHE=1
 ccache -M 8G
 ccache -z
 export ALLOW_MISSING_DEPENDENCIES=true
 PRODUCT_PACKAGES += \
    vendor.lineage.touch*
 export TZ=Asia/Jakarta
 #curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="$(echo "${var_cache_report_config}")"
make sepolicy -j24
make bootimage -j24
make init -j24
make services
make art
blissify -v maple_dsds -j24 &  #dont remove that '&'
sleep 45m #first running
#sleep 100m #second running
kill %1

#make nad -j30  \ #finall
#      &&  curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Build $(cd ~/rom/out/target/product/maple_dsds/ && ls *maple_dsds*UNOFFICIAL*.zip) Completed!"
      
ccache -s