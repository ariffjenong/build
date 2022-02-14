#!/bin/bash
cd ~/rom

. build/envsetup.sh
blissify -v $LUNCH
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="$(echo "${var_cache_report_config}")"
