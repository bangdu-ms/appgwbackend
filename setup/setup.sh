#!/bin/bash
echo "Staring appgwbackend django setup..."
echo "--------------------------------------"
echo "Installing necessary components..."
/bin/yum install -y httpd httpd-devel python36 python36-devel gcc git dnf
/bin/dnf install redhat-rpm-config
echo "Done"
echo "--------------------------------------"

echo "Install sqlite"
cd /tmp/
/bin/wget https://www.sqlite.org/2018/sqlite-autoconf-3240000.tar.gz
/bin/tar zxvf sqlite-autoconf-3240000.tar.gz
cd /tmp/sqlite-autoconf-3240000/
./configure --prefix=/usr/local
make && make install 
/bin/cp -f /etc/sysconfig/httpd /etc/sysconfig/httpd.bak
echo "LD_LIBRARY_PATH=/usr/local/lib" >> /etc/sysconfig/httpd
echo "Done"
echo "--------------------------------------"

echo "Install virtualenv"
/bin/pip3 install mod_wsgi virtualenv
/bin/easy_install-3.6 virtualenv
echo "Done"
echo "--------------------------------------"

echo "Git clone"
cd /var/www/
/bin/git clone https://github.com/bangdu-ms/appgwbackend.git
cd /var/www/appgwbackend
/usr/local/bin/virtualenv venv
source venv/bin/activate
/bin/pip3 install -r requirements.txt
echo "Done"
echo "--------------------------------------"

echo "start apache"
mv /var/www/appgwbackend/setup/django.conf /etc/httpd/conf.d/
service httpd restart
echo "Finished"
echo "--------------------------------------"