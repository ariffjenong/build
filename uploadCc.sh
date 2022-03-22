#!/bin/bash

ccache_upload () {
	sleep 113m
	echo $(date +"%d-%m-%Y %T")
	time tar "-I zstd -1 -T2" -cf $1.tar.zst $1
	time rclone copy --drive-chunk-size 256M --stats 1s $1.tar.zst znxtproject:$1/$NAME -P
}

cd /tmp
ccache_upload ccache
