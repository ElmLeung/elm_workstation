---
四七层负载均衡原理
四层：IP + Port
LVS
七层：URL,Session
KTCPVS,Haproxy,Nginx,MySQL Proxy

四层比七层可以承载更大的并发量，七层可以控制的更精细

---
OSI 七层网络模型：
应用层-Application --> 表示层-Presentation --> 会话层-Session --> 传输层-Transport --> 网络层-Network --> 数据链路层-DataLink --> 物理层-Physical
应用层-APDU：网络服务与最终用户的一个接口
表示层-PPDU：数据的表示、安全、压缩
会话层-SPDU：建立、管理、终止会话
传输层-TPDU：定义传输数据的协议端口号，以及流控和差错校验
网络层-报文：进行逻辑地址寻址，实现不同网络之间的路径选择
数据链路层-帧：建立逻辑连接、进行硬件地址寻址、差错校验
物理层-比特：建立、维护、断开物理连接
---
TCP/IP协议：
应用层：
传输层：
网络层：
链路层：
---
netfilter/iptables
四表：raw,mangle,nat,filter
五链：prerouting,forward,input,output,postrouting

iptables -t filter -A INPUT -s 192.168.122.1 -p tcp --dport 22 -j DROP
iptable -L -n
---
ipvs:工作在内核空间，实现集权服务的调度；借鉴了iptables实现
ipvsadm:工作在用户空间，负责编写规则

术语：
DS Director Server 目标服务器，即负载均衡器
RS Real Server 真实服务器，即后端服务器
VIP 虚拟IP，直接面向客户端的IP，可以是公网IP
DIP Director Server IP 主要用于和内部主机通信的IP地址
RIP Real Server IP 后端真实服务器的IP地址
CIP Client IP，客户端IP

LVS 类型
NAT 修改目标IP为RIP
DR  修改目标MAC为后端的MAC
tunnel 较少使用，常用于异地容灾

---NAT模式
apt install -y ipvsadm #安装命令行工具
ipvsadm -A -t 192.168.122.146:80 -s wrr #负载均衡器，DIP
ipvsadm -a -t 192.168.122.146:80 -r 192.168.122.237:80 -m #RIP, -m nat模式
echo 1 > /proc/sys/net/ipv4/ip_forward
vim /etc/sysctl.conf --> net.ipv4.ip_forward=1
root@bastion:/proc/sys/net/ipv4# sysctl -p
net.ipv4.ip_forward = 1

---DR模式
arp 内核参数
arp_ignore
0 响应任意网卡上接收到的对本机IP地址的arp请求
1 只响应目的IP地址为接收网卡所配置IP地址的arp请求
2 只响应目的IP地址为接收网卡所配置IP地址的arp请求，并且arp请求的源IP必须和接收网卡同网段
arp_announce
0 允许使用任意网卡上的IP地址作为arp请求的源IP
1 尽量避免使用不属于该发送网卡子网的本地地址作为发送arp请求的源IP地址
2 忽略IP数据包的源IP地址，选择该发送网卡上最合适的本地地址作为arp请求的源IP地址

DS上配置VIP，并添加路由
RS上配置ARP请求级别，并在环回地址接口lo上配置VIP，并添加路由


添加ip和路由
vim /etc/netplan/*
netplan apply
```
network:
    ethernets:
        enp1s0:
          dhcp4: false
          addresses:
            - 192.168.122.237/24
            - 192.168.122.200/24
          routes:
            - to: default
              via: 192.168.122.1
          nameservers:
            addresses: [8.8.8.8, 114.114.114.114]
          match:
            macaddress: 52:54:00:20:22:b6
    version: 2
```
/proc/sys/net/ipv4/conf/enp1s0/arp_ignore #临时修改
vim /etc/sysctl.conf
```
net.ipv4.conf.enp1s0.arp_ignore = 1
net.ipv4.conf.enp1s0.arp_announce = 2

```
