#!/bin/bash
# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
env

 cd ~/rom/Nusantara
 . build/envsetup.sh
 lunch nad_maple_dsds-userdebug
 export CCACHE_DIR=~/ccache
 export CCACHE_EXEC=$(which ccache)
 export USE_CCACHE=1
 ccache -M 20G # It took only 6.4GB for mido
 ccache -o compression=true # Will save times and data to download and upload ccache, also negligible performance issue
 ccache -z # Clear old stats, so monitor script will provide real ccache statistics
 export ALLOW_MISSING_DEPENDENCIES=true
 export SELINUX_IGNORE_NEVERALLOWS=true
 curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="$(echo "${var_cache_report_config}")"
 make nad