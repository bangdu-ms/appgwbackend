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

```sh
wget https://raw.githubusercontent.com/bangdu-ms/appgwbackend/master/setup/setup.sh
sudo chmod u+x setup.sh
sudo ./setup.sh
```