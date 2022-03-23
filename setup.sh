#!/bin/bash
cd /cirrus
ls -lh
time tar xf ccache.tar.gz
rm ccache.tar.gz brotli kati make ninja nsjail rclone-v1.58.0-linux-amd64 script zstd-1.5.2