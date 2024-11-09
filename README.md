# network or dhcp of shell
脚本功能：
在 /etc/config/network 中的 config interface 'lan' 下插入 option gateway '10.10.10.1' 和 option dns '10.10.10.1'。
注释掉 /etc/config/dhcp 中的 config dhcp 'lan' 及其相关配置。
等待 3 秒后重启 dnsmasq 服务。
再等待 3 秒后重启网络服务。

# Backup of network  or dhcp
脚本特点：
备份配置文件，然后进行所需的配置修改
