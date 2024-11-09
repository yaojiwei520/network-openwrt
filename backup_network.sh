#!/bin/sh

# 备份配置文件
echo "开始备份配置文件..."
cp /etc/config/network /etc/config/network.bank
if [ $? -eq 0 ]; then
    echo "备份完成: /etc/config/network 到 /etc/config/network.bank"
else
    echo "备份失败: /etc/config/network"
fi

cp /etc/config/dhcp /etc/config/dhcp.bank
if [ $? -eq 0 ]; then
    echo "备份完成: /etc/config/dhcp 到 /etc/config/dhcp.bank"
else
    echo "备份失败: /etc/config/dhcp"
fi

# 等待 2 秒
sleep 2

# 在 /etc/config/network 中添加 gateway 和 dns
NETWORK_CONFIG="/etc/config/network"
if ! grep -q "option gateway '10.10.10.1'" "$NETWORK_CONFIG"; then
    sed -i "/^config interface 'lan'/a \ \ option gateway '10.10.10.1'\n \ option dns '10.10.10.1'" "$NETWORK_CONFIG"
    echo "已添加 gateway 和 DNS 配置到 /etc/config/network"
else
    echo "gateway 和 DNS 配置已存在"
fi

# 等待 2 秒
sleep 2

# 注释掉 /etc/config/dhcp 中的相关配置
DHCP_CONFIG="/etc/config/dhcp"
if grep -q "config dhcp 'lan'" "$DHCP_CONFIG"; then
    sed -i "/^config dhcp 'lan'/,/^$/ s/^/#/" "$DHCP_CONFIG"
    echo "已注释掉 DHCP 配置在 /etc/config/dhcp"
else
    echo "未找到 DHCP 配置"
fi

# 等待 3 秒
sleep 3

# 重启 dnsmasq 服务
/etc/init.d/dnsmasq restart
echo "dnsmasq 服务已重启"

# 等待 5 秒
sleep 5

# 重启网络服务
/etc/init.d/network restart
echo "网络服务已重启"
