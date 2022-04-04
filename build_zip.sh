#!/bin/bash

com () {
    #tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
    tar "-I zstd -1 -T2" -cf $1.tar.zst $1
}

get_ccache () {
  cd /cirrus
  time com ccache 1
  time rclone copy ccache.tar.* znxtproject:ccache/nadnew -P
  time rm ccache.tar.*
  ls -lh
}

system () {
  cd /cirrus/rom/out/target/product/maple_dsds/system/etc
  ls -lh
  time com selinux 1
  time rclone copy selinux.tar.* znxtproject:rom/Nusantara-Project/$ROM_PROJECT/system/etc -P
}

product () {
  cd /cirrus/rom/out/target/product/maple_dsds/system/product/etc
  ls -lh
  time com selinux 1
  time rclone copy selinux.tar.* znxtproject:rom/Nusantara-Project/$ROM_PROJECT/system/product/etc -P
}

system-ext () {
  cd /cirrus/rom/out/target/product/maple_dsds/system/system-ext/etc
  ls -lh
  time com selinux 1
  time rclone copy selinux.tar.* znxtproject:rom/Nusantara-Project/$ROM_PROJECT/system/system-ext/etc -P
}

vendor () {
  cd /cirrus/rom/out/target/product/maple_dsds/system/vendor/etc
  ls -lh
  time com selinux 1
  time rclone copy selinux.tar.* znxtproject:rom/Nusantara-Project/$ROM_PROJECT/system/vendor/etc -P
}

root () {
  cd /cirrus/rom/out/target/product/maple_dsds/recovery/root
  ls -lh
  time rclone copy sepolicy znxtproject:rom/Nusantara-Project/$ROM_PROJECT/system/ -P
}

get_selinux () {
  system
  product
  system-ext
  vendor
  root
}

#get_selinux
get_ccache

# Lets see machine specifications and environments
  df -h
  free -h
  nproc
  cat /etc/os*
