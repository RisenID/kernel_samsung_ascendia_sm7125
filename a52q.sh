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

PATH="$HOME/android/toolchains/clang/clang-r416183c2/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/android/toolchains/clang/clang-r416183c2/lib64:$LD_LIBRARY_PATH"
export ARCH=arm64

make ARCH=arm64 O=out vendor/a52q_eur_open_defconfig
make -j$(nproc --all) O=out ARCH=arm64 CC="ccache clang" AR="llvm-ar" NM="llvm-nm" LD="ld.lld" AS="llvm-as" STRIP="llvm-strip" OBJCOPY="llvm-objcopy" OBJDUMP="llvm-objdump" CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi-

echo " "
echo "Build Complete!"
echo " "

if [ -e "out/arch/arm64/boot/Image.gz" ]; then
    rm ../../builds/ascendia/sm7125/a52q/oneui_vanilla/dtb
    rm ../../builds/ascendia/sm7125/a52q/oneui_vanilla/kernel

    cp out/arch/arm64/boot/Image ../../builds/ascendia/sm7125/a52q/oneui_vanilla/kernel
    cp out/arch/arm64/boot/dts/qcom/atoll-ab-idp.dtb ../../builds/ascendia/sm7125/a52q/oneui_vanilla/dtb

    rm -rf out/

    echo " "
    echo "Making boot image"
    echo " "

    cd ../../builds/ascendia/sm7125/a52q/oneui_vanilla/
    magiskboot_x86 repack boot.img Ascendia_3.2_Vanilla_OneUI_a52q_boot.img

    rm ../../pack_vanilla/ascendia/a52/oneui.img
    cp Ascendia_3.2_Vanilla_OneUI_a52q_boot.img ../../pack_vanilla/ascendia/a52/oneui.img

    if [ ! -e ../../v3/3.2/ ]
    then
    echo " "
    echo "Making save dir"
    echo " "
    mkdir ../../v3/3.2
    fi

    mv Ascendia_3.2_Vanilla_OneUI_a52q_boot.img ../../v3/3.2/
else 
    echo " "
    echo "Build Failed :("
    echo " "
    rm -rf out/
fi
