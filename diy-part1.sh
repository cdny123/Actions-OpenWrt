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

# 添加自定义feeds
echo "src-git helloworld https://github.com/fw876/helloworld" >> feeds.conf.default
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall" >> feeds.conf.default

# 更新feeds
./scripts/feeds update -a
./scripts/feeds install -a

# 设置内核版本为6.6
sed -i 's/^# CONFIG_KERNEL_PATCHVER=.*/CONFIG_KERNEL_PATCHVER="6.6"/' target/linux/x8ag6/config-6.6

# go版本到1.22后，编译碰到的问题
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# 添加 openwrt-package
sed -i '1i src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '2i src-git small https://github.com/kenzok8/small' feeds.conf.default
echo 'src-git cdny https://github.com/cdny123/openwrt-package1.git' >>feeds.conf.default

# 添加 APP 插件
git clone https://github.com/sirpdboy/chatgpt-web.git package/luci-app-chatgpt      # chatgpt-web
git clone https://github.com/sirpdboy/luci-theme-kucat.git package/luci-app-kucat   # kucat主题
git clone https://github.com/lq-wq/luci-app-quickstart.git package/luci-app-quickstart   # iStoreOS-web
git clone https://github.com/sirpdboy/luci-app-lucky.git package/lucky      # luci-app-lucky 端口转发

# 添加额外插件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
#git clone --depth=1 -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush package/luci-app-serverchan
#git clone --depth=1 https://github.com/ilxp/luci-app-ikoolproxy package/luci-app-ikoolproxy
#git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
#git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter
#git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata
#svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-filebrowser package/luci-app-filebrowser
#svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-ssr-mudb-server package/luci-app-ssr-mudb-server
#svn export https://github.com/immortalwrt/luci/branches/openwrt-18.06/applications/luci-app-eqos package/luci-app-eqos
# svn export https://github.com/syb999/openwrt-19.07.1/trunk/package/network/services/msd_lite package/msd_lite

# 科学上网插件
#git clone --depth=1 -b main https://github.com/fw876/helloworld package/luci-app-ssr-plus
#svn export https://github.com/haiibo/packages/trunk/luci-app-vssr package/luci-app-vssr
#git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb package/lua-maxminddb
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
#svn export https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/luci-app-passwall
#svn export https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2 package/luci-app-passwall2
#svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

# Themes主题
#git clone --depth=1 -b 18.06 https://github.com/kiddin9/luci-theme-edge package/luci-theme-edge
#git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
#git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
#git clone --depth=1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
#svn export https://github.com/haiibo/packages/trunk/luci-theme-atmaterial package/luci-theme-atmaterial
#svn export https://github.com/haiibo/packages/trunk/luci-theme-opentomcat package/luci-theme-opentomcat
#svn export https://github.com/haiibo/packages/trunk/luci-theme-netgear package/luci-theme-netgear

# iStore
#svn export https://github.com/linkease/istore-ui/trunk/app-store-ui package/app-store-ui
#svn export https://github.com/linkease/istore/trunk/luci package/luci-app-store
