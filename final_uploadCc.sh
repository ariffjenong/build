#!/bin/bash

# Sorting final zip
compiled_zip() {
	ZIP=$(find $(pwd)/rom/out/target/product/${T_DEVICE}/ -maxdepth 1 -name "*${T_DEVICE}*.zip" | perl -e 'print sort { length($b) <=> length($a) } <>' | head -n 1)
	ZIPNAME=$(basename ${ZIP})
}

# Final ccache upload
ccache_upload_final () {
	time tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
	time rclone copy --drive-chunk-size 256M --stats 1s $1.tar.gz znxtproject:$1/$NAME -P
}

# Let session sleep on error for debug
sleep_on_error() {
	if [ -f $(pwd)/rom/out/target/product/${T_DEVICE}/${ZIPNAME} ]; then
		ccache_upload_final ccache
	else
		ccache_upload_final ccache
		sleep 2h
	fi
}

cd /cirrus
compiled_zip
sleep_on_error
