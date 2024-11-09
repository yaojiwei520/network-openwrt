# network or dhcp of shell
#!/bin/sh

# 1. 在 /etc/config/network 中添加 gateway 和 dns
NETWORK_CONFIG="/etc/config/network"
if ! grep -q "option gateway '10.10.10.1'" "$NETWORK_CONFIG"; then
    sed -i "/^config interface 'lan'/a \ \ option gateway '10.10.10.1'\n \ option dns '10.10.10.1'" "$NETWORK_CONFIG"
    echo "已添加 gateway 和 dns 配置到 /etc/config/network"
else
    echo "gateway 和 dns 配置已存在"
fi

# 2. 注释掉 /etc/config/dhcp 中的相关配置
DHCP_CONFIG="/etc/config/dhcp"
if grep -q "config dhcp 'lan'" "$DHCP_CONFIG"; then
    sed -i "/^config dhcp 'lan'/,/^$/ s/^/#/" "$DHCP_CONFIG"
    echo "已注释掉 /etc/config/dhcp 中的 DHCP 配置"
else
    echo "DHCP 配置未找到"
fi

# 3. 重启 dnsmasq 服务
sleep 3
/etc/init.d/dnsmasq restart
echo "dnsmasq 服务已重启"

# 4. 重启网络服务
sleep 3
/etc/init.d/network restart
echo "网络服务已重启"

