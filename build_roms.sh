#!/bin/bash
# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
env

 cd ~/Bliss
 DEBIAN_FRONTEND=noninteractive
 export USE_CCACHE=1 >> ~/.bashrc
 ccache -M 40G
 . build/envsetup.sh && export ALLOW_MISSING_DEPENDENCIES=true
 export SELINUX_IGNORE_NEVERALLOWS=true
 curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="$(echo "${var_cache_report_config}")"
 blissify -v $LUNCH && curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="$(echo "${var_cache_report_config}")"