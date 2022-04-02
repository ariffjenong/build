FROM ubuntu:18.04
LABEL maintainer="ariffjenong <arifbuditantodablekk@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV LANGUAGE=en_GB.UTF-8
ENV LANG=en_GB.UTF-8
ENV LC_ALL=en_GB.UTF-8
ENV JAVA_OPTS=" -Xmx7G "
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV CCACHE_DIR=/cirrus/ccache
ENV USE_CCACHE=1
ENV KERNEL_USE_CCACHE=1
ENV CIRRUS_CLONE_DEPTH=1
ENV TZ=Asia/Jakarta

WORKDIR /cirrus

RUN apt-get -yqq update
RUN apt-get -yqq upgrade
RUN apt-get install  --no-install-recommends -yqq expect cloud-guest-utils iproute2 libxml2-dev libxslt1-dev libmemcached-dev awscli libgd-dev libzip-dev asciidoctor docbook-xml docbook-xsl elfutils bash libhiredis-dev redis-server redis-tools sudo tzdata locales python-is-python3 python3-pip pigz tar rsync rclone aria2 ccache curl wget zip unzip lzip lzop zlib1g-dev xzdec xz-utils pixz p7zip-full p7zip-rar zstd libzstd-dev lib32z1-dev ffmpeg maven nodejs ca-certificates-java pigz tar rsync rclone aria2 libncurses5 adb autoconf automake axel bc bison build-essential ccache clang cmake brotli curl expat fastboot flex g++ g++-multilib gawk gcc gcc-multilib git gnupg gperf htop imagemagick locales libncurses5 lib32ncurses5-dev lib32z1-dev libtinfo5 libc6-dev libcap-dev libexpat1-dev libgmp-dev '^liblz4-.*' '^liblzma.*' libmpc-dev libmpfr-dev libncurses5-dev libsdl1.2-dev libssl-dev libtool libxml-simple-perl libxml2 libxml2-utils lsb-core lzip '^lzma.*' lzop maven nano ncftp ncurses-dev openssh-server sshpass patch patchelf pkg-config pngcrush pngquant python2.7 python-all-dev re2c rclone rsync schedtool squashfs-tools subversion sudo tar texinfo tmate tzdata unzip w3m wget xsltproc zip zlib1g-dev zram-config zstd axel flex bison ncurses-dev texinfo gcc gperf patch libtool automake g++ libncurses5-dev gawk subversion expat libexpat1-dev python-all-dev binutils-dev bc libcap-dev autoconf libgmp-dev build-essential pkg-config libmpc-dev libmpfr-dev autopoint gettext txt2man liblzma-dev libssl-dev libz-dev mercurial wget tar gcc-10 g++-10 cmake ninja-build zstd lz4 liblz4-tool liblz4-dev lzma openjdk-11-jdk golang-go lsb-release wget software-properties-common --fix-broken --fix-missing
RUN apt-get install tzdata
RUN apt-mark hold tzdata
RUN echo 'en_GB.UTF-8 UTF-8' > /etc/locale.gen
RUN /usr/sbin/locale-gen
RUN ln -snf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
RUN echo Asia/Jakarta > /etc/timezone
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
RUN apt install sudo git -yqq
RUN python3 -m pip  install networkx
RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN git config --global user.name ariffjenong
RUN git config --global user.email arifbuditantodablekk@gmail.com
RUN git clone https://github.com/akhilnarang/scripts scripts

WORKDIR /cirrus/scripts

RUN bash setup/android_build_env.sh

WORKDIR /cirrus

RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /cirrus/*
RUN for t in gcc g++ cc c++ clang clang++; do ln -vs /usr/bin/ccache /usr/local/bin/$t; done
RUN rm -rf /var/lib/dpkg/info/*.postinst
RUN dpkg --configure -a
RUN mkdir rom

WORKDIR /cirrus/rom

RUN repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-19.1 -g default,-mips,-darwin,-notdefault \
    && git clone https://github.com/ariffjenong/local_manifest.git --depth=1 -b LOS19 .repo/local_manifests \
    && repo sync external/lottie external/ims external/icing external/icu system/linkerconfig system/libvintf system/libbase external/json-c external/ant-wireless/hidl external/ant-wireless/ant_service external/ant-wireless/ant_native external/ant-wireless/ant_client hardware/qcom-caf/common hardware/qcom-caf/wlan hardware/qcom-caf/vr hardware/qcom-caf/thermal lineage/scripts vendor/codeaurora/telephony lineage/crowdin android device/lineage/atv device/lineage/car device/lineage/sepolicy external/bash external/chromium-webview external/exfatprogs external/htop external/libncurses external/nano external/tinyxml hardware/lineage/interfaces hardware/lineage/livedisplay external/vim prebuilts/runtime prebuilts/rust build/make system/apex system/bt system/core system/media device/qcom/sepolicy device/qcom/sepolicy-legacy-um hardware/qcom-caf/msm8998/audio hardware/qcom/audio bionic art sdk prebuilts/extract-tools prebuilts/tools-lineage vendor/lineage frameworks/native frameworks/av frameworks/base kernel/sony/msm8998 device/sony/maple_dsds device/sony/yoshino-common vendor/sony/maple_dsds -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24


VOLUME ["/cirrus/rom", "/cirrus/ccache"]

WORKDIR /cirrus/rom

ENTRYPOINT ["/bin/bash"]