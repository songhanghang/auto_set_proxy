#!/bin/bash
targetPath=$HOME/lib/easyproxy
sh_name="easyproxy"
yes | rm -rf $targetPath
mkdir $targetPath
cp ./easy_proxy.sh $targetPath/
bashrc_file=${HOME}/.bashrc
zshrc_file=${HOME}/.zshrc
auto_alias="alias $sh_name='sh $targetPath/easy_proxy.sh'"
touch "$bashrc_file"
if [[ -z $(grep "$auto_alias" "$bashrc_file") ]]; then
    echo "配置 bash easyproxy alias ..."
    echo  >> $bashrc_file
    echo "$auto_alias" >> "$bashrc_file"
    source $bashrc_file
fi

touch $zshrc_file
if [[ -z $(grep "$auto_alias" "$zshrc_file") ]]; then
    echo "配置 zsh easyproxy alias ..."
    echo  >> $zshrc_file
    echo "$auto_alias" >> "$zshrc_file"
    source $zshrc_file
fi

echo "success"
echo "开始愉快玩耍吧！ "
echo "~~~~~~~~~~~~~~~~~~~~~~~~ "
echo "设置代理 \$$sh_name set"
echo "清除代理 \$$sh_name clean"
echo "~~~~~~~~~~~~~~~~~~~~~~~~ "
echo "注意！！！ 开启代理后WiFi高级选项看不到，必须使用命令清除代理 "
