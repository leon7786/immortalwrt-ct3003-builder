#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

mkdir -p files/etc/uci-defaults

cat <<'EOF' > files/etc/uci-defaults/99-custom-defaults
#!/bin/sh

uci set network.lan.ipaddr='192.168.12.1'
uci set network.lan.netmask='255.255.255.0'
uci delete network.wan6 2>/dev/null
uci commit network

ROOT_HASH='$6$y4b3SnIazjlcQnqh$hhdmdHH6kQ2YznMcDdJDnkl2o3BRi3k3SMleUJBkMcNtCD8AlDh2hScFQ0xy5xEN1C9XkKePmVn2g1UM9C/qh/'
sed -i "s#^root:[^:]*:#root:${ROOT_HASH}:#" /etc/shadow

rm -f /etc/uci-defaults/99-custom-defaults
exit 0
EOF

chmod +x files/etc/uci-defaults/99-custom-defaults
