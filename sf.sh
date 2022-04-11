#!/bin/bash


sudo apt-get update -y && sudo apt-get install expect -y

upload_maple_dsds () {
cd ~/rom/out/target/product/maple_dsds

GAPPS=$(ls *Gapps*.zip)
product=$(ls *Vanilla*.zip)
#product=$(ls *2314*.zip)
project=xperia-xz-premium/CherishOS/twelve-one/maple_dsds

# Upload
expect -c "
spawn sftp $SF_USERNAME@frs.sourceforge.net:/home/pfs/project/$project
expect \"yes/no\"
send \"yes\r\"
expect \"Password \"
send \"${SF_PASS}\r\"
expect \"sftp> \"
send \"cd maple_dsds\r\"
set timeout -1
send \"put $product\r\"
expect \"Uploading\"
expect \"100%\"
expect \"sftp>\"
send \"put $GAPPS\r\"
expect \"Uploading\"
expect \"100%\"
expect \"sftp>\"
send \"bye\r\"
interact"

# Post
curl -s -v -F "chat_id=$TG_CHAT_ID" -F "parse_mode=html" -F text="Build completed successfully!!!
Link: https://sourceforge.net/projects/xperia-xz-premium/files/maple_dsds/$ROM_PROJECT/$GAPPS
Link: https://sourceforge.net/projects/xperia-xz-premium/files/maple_dsds/$ROM_PROJECT/$product
Dev : ""Arif JeNong""
Product : ""$product"" ""$GAPPS""
Device : ""maple_dsds""
Server Host : cirrus-ci
Date : ""$(env TZ=Asia/Jakarta date)""" https://api.telegram.org/$TG_TOKEN/sendMessage
}

upload_maple () {
cd ~/rom/out/target/product/maple

productGAPPS=$(ls *Gapps*.zip)
productmaple=$(ls *Vanilla*.zip)
projectmaple=xperia-xz-premium/CherishOS/twelve-one/maple

# Upload
expect -c "
spawn sftp $SF_USERNAME@frs.sourceforge.net:/home/pfs/project/$projectmaple
expect \"yes/no\"
send \"yes\r\"
expect \"Password \"
send \"${SF_PASS}\r\"
expect \"sftp>\"
send \"put $productGAPPS\r\"
expect \"Uploading\"
expect \"100%\"
expect \"sftp>\"
send \"put $productmaple\r\"
expect \"Uploading\"
expect \"100%\"
expect \"sftp>\"
send \"bye\r\"
interact"

# Post
curl -s -v -F "chat_id=$TG_CHAT_ID" -F "parse_mode=html" -F text="Build completed successfully!!!
Link: https://sourceforge.net/projects/xperia-xz-premium/files/maple/$ROM_PROJECT/$productGAPPS
Link: https://sourceforge.net/projects/xperia-xz-premium/files/maple/$ROM_PROJECT/$productmaple
Dev : ""Arif JeNong""
Product : ""$productmaple"" ""productGAPPS""
Device : ""maple""
Server Host : cirrus-ci
Date : ""$(env TZ=Asia/Jakarta date)""" https://api.telegram.org/$TG_TOKEN/sendMessage
}

#upload_maple_dsds
upload_maple
