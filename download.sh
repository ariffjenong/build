#!/bin/bash

ccache_download () {
	mkdir -p ~/.config/rclone
	echo "$rclone_config" > ~/.config/rclone/rclone.conf
	time rclone copy znxtproject:ccache/$NAME/ccache.tar.gz /cirrus -P
	time tar xf ccache.tar.gz
	rm ccache.tar.gz
}

cd /cirrus
ccache_download
echo "CCACHE IS CONFIGURED"
