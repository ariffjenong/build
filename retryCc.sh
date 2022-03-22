#!/bin/bash

# Sorting final zip
compiled_zip() {
	ZIP=$(find $(pwd)/out/target/product/${T_DEVICE}/ -maxdepth 1 -name "*${T_DEVICE}*.zip" | perl -e 'print sort { length($b) <=> length($a) } <>' | head -n 1)
	ZIPNAME=$(basename ${ZIP})
}

# Retry the ccache fill for 99-100% hit rate
retry_ccache () {
	export CCACHE_DIR=/tmp/ccache
	export CCACHE_EXEC=$(which ccache)
	hit_rate=$(ccache -s | awk '/hit rate/ {print $4}' | cut -d'.' -f1)
	if [ $hit_rate -lt 99 ]; then
		git clone ${TOKEN}/ariffjenong/build -b cherish-12.1_new cirrus && cd $_
		folder=pwd
		rm retryCc.sh download.sh
		time rclone copy znxtproject:github/retryCc.sh $folder -P
		time rclone copy znxtproject:github/download.sh $folder -P
		git add .
		git commit --allow-empty -m "Retry: Ccache loop $(date -u +"%D %T%p %Z")"
		git push -q
	else
		echo "Ccache is fully configured"
	fi
}

# Trigger retry only if compilation is not finished
retry_event() {
	if [ -f $(pwd)/out/target/product/${T_DEVICE}/${ZIPNAME} ]; then
		echo "Successful Build"
	else
		retry_ccache
	fi
}

cd /tmp/rom && sleep 7125
compiled_zip
retry_event
