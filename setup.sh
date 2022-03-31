#!/bin/bash
cd /cirrus
ls -lh
time tar xf ccache.tar.gz
time rm ccache.tar.gz
#time tar -xaf ccache.tar.zst
#time rm -rf ccache.tar.zst