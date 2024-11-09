#!/bin/sh

# 备份原始的 distfeeds.conf 文件
cp /etc/opkg/distfeeds.conf /etc/opkg/distfeeds.conf.backup

# 使用 sed 命令替换 URL
sed -i 's_https\?://downloads.openwrt.org_https://mirrors.tuna.tsinghua.edu.cn/openwrt_' /etc/opkg/distfeeds.conf

echo "已将下载源更改为清华镜像源。"
