#!/bin/bash
yes | rm -rf $HOME/lib/easyproxy
mkdir $HOME/lib/autoshell
cp easy_proxy.sh $HOME/lib/easyproxy/
bashrc_file="${HOME}/.bashrc"
zshrc_file="${HOME}/.zshrc"
auto_alias="alias easyproxy='sh $HOME/lib/autoshell/easy_proxy.sh'"
echo "开始配置 bash auto_alias ..."
touch "$bashrc_file"
if [[ -z $(grep "$auto_alias" "$bashrc_file") ]]; then
    echo  >> $bashrc_file
    echo "$auto_alias" >> "$bashrc_file"
    source $bashrc_file
fi

echo "开始配置 zsh auto_alias ..."
touch $zshrc_file
if [[ -z $(grep "$auto_alias" "$zshrc_file") ]]; then
    echo  >> $zshrc_file
    echo "$auto_alias" >> "$zshrc_file"
    source $zshrc_file
fi

echo "安装完成..."
echo "开始愉快玩耍吧！ "
echo "设置代理 '$auto_alias set'"
echo "清除代理 '$auto_alias clean' "
echo "注意！！！ 开启代理后WiFi高级选项看不到，必须使用命令清除代理 "
