---
title: "network"
date: 2015-07-08 10:04
---
+ netstat 命令用于显示各种网络相关信息，如网络连接，路由表，接口状态 (Interface Statistics)，masquerade 连接，多播成员 (Multicast Memberships) 等等。
+ 列出所有端口 (包括监听和未监听的):``netstat -a``,列出所有 tcp 端口:``netstat -at``,列出所有有监听的服务状态:``netstat -l``,使用netstat工具查询端口:``netstat -antp | grep 6379``
+ 查询7902端口现在运行什么程序:

```bash
#分为两步
#第一步，查询使用该端口的进程的PID；
$lsof -i:7902
COMMAND   PID   USER   FD   TYPE    DEVICE SIZE NODE NAME
WSL     30294 tuapp    4u  IPv4 447684086       TCP 10.6.50.37:tnos-dp (LISTEN)

#查到30294
#使用ps工具查询进程详情：
$ps -fe | grep 30294
tdev5  30294 26160  0 Sep10 ?        01:10:50 tdesl -k 43476
root     22781 22698  0 00:54 pts/20   00:00:00 grep 11554
```

+ 查看路由状态``route -n``，探测前往地址IP的路由路径:``traceroute IP``，DNS查询，寻找域名domain对应的IP:``host domain``，反向DNS查询:``host IP``

+ ``sftp user@host``，登陆后，可以使用下面的命令进一步操作：
  + ``get filename`` # 下载文件
  + ``put filename`` # 上传文件
  + ``ls`` # 列出host上当前路径的所有文件
  + ``cd`` # 在host上更改当前路径
  + ``lls`` # 列出本地主机上当前路径的所有文件
  + ``lcd`` # 在本地主机更改当前路径

+ 将本地localpath指向的文件上传到远程主机的path路径:``scp localpath ID@host:path``，以ssh协议，遍历下载path路径下的整个文件系统，到本地的localpath:``scp -r ID@site:path localpath``
