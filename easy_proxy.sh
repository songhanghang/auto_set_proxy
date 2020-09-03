#!/bin/bash

echo "\n---------------- Support ------------------"
echo "设置默认代理    ./easy_proxy.sh set"
echo "设置自定义代理  ./easy_proxy.sh set ****:8888"
echo "删除代理       ./easy_proxy.sh clean"
echo "--------------------------------------------\n"

# WIFI IP
ip=$(ifconfig en0 | grep -E 'inet \d{3}.' | awk '{print $2}')
# 网线 IP
if [ -z $ip ];then
    ip=$(ifconfig en7 | grep -E 'inet \d{3}.' | awk '{print $2}')
fi
default_proxy=${ip}":8888"

echo "本机IP为: $default_proxy\n"
if [ "$1" == "set" ];then
    if [ -n "$2" ];then
        echo "设置自定义代理 $2"
        adb shell settings put global http_proxy $2
    else
        echo "设置本机IP代理 $default_proxy"
        adb shell settings put global http_proxy $default_proxy
    fi
elif [ "$1" == "clean" ];then
    echo "清除代理成功"
    adb shell settings put global http_proxy :0
else
    echo "!!! 请输入合法的操作符 !!!"
fi
