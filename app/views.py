import time
from django.shortcuts import render, resolve_url

# Create your views here.
from django.http import HttpResponse, response


def index(request):
    #init vars
    data = {}
    general = {}
    server = {}
    response_header = {}

    #populate http request general info data
    general['scheme'] = request.scheme
    general['body'] = request.body
    general['path'] = request.path
    general['path_info'] = request.path_info
    general['method'] = request.method
    general['encoding'] = request.encoding
    data['general'] = general

    #populate http request header data
    data['request_header'] = request.headers

    #populate http request header data
    server['server_name'] = request.META.get('SERVER_NAME')
    server['server_port'] = request.META.get('SERVER_PORT')
    server['server_protocol'] = request.META.get('SERVER_PROTOCOL')
    data['server'] = server

    #customize sleep time
    sleep_time = 0 if request.GET.get('sleep') is None else int(request.GET.get('sleep'))
    time.sleep(sleep_time)
    data['sleep_time'] = sleep_time

    #customize http status code
    status_code = request.GET.get('status')
    if not status_code or int(status_code) < 100 or int(status_code) >599:
        status_code = 200
    data['status_code'] = status_code 

    #customize http request header
    for key,value in request.GET.dict().items():
        if key != 'status' and key != 'sleep':
            response_header[key] = value
    data['response_header'] = response_header

    #render html template
    response = render(request, 'index.html', data, status=status_code)
    for key,value in response_header.items():
        response[key] = value

    return response