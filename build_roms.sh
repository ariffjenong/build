#!/bin/bash
# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
env

 cd ~/Nusantara
 DEBIAN_FRONTEND=noninteractive
 export USE_CCACHE=1 >> ~/.bashrc
 ccache -M 40G
 . build/envsetup.sh
 export ALLOW_MISSING_DEPENDENCIES=true
 lunch nad_maple_dsds-userdebug
 export SELINUX_IGNORE_NEVERALLOWS = true
 curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="$(echo "${var_cache_report_config}")"
 mka nad && export SELINUX_IGNORE_NEVERALLOWS=true