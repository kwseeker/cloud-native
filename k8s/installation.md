# K8S 安装



## [安装 kubernetes](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

```shell
# 1 修改KVM虚拟机hostname
sudo hostnamectl set-hostname vm0.kwseeker.com
sudo hostnamectl status
sudo echo "127.0.0.1   $(hostname)" >> /etc/hosts
# 	关闭交换分区
sudo swapoff -a
sudo sed -ri 's/.*swap.*/#&/' /etc/fstab
# 	SELINUX=enforcing 改为 SELINUX=permissive
sudo setenforce 0
sudo sed -i 's/enforcing/permissive/' /etc/selinux/config
# 	关闭防火墙
sudo systemctl stop firewalld
sudo systemctl disable firewalld
# 	使用ntpdate同步系统时间
sudo yum install ntpdate
sudo ntpdate time.windows.com 
# 	配置 Kubernetes 的系统参数，保障节点上的 iptables 能够正确地查看桥接流量
sudo cat > /etc/sysctl.d/kubernetes.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sysctl -p
# 	确保每个节点上 MAC 地址和 product_uuid 的唯一性
ip link
cat /sys/class/dmi/id/product_uuid

# 2 安装Docker
yum remove \
  docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-engine
yum install -y yum-utils
#yum-config-manager \
#  --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager \
  --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# 	默认安装最新版本
yum install \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose-plugin
#yum list docker-ce --showduplicates | sort -r
#yum install \
#  docker-ce-20.10.21 \
#  docker-ce-cli-20.10.21 \
#  containerd.io \
#  docker-compose-plugin
docker version
#Client: Docker Engine - Community
# Version:           24.0.7
# API version:       1.43
# Go version:        go1.20.10
# Git commit:        afdd53b
# Built:             Thu Oct 26 09:11:35 2023
# OS/Arch:           linux/amd64
# Context:           default
#	启动docker守护进程
systemctl enable docker
systemctl enable containerd
systemctl start docker
#
vi /etc/docker/daemon.json
# 改为自己的加速器地址
# { "registry-mirrors": ["https://mmqg75cz.mirror.aliyuncs.com"] }
usermod -aG docker $USER
docker run hello-world
docker info --format {{.Containers}}
# 修改 docker 使用的 Control Groups(Cgroup) 驱动为 `systemd`，必须与后续 kubelet 内使用的驱动一致
docker info --format '{{.CgroupDriver}}'
vi /usr/lib/systemd/system/docker.service
#ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --exec-opt native.cgroupdriver=systemd
systemctl daemon-reload
systemctl restart docker
docker info --format '{{.CgroupDriver}}'

# 3 安装 kubectl kubeadm kubelet
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
       http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
# yum install \
#  kubelet-1.23.8 \
#  kubeadm-1.23.8 \
#  kubectl-1.23.8 \
#  --disableexcludes=kubernetes
kubelet --version
kubeadm version --output=yaml
#clientVersion:
# buildDate: "2023-09-13T09:34:32Z"
#  compiler: gc
#  gitCommit: 89a4ea3e1e4ddd7f7572286090359983e0387b2f
#  gitTreeState: clean
#  gitVersion: v1.28.2
#  goVersion: go1.20.8
#  major: "1"
#  minor: "28"
#  platform: linux/amd64
kubectl version --output=yaml
systemctl enable --now kubelet
systemctl start kubelet
#	卸载
yum remove -y kubelet kubeadm kubectl
```

上面配置完最好重启下虚拟机，以防止某些配置未生效。



## 创建K8S集群

### 初始化集群（主节点执行）

```shell
# 防止预检失败
mv /etc/containerd/config.toml /etc/containerd/config.toml.bak
# 上一步需要重启containerd生效
systemctl restart containerd
kubeadm config images pull \
  --kubernetes-version=1.28.2 \
  --image-repository registry.aliyuncs.com/google_containers 
kubeadm config images list

# --image-repository: 指定从那个仓库拉取镜像，默认值是k8s.gcr.io，国内建议改为registry.aliyuncs.com/google_containers
# --kubernetes-version: 指定kubenets版本号，默认值是stable-1，不指定版本会导致从https://dl.k8s.io/release/stable-1.txt下载最新的版本
# --service-cidr: service 之间访问使用的网络ip段
# --pod-network-cidr: pod 之间网络访问使用的网络ip,与下文部署的CNI网络组件yml中保持一致
sudo kubeadm init \
  --apiserver-advertise-address=192.168.122.10 \
  --kubernetes-version=1.28.2 \
  --image-repository registry.aliyuncs.com/google_containers  \
  --service-cidr=10.96.0.0/12 \
  --pod-network-cidr=10.244.0.0/16 \
  --v=5
  
# 问题分析和集群重置
$ journalctl -xeu kubelet
$ sudo kubeadm reset -f
$ sudo systemctl daemon-reload
$ sudo systemctl restart kubelet
```

初始化成功后的返回信息：

```txt
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.122.10:6443 --token jnrx7v.cjv82nr4oqz3066d \
	--discovery-token-ca-cert-hash sha256:e2f8acec1b41f81a5d08833d7b8c8017001a3395817cc9378c3abcda2810f508 
```

配置 kubectl 支持非root用户运行

```
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```

### 其他节点加入集群（从节点执行）

```shell
# 可能需要先查看token或重新生成token, 在主节点执行
sudo kubeadm token list
sudo kubeadm token create
# 防止预检失败
sudo mv /etc/containerd/config.toml /etc/containerd/config.toml.bak
sudo systemctl restart containerd
# 使用默认的证书，证书仅支持 IP 等少数几个域名认证，只能用于测试，外网访问需要重新签发新证书
sudo kubeadm join 192.168.122.10:6443 --token jnrx7v.cjv82nr4oqz3066d --discovery-token-ca-cert-hash sha256:e2f8acec1b41f81a5d08833d7b8c8017001a3395817cc9378c3abcda2810f508 
# 查看节点列表
kubectl get nodes
```

###  部署flannel网络插件

```shell
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

