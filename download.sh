#!/bin/bash

ccache_download () {
	rclone copy znxtproject:ccache/$NAME/ccache.tar.gz /tmp -P
	time tar xf ccache.tar.gz
	rm -rf ccache.tar.gz
}

cd /tmp
ccache_download
echo "CCACHE IS CONFIGURED"
