#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

kernel_v="$(cat include/kernel-version.mk | grep LINUX_KERNEL_HASH-5.* | cut -f 2 -d - | cut -f 1 -d ' ')"
echo "KERNEL=${kernel_v}" >> $GITHUB_ENV || true
sed -i "s?targets/%S/.*'?targets/%S/$kernel_v'?" include/feeds.mk

rm -rf package/feeds/kiddin9/{firewall,rtl88x2bu,base-files,netifd}

rm -rf devices/common/patches/{glinet,imagebuilder.patch,iptables.patch,targets.patch,kernel-defaults.patch,disable_flock.patch}

git am devices/mediatek_gl_mt7981/patches/glinet/*.patch

sed -i "s/BOARD:=mediatek$/BOARD:=mediatek_gl/" target/linux/mediatek/Makefile
mv -f target/linux/mediatek target/linux/mediatek_gl




连感冒药都没做储备更别提其他医疗资源,就突然完全放开,躺匪真的让人受不了