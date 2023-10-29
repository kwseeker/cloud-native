# KVM 安装

测试系统 LinuxMint21.1 vera。



## 安装KVM

参考LinuxMint官方论坛：[KVM Kernel-based Virtual Machine](https://community.linuxmint.com/tutorial/view/1727)

```shell
# 1 检查当前Linux内核是否支持KVM虚拟化
cat /proc/cpuinfo | grep -E '(vmx|svm)'
# 	大于 0 表示支持虚拟化
cat /proc/cpuinfo | grep -Ec '(vmx|svm)'
# 	或者执行
kvm-ok

# 2 安装KVM软件包
sudo apt update
# 	qemu-kvm          主要的KVM程序包
# 	python-virtinst   创建虚拟机所需要的命令行工具和程序库
# 	virt-manager      GUI虚拟机管理工具
#	virt-top          虚拟机统计命令
#	virt-viewer       GUI连接程序，连接到已配置好的虚拟机
#	libvirt           C语言工具包，提供libvirt服务
#	libvirt-client    虚拟客户机提供的C语言工具包
#	virt-install      基于libvirt服务的虚拟机创建命令
# 	bridge-utils      创建和管理桥接设备的工具
sudo apt install -y \
  virt-manager \
  virt-viewer \
  qemu-kvm \
  libvirt-daemon-system \
  libvirt-clients \
  bridge-utils
  
# 3 将当前用户名加入KVM权限组
sudo usermod -aG libvirt arvin
id

# 4 查看KVM工具
# 	libvirt: 操作和管理KVM虚机的虚拟化 API，使用 C 语言编写，可以由 Python,Ruby, Perl, PHP, Java 等语言调用。可以操作包括 KVM，vmware，XEN，Hyper-v, LXC 等 Hypervisor。
# 	virsh：用于管理虚拟化环境中的客户机和Hypervisor的命令行工具,基于libvirt
# 	virt-manager: 基于 libvirt 的 GUI 工具
virsh -v

# 5 常用命令
virsh list --all
virsh start centos7.0
virsh shutdown centos7.0
# 	获取虚拟机网络接口IP地址
virsh domifaddr centos7.0
# 	虚拟机克隆，很有用，需要创建虚拟机集群的话可以创建并配置好一个虚拟机，然后其他虚拟机从这台虚拟机克隆出来
virt-clone --original centos7.0 --name demo --auto-clone
```



## 安装 CentOS7 虚拟机

先载CentOS镜像 https://www.centos.org/download/， 然后可以通过 virt-manger 界面安装虚拟机。

```shell
# 查看正在运行的虚拟机列表，默认就是连接 qemu:///system，下面等同于 virsh list
# 'Failed to connect socket to '/var/run/libvirt/libvirt-sock': Permission denied 报错就重新启动
virsh -c qemu:///system list
```

KVM 虚拟机磁盘文件默认存储路径：`/var/lib/libvirt/images`。



## 环境配置

### 操作用户加入wheel 组

> wheel 源于 “big wheel” 俚语，指强大有影响力的人。wheel 组对应 ubuntu 等其他发行版的 sudo。

```shell
cat /etc/group
usermod -aG wheel arvin
```

### 桥接网络

新安装的 CentOS 7 系统，默认没有启动网络连接。

KVM安装好后会默认创建一个名为 virbr0 的虚拟交换机，用于连接虚拟机和宿主机之间的网络通信。
且 virbr0 默认已连接了物理网络接口，每次创建虚拟机都会创建虚拟网络接口用于与虚拟机建立连接。

这里eth0先NAT到virbr0,再桥接到虚拟机？？？

> 使用桥接网络虚拟机通过宿主机的物理网络接口可直接与外部网络通信。虚拟机中的网络流量通过**虚拟交换机**和物理交换机进行转发，最终连接到外部网络。
>
> 桥接网络原理(一图胜千言)：
>
> <img src="../../img/libvirt-kvm-bridge-network.png" style="zoom:80%;" />
>
> NAT模式则相当于将宿主机当作路由器又建了一层子网。

```shell
# 1 启动网络连接
ip addr
sudo ifdown eth0
sudo ifup eth0
# 设置启动后自动连接
nmcli connection modify eth0 connection.autoconnect yes ipv4.method auto
nmcli connection show eth0

# 2 创建桥接网络
# 	先查看宿主机虚拟交换机
#	virbr0是默认创建的NAT交换机，vnet1/3/5是连接到虚拟交换机的虚拟网络接口，因为创建了3个虚拟机所以这里创建了3个虚拟网络接口
brctl show
#bridge name	bridge id		STP enabled	interfaces	
#virbr0			8000.52***e		yes			vnet1
#											vnet3
#											vnet5
virsh net-list --all
virsh net-dumpxml default
# <network connections='3'>
#   <name>default</name>
#   <uuid>02dbbe86-31fb-4627-ab9b-b11d5326dc4a</uuid>
#   <forward mode='nat'>
#     <nat>
#       <port start='1024' end='65535'/>
#     </nat>
#   </forward>
#   <bridge name='virbr0' stp='on' delay='0'/>
#   <mac address='52:***:4e'/>
#   <ip address='192.168.122.1' netmask='255.255.255.0'>
#     <dhcp>
#       <range start='192.168.122.2' end='192.168.122.254'/>
#     </dhcp>
#   </ip>
# </network>

# 3 修改虚拟机eth0配置
sudo vi /etc/sysconfig/network-scripts/ifcfg-eth0
# TYPE=Ethernet
# PROXY_METHOD=none
# BROWSER_ONLY=no
# BOOTPROTO=static
# DEFROUTE=yes
# IPV4_FAILURE_FATAL=no
# IPV6INIT=no
# IPV6_AUTOCONF=yes
# IPV6_DEFROUTE=yes
# IPV6_FAILURE_FATAL=no
# IPV6_ADDR_GEN_MODE=stable-privacy
# NAME=eth0
# UUID=c521b5e7-d16f-4818-b22b-6dda067b40df
# DEVICE=eth0
# ONBOOT=yes
# IPADDR=192.168.122.10
# GATEWAY=192.168.122.1
# NETMASK=255.255.255.0
# DNS1=192.168.122.1
```



### SSH连接

终端操作一堆虚拟机还是在宿主机统一操作比较舒服，通过建立SSH连接实现。

```shell
vi ~/.ssh/config
# host vm0
#     user arvin
#     hostname 192.168.122.10
#     port 22
#     identityfile ~/.ssh/id_rsa
# host vm1
#     user arvin
#     hostname 192.168.122.11
#     port 22
#     identityfile ~/.ssh/id_rsa
# host vm2
#     user arvin
#     hostname 192.168.122.12
#     port 22
#     identityfile ~/.ssh/id_rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub vm0
ssh-copy-id -i ~/.ssh/id_rsa.pub vm1
ssh-copy-id -i ~/.ssh/id_rsa.pub vm2
# 测试
ssh vm0
ssh vm1
ssh vm2
```

虚拟机可以同样配置。

