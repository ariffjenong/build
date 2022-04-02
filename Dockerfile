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
RUN apt-get install  --no-install-recommends -yqq expect git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig     ca-certificates bc cpio imagemagick bsdmainutils python2 python-is-python3 lz4 aria2 ccache rclone ssh-client libncurses5 libssl-dev rsync schedtool sudo lld zstd libzstd \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/apt/archives \
  && rm -rf /usr/share/doc/ /usr/share/man/ /usr/share/man/

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