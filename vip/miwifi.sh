#!/bin/sh

cd /etc && rm -rf /etc/hosts && curl -o hosts -k https://raw.githubusercontent.com/vokins/yhosts/master/hosts && cd /etc/dnsmasq.d && curl -o dnsfq.conf -k https://raw.githubusercontent.com/ss916/bug/master/dnsmasq/dnsfq && curl -o ip.conf -k https://raw.githubusercontent.com/vokins/yhosts/master/dnsmasq/ip.conf && curl -o union.conf -k https://raw.githubusercontent.com/vokins/yhosts/master/dnsmasq/union.conf && /etc/init.d/dnsmasq restart

echo "* ����ʱ����crontabs��д�붨ʱִ������"
#���һ��ִ�нű�
http_username=`nvram get http_username`
sed -i '/\/dns\//d' /etc/crontabs/$http_username
cat >> /etc/crontabs/$http_username << EOF
1 0 * * * sh /etc/dnsmasq.d/mi.sh
EOF

echo "* ���Զ���ű���� WAN ����/����������ִ�С�д�����ʵ����������ʱ�Զ�����dnsmasq"
sed -i '/\/dns\//d' /etc/storage/post_wan_script.sh
cat >> /etc/storage/post_wan_script.sh << EOF
sh /etc/storage/dnsmasq/dns/start.sh
EOF

echo " "
rm -rf /etc/storage/dnsmasq/dns;mkdir -p /etc/storage/dnsmasq/dns
echo "����������������������start.sh��del.sh�ű�����������������������"
wget --no-check-certificate https://raw.githubusercontent.com/ss916/bug/master/dnsmasq/sh/start.sh -O /etc/storage/dnsmasq/dns/start.sh
wget --no-check-certificate https://raw.githubusercontent.com/ss916/bug/master/dnsmasq/sh/del.sh -O /etc/storage/dnsmasq/dns/del.sh
echo " "
echo "������������������ִ��start.sh�ű����Զ����ع����ļ�����������������������"
#chmod 775 /etc/storage/dnsmasq/dns/start.sh
sh /etc/storage/dnsmasq/dns/start.sh
echo " "
echo "�������������������������ű���������������������������������"
echo "* ���軹ԭ�޸ģ�ֻ��������� sh /etc/storage/dnsmasq/dns/del.sh"