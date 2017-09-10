#!/bin/sh
#此脚本用于 删除AD hosts内所有与dnsmasq AD.conf有关的域名，大量减少hosts条目。生成新hosts与union.conf可用于路由器使用。

#路径自己改
cd /storage/sdcard1/dnsmasq

#下载AD hosts与AD dnsmasq文件，
#curl -o hosts -k https://raw.githubusercontent.com/vokins/yhosts/master/hosts
#curl -o union.conf -k https://raw.githubusercontent.com/vokins/yhosts/master/dnsmasq/union.conf

#提取union.conf里的域名
awk -F/ '{print $2}' union.conf > domain
sed -i 's#^\.##g' domain

#使用循环来批量删除ADhosts里包含domain文件里的域名
for abc in $(cat domain)
do
sed -i "/$abc/d" hosts
done

rm domain


