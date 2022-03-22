#!/bin/bash

ccache_upload () {
	sleep 6820
	echo $(date +"%d-%m-%Y %T")
	time tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
	time rclone copy --drive-chunk-size 256M --stats 1s $1.tar.gz znxtproject:$1/$NAME -P
}

cd /tmp
ccache_upload ccache
