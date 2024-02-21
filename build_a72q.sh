#!/bin/bash

PATH="../../toolchains/clang/clang-r383902/bin:../../toolchains/gcc/aarch64/bin:../../toolchains/gcc/arm/bin:${PATH}"

export ARCH=arm64

make ARCH=arm64 O=out vendor/a72q_eur_open_defconfig

make ARCH=arm64 O=out -j24 CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi-

# tools/mkdtimg create arch/arm64/boot/dtbo.img --page_size=4096 $(find arch -name "*.dtbo")
