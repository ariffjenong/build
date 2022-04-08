#!/bin/bash
# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
env

 cd /cirrus/rom
 . build/envsetup.sh
 lunch dot_maple_dsds-user
 export CCACHE_DIR=/cirrus/ccache
 export CCACHE_EXEC=$(which ccache)
 export USE_CCACHE=1
 ccache -M 50G
 ccache -z
 export BUILD_HOSTNAME=znxt
 export BUILD_USERNAME=znxt
 export WITH_GAPPS=true
 export TZ=Asia/Jakarta
#make systemimage &
make installclean
#make bacon -j24 & #dont remove that '&'
#sleep 50m #first running
#sleep 90m #second running
#sleep 106m #third running
#kill %1
 
make bacon -j24
ccache -s
