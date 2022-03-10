#!/bin/bash

cd ~/rom/out/target/product/maple_dsds


sudo apt-get update -y && sudo apt-get install expect -y

product=$(ls *maple_dsds*UNOFFICIAL*.zip)
md5sum=$(ls *.md5sum)
project=xperia-xz-premium/maple_dsds

# Upload
expect -c "
spawn sftp $SF_USERNAME@frs.sourceforge.net:/home/pfs/project/$project
expect \"yes/no\"
send \"yes\r\"
expect \"Password\"
send \"$SF_PASS\r\"
expect \"sftp> \"
send \"mkdir bliss-12\r\"
set timeout -1
expect \"sftp> \"
send \"cd bliss-12\r\"
set timeout -1
send \"put $product\r\"
expect \"Uploading\"
expect \"100%\"
expect \"sftp>\"
send \"put $md5sum\r\"
expect \"Uploading\"
expect \"100%\"
expect \"sftp>\"
send \"bye\r\"
interact"

# Post
curl -s -v -F "chat_id=$TG_CHAT_ID" -F "parse_mode=html" -F text="Build completed successfully!!!
Link: https://sourceforge.net/projects/xperia-xz-premium/files/maple_dsds/bliss-12/$product
Dev : ""Arif JeNong""
Product : ""$product""
Device : ""maple_dsds""
Server Host : cirrus-ci
Date : ""$(env TZ=Asia/Jakarta date)""" https://api.telegram.org/$TG_TOKEN/sendMessage
