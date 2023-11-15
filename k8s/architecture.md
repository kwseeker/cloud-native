# K8S 架构

<img src="../img/k8s-arch.png" style="zoom:80%;" />



## 基础组件

官方文档：[Kubernetes 组件](https://kubernetes.io/zh-cn/docs/concepts/overview/components/)

+ **节点**

  + **主节点**（控制面）

    + **APIServer**

      提供可用于服务发现的查询API，返回匹配的 EndpointSlice 对象。

    + **控制管理器**

      + **控制器**

        追踪至少一种类型的 Kubernetes 资源。

        + **Job控制器**
        + **Ingress控制器**

    + **云控制器管理器**

      + **节点控制器**

        Node对象的创建、更新、查询、监控、删除等。

      + **路由控制器**

        监听 Node 对象的创建事件，并据此配置路由设施。

      + **服务控制器**

        配置对应服务的 Endpoints 对象。

  + **从节点**

    + **kubelet**

      + **垃圾收集**
      + **ReplicationController**

    + **容器运行时接口CRI**

      对接kubelet和各种容器运行时，比如 kubelet 通过 CRI 与 Docker等容器对接。

    + **容器运行时**（container runtime）

      + **Pod**

        在 Kubernetes 中创建和管理的、最小的可部署的计算单元。

        一个Pod中可以部署一到多个容器。
    
        + **服务 Service**
          + ClusterIP
          + NodePort
          + LoadBalancer
          + ExternalName

      + **工作负载运行方式**

        + **Deployment**

          管理无状态应用工作负载， 其中 Deployment 中的任何 Pod 都是可互换的，可以在需要时进行替换。

        + **StatefulSet**

          管理一个或多个运行相同应用代码、但具有不同身份标识的 Pod。 StatefulSet 最常见的用途是能够建立其 Pod 与其持久化存储之间的关联。 Pod不可互换只能重建，如果该 StatefulSet 中的一个 Pod 失败了，Kubernetes 将创建一个新的 Pod， 并连接到相同的 PersistentVolume。

        + **DaemonSet**

          定义了在特定节点上提供本地设施的 Pod， 例如允许该节点上的容器访问存储系统的驱动。
    
        + **Job**
        + **CronJob**
    
    + **kube-proxy**

+ **客户端**
  
  + **kubectl**
  + **API接口**



## 完整的K8S服务集群都包含什么

+ 



## 请求在K8S各组件中的流转

以 sock-shop 这个项目分析下请求流转流程。

主要看两种情况：

+ 外部请求到某个Pod
+ 某个Pod到另一个服务的Pod

### 网络基础

+ K8S 会为每个 Pod 提供一个 IP 地址，处于 `--pod-network-cidr=10.244.0.0/16` 中设置的网段，同集群所有Pod间都可以互相ping通，注意K8S容器中默认没有执行ping的权限，需要在做镜像的时候，为普通用户添加ping执行权限

+ ~~每个Pod有独立的网络命名空间，有自己的虚拟网络接口（veth）~~

+ K8S 会为每个 Service 提供一个 IP （ClusterIP） 地址，处于 `--service-cidr=10.96.0.0/12` 中设置的网段

+ Service 为 Pod 提供网络代理，以及实现 Service 下属 Pod 间的负载均衡，域名为` {servicename}.{namespace}.svc.cluster.local`

+ Service 服务发现的两种方式

  + 环境变量

    查看Pod的环境变量可以看到，Pod环境变量中保存了所有Service的Host 和 Port 信息。所有完全可以通过 `{SERVICENAME}_SERVICE_HOST:{SERVICENAME}_SERVICE_PORT` 访问某个Service。

    ```shell
    $ kubectl -n sock-shop exec carts-666b98fdc4-pn6xm -- env | grep SERVICE
    RABBITMQ_SERVICE_PORT_EXPORTER=9090
    CARTS_SERVICE_PORT=80
    CATALOGUE_SERVICE_PORT=80
    CATALOGUE_DB_SERVICE_HOST=10.100.172.80
    FRONT_END_SERVICE_PORT=80
    ORDERS_DB_SERVICE_PORT=27017
    ...
    ```

  + DNS

    K8S 的 kube-system 命名空间下有一个自带的 DNS 服务组件`kube-dns`，集群中的所有 Pod 都使用它作为 DNS。在每个容器的`/etc/resolv.conf`中有配置，所有pod中的进程dns查询都会被这个dns服务器响应，这个服务器知道集群中运行的所有服务。

    ```shell
    $ kubectl -n sock-shop exec carts-666b98fdc4-pn6xm -it -- sh
    $ cat /etc/resolv.conf
    search sock-shop.svc.cluster.local svc.cluster.local cluster.local kwseeker.com
    nameserver 10.96.0.10
    options ndots:5
    # 10.96.0.10 就是 kube-system/kube-dns Service 的 IP 地址
    $ kubectl get svc -A -o wide
    NAMESPACE              NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE     SELECTOR
    default                kubernetes                  ClusterIP   10.96.0.1        <none>        443/TCP                  3d1h    <none>
    kube-system            kube-dns                    ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   3d1h    k8s-app=kube-dns
    ```

    > `/etc/resolv.conf` 是Linux系统中的一个配置文件，用于指定用于DNS（Domain Name System）解析的DNS服务器和其他相关设置。DNS是用于将域名转换为IP地址的系统，它在互联网上用于定位网站和其他网络资源。
    >
    > `/etc/resolv.conf` 文件通常包含以下信息：
    >
    > 1. **nameserver**：这是DNS服务器的IP地址，指定计算机应该用于解析域名的DNS服务器。通常会列出多个DNS服务器，以备备用。
    > 2. **search**：这是一个搜索域（Search Domain）的域名列表。如果用户在浏览器或终端中输入的域名不包含点（.），系统将尝试添加这些搜索域，以便更容易地找到主机。例如，如果`search example.com`包含在`/etc/resolv.conf`中，那么当用户输入`myserver`时，系统将首先尝试解析`myserver.example.com`。
    > 3. **domain**：与`search`类似，`domain`指定了默认的搜索域，以便在没有指定完全限定域名的情况下解析域名。
    > 4. **options**：这一部分可以包括其他DNS配置选项，如超时时间、重试次数等。

+ Endpoint 对象：Service 和 Pod 网络连接的桥梁，Endpoint 中记录 Service 下 Pod 的网络IP和端口

  ```shell
  $ kubectl get endpoints -n sock-shop carts
  NAME    ENDPOINTS                      AGE
  carts   10.244.1.14:80,10.244.1.4:80   20h
  ```

  通过自定义 Endpoint 可以将 Service 连接到外部服务，即外部服务提供此 Service 的职能而不是通过本集群的Pod。

  还可以通过`ExternalName + 域名`的方式定义 Service，来定义一个外部服务 Service。

+ Service 暴露的四种方式

  详细参考《Kubernetes实战》C5。关于模式的选择：[Kubernetes NodePort vs LoadBalancer vs Ingress? When should I use what?](https://medium.com/google-cloud/kubernetes-nodeport-vs-loadbalancer-vs-ingress-when-should-i-use-what-922f010849e0)

  + Proxy

    依靠 kube-proxy Pod，常用于测试。

  + NodePort

    类似 Docker 容器端口映射，将端口映射到节点服务器的端口，集群外部可以通过`节点IP:nodePort`访问，比如使用 NodePort 暴露 kubernetes-dashboard 服务，最终端口信息 `443:32443/TCP`，节点IP是`192.168.122.12`，那么就可以通过`192.168.122.12：32443` 访问 Dashboard。

    ```yaml
    kind: Service
    apiVersion: v1
    metadata:
      labels:
        k8s-app: kubernetes-dashboard
      name: kubernetes-dashboard
      namespace: kubernetes-dashboard
    spec:
      type:
        NodePort
      ports:
        - port: 443			# 监听端口
          targetPort: 8443	# Service访问Pod的端口
          nodePort: 32443	# port映射到Node上的端口（可用范围：30000–32767） 32443->443->8443
      selector:
        k8s-app: kubernetes-dashboard
    ```

    ```shell
    $ kubectl get svc -A -o wide
    NAMESPACE              NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE     SELECTOR
    kubernetes-dashboard   kubernetes-dashboard        NodePort    10.101.18.113    <none>  	443:32443/TCP            2d19h   k8s-app=kubernetes-dashboard
    ```

  + LoadBalancer

    需要配置一个可公开访问的IP地址，负载均衡器将连接重定向到服务 Service。

  + Ingress

    只需要一个公网IP，Ingress工作在应用层，可以提供基于cookie的会话亲和性功能。

    ```yaml
    # 简单配置
    spec:
      rules:
      - host: demo.kwseeker.com
        http:
          path: /
          backend: 
            serviceName: front-end
            servicePort: 80
    ```

### 请求流转流程

#### 外部请求到某个Pod

域名 -> 公网IP+端口 -> NodePort / LoadBalance /  Ingress -> Service -> Endpoint -> Pod

#### 某个Pod到另一个服务的Pod

Pod -> Service -> Endpoint -> Pod

### 网络优化

#### 减少不必要的网络跳数

+ externalTrafficPolicy: Local

  Pod需要访问另一个Pod时，设置总是访问同节点上的Pod

