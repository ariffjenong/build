#!/bin/bash
cd ~/rom/out/target/product

com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}

time com maple_dsds 9
rm -rf maple_dsds
cd ..

time com product 9


#curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Uploading ccache...."
time rclone copy product.tar.gz znxtproject:rom/cherish-12.1 -P
#cd ~
#time com rom 1
ls -lh
#curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Uploading Success"
