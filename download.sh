#!/bin/bash

ccache_download () {
	mkdir -p ~/.config/rclone
	echo "$rclone_config" > ~/.config/rclone/rclone.conf
	time rclone copy znxtproject:ccache/$NAME/ccache.tar.zst /tmp -P
	time tar -xaf ccache.tar.zst
	rm ccache.tar.zst
}

cd /tmp
ccache_download
echo "CCACHE IS CONFIGURED"
