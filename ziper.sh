#!/bin/bash
cd ~/$ROM_PROJECT

com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}

rm -rf ~/$ROM_PROJECT/out/target/product/maple_dsds

time com out 1


#echo "$rclone_config" > ~/.config/rclone/rclone.conf
#curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Uploading ccache...."
time rclone copy out.tar.gz znxtproject:ccache/$ROM_PROJECT -P
#cd ~
#time com rom 1
ls -lh
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Uploading Success"
