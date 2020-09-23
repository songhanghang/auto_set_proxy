#!/bin/bash

echo "\n---------------- Support ------------------"
echo "设置默认代理    easyproxy set"
echo "设置自定义代理   easyproxy set ****:8888"
echo "删除代理        easyproxy clean"
echo "--------------------------------------------\n"

# 获取 IP
ip=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
echo $ip
count=$(echo $ip | tr ' ' '\n' | wc -l )
if [ $count -gt 1 ];then
    echo "多个ip,请手动选择一个"
    exit
fi
default_proxy=${ip}":8888"

echo "本机IP为: $default_proxy"
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

