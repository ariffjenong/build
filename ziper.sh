#!/bin/bash
cd ~/$ROM_PROJECT/out/target/product/maple_dsds

rm *txt *json *mk
time rm -rf system kernel root recovery ramdisk cache debug_ramdisk

cd ~/$ROM_PROJECT/out/target/product

com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}

time com maple_dsds 5


time rclone copy maple_dsds.tar.gz znxtproject:ccache/$ROM_PROJECT -P
ls -lh
curl -s https://api.telegram.org/$TG_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d text="Uploading Success"
