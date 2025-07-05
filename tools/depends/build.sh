#!/usr/bin/env -S bash
# Do not commit this file!

project_base=$HOME/Projects/kodi

#make distclean

#./bootstrap
./configure   --prefix=$project_base/kodi-deps \
              --host=arm-webos-linux-gnueabi \
              --with-cpu=cortex-a73 \
              --with-target-cflags='-mtune=cortex-a73 -march=armv8-a -mfloat-abi=softfp -mfpu=neon' \
              --with-toolchain=$project_base/kodi-dev/arm-webos-linux-gnueabi_sdk-buildroot \
              --enable-debug=no

make -j$(getconf _NPROCESSORS_ONLN)
