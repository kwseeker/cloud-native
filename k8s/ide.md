# K8S IDE

## Lens

[Lens Documentation](https://docs.k8slens.dev/)

现在开始收费了。

[Lens](https://k8slens.dev/) 是一款开源的 Kubenretes IDE，也可以作为桌面客户端，官方网站 [https://k8slens.dev](https://k8slens.dev/)，具有以下特性：

- 完全开源，GitHub 地址 https://github.com/lensapp/lens
- 实时展示集群状态
- 内置 Prometheus 监控
- 多集群，多个 namespace 管理
- 原生 Kubernetes 支持
- 支持使用 chart 安装应用
- 使用 kubeconfig 登陆认证
- 支持多平台，Windows、Mac、Linux
- Visual Studio Code 友好的风格设计

> 个人感觉不能算做IDE, 理想中的IDE是支持打开k8s配置文件，补全，保存到原文件等等。但是看文档介绍并不支持这些功能，只有编辑运行中的k8s对象的配置并应用。
>
> 主要还是一个监控管理平台。

### 安装

```shell
curl -fsSL https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/lens-archive-keyring.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | sudo tee /etc/apt/sources.list.d/lens.list > /dev/null
sudo apt update
sudo apt install lens
lens-desktop
```

### 添加集群

将 `control-plane` 中的 `~/.kube/config` 拷贝到物理机 `~/.kube/config`， 或者将内容粘贴到 `/File/Add Cluster/` 编辑框中。

