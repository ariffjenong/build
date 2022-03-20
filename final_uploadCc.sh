#!/bin/bash

# Sorting final zip
compiled_zip() {
	ZIP=$(find $(pwd)/rom/out/target/product/${T_DEVICE}/ -maxdepth 1 -name "*${T_DEVICE}*.zip" | perl -e 'print sort { length($b) <=> length($a) } <>' | head -n 1)
	ZIPNAME=$(basename ${ZIP})
}

# Final ccache upload
ccache_upload_final () {
	time tar "-I zstd -1 -T16" -cf $1.tar.zst $1
	rclone copy --drive-chunk-size 256M --stats 1s $1.tar.zst znxtproject:$1/$NAME -P
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

cd /tmp
compiled_zip
sleep_on_error
