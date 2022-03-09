#!/bin/bash
cd ~

com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}

time com android_frameworks_base 7


#echo "$rclone_config" > ~/.config/rclone/rclone.conf
#curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Uploading ccache...."
time rclone copy android_frameworks_base.tar.gz znxtproject:git -P
#cd ~
#time com rom 1
ls -lh
#curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Uploading Success"
