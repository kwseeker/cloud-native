# Docker-Engine

## 安装

[Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

安装后添加当前用户到docker组（否则不使用sudo会报sock链接无权限的错误）：

```shell
sudo usermod -a -G docker $USER
# 查看当前用户所属组
groups
```

容器镜像加速器，这配置的Aliyun的[加速器](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors)

```shell
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://<yourcode>.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```



