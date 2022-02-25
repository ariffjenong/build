#!/bin/bash
# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
env

 cd ~/rom
 . build/envsetup.sh
 lunch nad_maple_dsds-userdebug
 export SELINUX_IGNORE_NEVERALLOWS=true
 export CCACHE_DIR=~/znxt/ccache
 export CCACHE_EXEC=$(which ccache)
 export USE_CCACHE=1
 ccache -M 20G
 ccache -o compression=true
 ccache -z
 export ALLOW_MISSING_DEPENDENCIES=true
 export TZ=Asia/Jakarta
 curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="$(echo "${var_cache_report_config}")"
 make nad -j8