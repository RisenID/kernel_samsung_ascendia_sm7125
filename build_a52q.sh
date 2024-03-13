#!/bin/bash

if [ -e KernelSU/ ]
then
    echo " "
    echo " Deleteting KernelSU/ "
    echo " "
    rm -rf KernelSU
fi

if [ -e out/ ]
then
    echo " "
    echo " Deleteting out/ "
    echo " "
    rm -rf out
fi

PATH="../../toolchains/clang/clang-r383902/bin:../../toolchains/gcc/aarch64/bin:../../toolchains/gcc/arm/bin:${PATH}"

export ARCH=arm64

make ARCH=arm64 O=out vendor/a52q_eur_open_defconfig

make ARCH=arm64 O=out -j24 CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi-

echo " "
echo "Build Complete!"
echo " "

rm ../builds/ascendia/a52q/aosp_vanilla/dtb
rm ../builds/ascendia/a52q/aosp_vanilla/kernel

cp out/arch/arm64/boot/Image ../builds/ascendia/a52q/aosp_vanilla/kernel
cp out/arch/arm64/boot/dts/qcom/atoll-ab-idp.dtb ../builds/ascendia/a52q/aosp_vanilla/dtb

rm -rf out/

echo " "
echo "Making boot image"
echo " "

cd ../builds/ascendia/a52q/aosp_vanilla/
magiskboot_x86 repack boot.img Ascendia_3.1_Vanilla_AOSP_a52q_boot.img

rm ../../pack_vanilla/ascendia/a52/aosp.img
cp Ascendia_3.1_Vanilla_AOSP_a52q_boot.img ../../pack_vanilla/ascendia/a52/aosp.img
