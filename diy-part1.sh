#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

#!/bin/bash

# 确保脚本在失败时退出
set -e

# 检查 feeds.conf.default 的语法
function check_feeds_conf {
    if ! grep -q '^src-git' feeds.conf.default; then
        echo "feeds.conf.default 文件格式错误，请检查。"
        exit 1
    fi
}

# Uncomment a feed source
echo "取消注释 helloworld 源..."
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# 检查 feeds.conf.default 文件格式
check_feeds_conf

# 添加 openwrt-package
echo "添加 openwrt-package 源..."
if ! grep -q "src-git openwrt-package" feeds.conf.default; then
    sed -i '$a src-git openwrt-package https://github.com/cdny123/openwrt-package.git' feeds.conf.default
    echo "成功添加 openwrt-package 源。"
else
    echo "openwrt-package 源已存在。"
fi

# 添加 APP 插件
echo "克隆 APP 插件..."
git clone https://github.com/sirpdboy/chatgpt-web.git package/luci-app-chatgpt      # chatgpt-web
git clone https://github.com/sirpdboy/luci-theme-kucat.git package/luci-app-kucat   # kucat主题
git clone https://github.com/lq-wq/luci-app-quickstart.git package/luci-app-quickstart   # iStoreOS-web
git clone https://github.com/sirpdboy/luci-app-lucky.git package/lucky      # luci-app-lucky 端口转发

echo "所有操作完成。"

