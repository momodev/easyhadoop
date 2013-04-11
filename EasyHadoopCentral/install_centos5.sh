#!/bin/sh
yum install -y php53 php53-cli php53-devel php53-common httpd httpd-devel php53-mbstring php53-mysql php53-pdo php53-process mysql mysql-devel mysql-server wget lrzsz dos2unix pexpect libxml2 libxml2-devel MySQL-python
service mysqld start
mysql -hlocalhost -uroot -e"create database if not exists easyhadoop"
mysql easyhadoop < easyhadoop.sql
mysql easyhadoop < patch-0001.sql
mysql easyhadoop < patch-0002.sql

echo "/*************************************************************/"
echo "Install basic environment complete, starting download from"
echo "EasyHadoop repositry......"
echo "/*************************************************************/"

mkdir -p ./hadoop

cd ./hadoop && rm -rf *

if [ ! -f "hadoop-1.0.4-1.x86_64.rpm" ]; then
	wget http://42.96.141.99/hadoop/hadoop-1.0.4-1.x86_64.rpm
fi
if [ ! -f "jdk-6u39-linux-x64.rpm" ]; then
	wget http://42.96.141.99/jdk/jdk-6u39-linux-amd64.rpm
fi
if [ ! -f "hadoop-gpl-packaging-0.5.4-1.x86_64.rpm" ]; then
	wget http://42.96.141.99/resources/x64/hadoop-gpl-packaging-0.5.4-1.x86_64.rpm
fi
if [ ! -f "lzo-2.06.tar.gz" ]; then
	wget http://42.96.141.99/resources/lzo-2.06.tar.gz
fi
if [ ! -f "lzop-1.03.tar.gz" ]; then
	wget http://42.96.141.99/resources/lzop-1.03.tar.gz
fi
if [ ! -f "lzo-2.06-1.el5.rf.x86_64.rpm" ]; then
	wget http://42.96.141.99/resources/x64/lzo-2.06-1.el5.rf.x86_64.rpm
fi
if [ ! -f "lzo-2.06-1.el6.rfx.x86_64.rpm" ]; then
	wget http://42.96.141.99/resources/x64/lzo-2.06-1.el6.rfx.x86_64.rpm
fi
if [ ! -f "lzo-devel-2.06-1.el5.rf.x86_64.rpm" ]; then
	wget http://42.96.141.99/resources/x64/lzo-devel-2.06-1.el5.rf.x86_64.rpm
fi
if [ ! -f "lzo-devel-2.06-1.el6.rfx.x86_64.rpm" ]; then
	wget http://42.96.141.99/resources/x64/lzo-devel-2.06-1.el6.rfx.x86_64.rpm
fi

cd ..
cp -R * /var/www/html/
cd /var/www/html
chmod 777 /var/www/html/expect.py
python NodeAgent.py -s start
service httpd restart

/usr/sbin/setsebool httpd_can_network_connect=1
echo "/*************************************************************/"
echo "Download Hadoop installation and runtime libaries complete."
echo "Do not forget to start your NodeAgent.py"
echo "And access EasyHadoopCentral from your web browser."
echo "/*************************************************************/"
