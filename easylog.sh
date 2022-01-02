#!/bin/bash

echo "\033[34m
-----------------------------------------------------------------------

  Usege: easylog -p \$searchPath -c \$num  \$zipPath \$searchKey

  
  zipPath        回捞日志压缩包路径，必传      
  searchKey      检索信息，支持正则，必传
                   And关系: 'A.*B'
                   Or关系:  'A|B'

  -p searchPath  解压后要检索的目录，非必传，默认 app/main
  -c num         grep匹配后输出的上下行数， 非必传，默认 0   

  eg: easylog ./bb69ac760aba7836daad6e32be1d82a7_ANDROID_bc026f0709b2f233_zt_notifier.zip 'AdDebugInfo.*2001080165548804290'

-----------------------------------------------------------------------

\033[0m"

# 默认搜索目录
searchPath=app/main
# 匹配内容的上下行数
aroundLine=0
while getopts ":p:c:" opt
do
   case $opt in
        p) 
        searchPath=$OPTARG
        echo "解压后要检索的目录: $searchPath"
        ;;
        c) 
        aroundLine=$OPTARG
        echo "grep匹配后输出的上下行数: ${aroundLine}"
        ;;
        ?) echo "未知参数"
           exit 1;;
esac
done

# 解压根目录
unzipRootPath=~/Desktop/easylog/
# 删除当前文件
rm -rf $unzipRootPath
# shift进行位移，抹去选项参数
shift $(($OPTIND - 1))
# 回捞日志压缩包
zipFile=$1
# grep -E 模式
searchKey=$2

if [ ! -n "$zipFile" ];then
    echo "\033[31m请输入回捞日志压缩包路径!\033[0m" 
    exit
fi

if [ ! -n "$searchKey" ];then
    echo "\033[31m请输入检索信息!\033[0m"
    exit
fi

echo "1. 开始解压回捞日志zip ..."
unzip -o -q -d $unzipRootPath $zipFile
unzipDirName=`ls $unzipRootPath`
# 解压后的文件夹
unzipPath=$unzipRootPath$unzipDirName
echo "   解压成功, 解压文件绝对路径： $unzipPath"
# 需要分析的目标文件夹
targetPath=$unzipPath/$searchPath
# 匹配结果
result=$targetPath/result.log

echo "2. 开始遍历解压${searchPath}中的.log.zip文件..."
for file in $targetPath/*
do
    if [ ${file##*.} = "zip" ]
    then
        # echo  解压$file
        unzip -q -d $targetPath/ $file
        rm -rf $file
    fi
done
echo "   解压成功, 所有.log.zip已转为.log"

echo "3. 开始在${searchPath}中遍历匹配${searchKey} ..."

count=0
files=`ls $targetPath`
# 创建结果文件
echo "" > $result
for file in $files
do
    content=`grep -$aroundLine -E $searchKey $targetPath/$file`
    if [ -n "$content" ]
    then
        count=$(($count+1))
        echo "   匹配到第${count}个文件: $file"
        echo "第${count}个文件: $targetPath/$file" >> $result
        echo "↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓" >>  $result
        echo >> $result
        echo "$content" >>  $result
        echo >> $result
        echo "↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ " >>  $result
        echo "\n\n\n" >> $result
    fi
done

if [ $count -gt 0 ]
then
    sed -i '.bak' "1s/^/共匹配到${count}个文件\n/g" $result
fi

searchResult=`cat $result`
if [ -n "$searchResult" ]
then
    echo "   \033[32m恭喜老铁! 已找到${count}个相关日志, 快去分析甩锅吧!\033[0m"
    # finder中打开目标文件
    open $targetPath
    echo "   自动打开日志目录: ${targetPath}"
    # 自动打开匹配文件
    
    open $result
    echo "   自动打开匹配结果: $result"
else
    echo "   \033[31m抱歉未检索到任何相关信息!\033[0m"
fi

