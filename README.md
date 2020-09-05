# Android自动设置网络代理
> 设置代理抓包从未如此简单....

## 正常流程

1. 进入设置
2. 进入 WLAN
3. 找对应 wifi 连接
4. 进入详情
5. 找到代理
6. 选择手动
7. 输入主机名
8. 输入端口号
9. 最后保存

每次都是重复操作，累加的时间成本很高，
一不小心，还会写错 ...

## 自动设置
只需一行代码，自动获取电脑IP地址并设置手机网络代理。
支持WiFi和网线环境下自动设置代理。

#### 设置默认代理
``` shell
$ easyproxy set
```
#### 设置自定义代理
```shell
$ easyproxy set ****:8888
```
#### 清除代理
```bash
$ easyproxy clean
```
## 安装
[https://github.com/songhanghang/auto_set_proxy](https://github.com/songhanghang/auto_set_proxy)

下载

``` shell
$ git clone git@github.com:songhanghang/auto_set_proxy.git
```
解压后执行
``` shell
$ ./install.sh
```
如果使用zsh执行fail, 辛苦执行下source，然后重启终端
``` shell
$ source ~/.zshrc
```

## 

### FAQ
* Q: 执行命令时 Not find Command

  A: 解决办法 
  bash下 
  
  ``` shell
   $ source ~/.bashrc
  ``` 
  zsh下 

  ``` shell
  $ source ~/.zshrc
  ```
  重启终端
* Q: 设置代理后WiFi高级选项中看不到代理信息? 没办法取消代理?

  A: 手机上看不到且无法取消，必须通过命令取消！！！ 鱼与熊掌自选...
  
* 只验证了mac, ubuntu请自测， window请自重！
