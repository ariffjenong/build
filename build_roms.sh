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
 make sepolicy
 make bootimage
 make init
make nad -j8 & # dont remove that '&'
sleep 70m
kill %1
ccache -s

cd ~/znxt

sleep 1m

com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}

time com ccache 1

mkdir -p ~/.config/rclone
echo "$rclone_config" > ~/.config/rclone/rclone.conf
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Uploading ccache...."
time rclone copy ccache.tar.gz znxt:ccache/nad12
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Uploading ccache Success"
