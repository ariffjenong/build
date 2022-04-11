#!/bin/bash

com ()
{
    #tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
    tar "-I zstd -1 -T2" -cf $1.tar.zst $1
}

get_ccache () {
cd /cirrus
time com ccache 1
time rclone copy ccache.tar.* znxtproject:ccache/$ROM_PROJECT -P
ls -lh
}

get_out () {
  cd /cirrus/rom
  time com out 9
  time rclone copy out.tar.* znxtproject:ccache/$ROM_PROJECT -P
  time rm out.tar.*
  ls -lh
}

sleep 104m
get_out
#get_ccache