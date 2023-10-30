# K8S 架构

<img src="../img/k8s-arch.png" style="zoom:80%;" />

## 组件

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



## 操作

+ 节点管理
  + 节点注册
  + 状态查询
  + 节点心跳
  + 节点逐出
  + 领导者节点选举
+ 节点通信
  + API服务器
+ 身份认证与鉴权
+ 联网
  + 网络策略
  + DNS
  + 拓扑感知路由
+ 存储
+ 配置
+ 安全
+ 调度、抢占和驱逐
