---
压力测试：
-web
并发量
响应速度
容错能力

吞吐率
服务器并发处理能力的量化描述，单位reqs/s
单位时间能处理的最大请求数，称之为最大吞吐率  计算公式：总请求数/处理完这些请求所花费的时间
并发连接数 同一时刻，服务器接受的请求个数
用户平均请求等待时间 计算公式：处理完成所有请求数所花费的时间/（总请求数/并发用户数）
服务器平均请求等待时间 计算公式：处理完成所有请求数所花费的时间/总请求数

-工具
http_load 
JMeter
ab
LoadRunner
Web bentch

--- ab
-n 请求总数
-c 并发请求个数
-t 测试所进行的最大秒数
-v 显示详细信息
-k keepalive功能，一个http会话中执行多个请求
-p post-file 包含了post数据的文件
-i 执行HEAD请求，只获取头信息
-h 显示帮助信息

ulimit -n #每个进程能打开的最大文件数
root@clash:/etc/netplan# cat /proc/sys/net/ipv4/tcp_syncookies 

