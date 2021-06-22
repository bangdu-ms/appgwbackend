# appgwbackend
Simple django based backend app for Azure Application Gateway backend related troubleshooting.

## Main feature
* Display incoming http request details, including headers, body
* Customize http response code(100-599) & header with URL parameters
* Customize response latency(0-10000s)
* Display host VM info

## Usage
Simply send GET request in browser or curl to:

http://`<VM's IP>`:8080/?status=`<http-response-code>`&sleep=`<response-latency>`&`<response-header1-name>`=`<response-header1-value>`&`<response-header2-name>`=`<response-header2-value>`...

For example,
http://10.0.0.4:8080/?status=300&sleep=2&header1=test1&header2=test2

All parameters are optional

## Requirement
CentOS 7+

## How to setup

Install requirements
```sh
yum install -y httpd httpd-devel python36 python36-devel gcc git
dnf install redhat-rpm-config
```

Install virtualenv
```sh
pip3 install mod_wsgi virtualenv
easy_install-3 virtualenv
```

Setup django project
```sh
cd /var/ww/
git clone https://github.com/bangdu-ms/appgwbackend.git
/usr/local/bin/virtualenv venv
pip3 install -r requirements.txt
```

Config and restart apache
```sh
mv httpd.conf/django.conf /etc/httpd/conf.d/
service httpd restart
```

Access from browser