# 部署应用

就是通过 `kubectl apply` 执行一个**资源配置文件**。

```shell
kubectl apply -f xxx.yaml
```

这里通过解析一个开源的微服务示例项目([Sock Shop](https://microservices-demo.github.io/))，解析`k8s`部署微服务项目流程。

+ [github](https://github.com/microservices-demo/microservices-demo.git) (微服务各模块源码在同级目录)
+ [Docs](https://microservices-demo.github.io/docs/index.html) (提供了Docker Compose/Swarm、K8S、Amazon Ecs、Mesos、Nomad 等部署方式)

在K8S集群上部署 Sock Shop，指令很简单

```shell
git clone https://github.com/microservices-demo/microservices-demo.git
cd microservices-demo/deploy/kubernetes/
cd deploy/kubernetes
kubectl create namespace sock-shop
kubectl apply -f complete-demo.yaml
kubectl get svc,pod -n sock-shop
```

下面分析 complete-demo.yaml 及依赖的配置文件。

通过解析资源配置文件将K8S文档中零散的概念连接起来。

**K8S资源配置文件定义的数据和K8S源码中的对象（比如 Namespace Deployment Service 等等）是对应的**。

K8S资源配置文件看成是SpringBoot application.yaml那种文件就可以。

> 注意这个 Sock Shop 项目的  complete-demo.yaml  是一组K8S对象配置的集合，deploy/sock-shop/manifests 中是拆分的对象配置文件。



## [K8S 对象管理](https://kubernetes.io/zh-cn/docs/tasks/manage-kubernetes-objects/)

### [对象的管理技术](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/object-management/)

| 管理技术       | 作用于   | 建议的环境 | 支持的写者 | 学习难度 |
| -------------- | -------- | ---------- | ---------- | -------- |
| 指令式命令     | 活跃对象 | 开发项目   | 1+         | 最低     |
| 指令式对象配置 | 单个文件 | 生产项目   | 1          | 中等     |
| 声明式对象配置 | 文件目录 | 生产项目   | 1+         | 最高     |

+ 指令式命令

  用户可以在集群中的活动对象上进行操作。用户将操作传给 `kubectl` 命令作为参数或标志。

  如：

  ```shell
  kubectl create deployment nginx --image nginx
  ```

+ 指令式对象配置

  ```shell
  kubectl create -f nginx.yaml
  kubectl delete -f nginx.yaml -f redis.yaml
  kubectl replace -f nginx.yaml
  ```

+ 声明式对象配置

  ```shell
  kubectl diff -f configs/
  kubectl apply -f configs/
  kubectl diff -R -f configs/
  kubectl apply -R -f configs/
  ```

### 操作指令

详细参考前面官方文档链接。

```shell
# 递归地创建、更新和删除 Kubernetes 对象
# 注意：这种方法会保留对现有对象已作出的修改，而不会将这些更改写回到对象配置文件中
kubectl apply xxx.yaml
# 查看变更
kubectl diff -f xxx.yaml
# 查询当前配置(即当前起效的配置，会包含一些xxx.yaml没有指明但默认配置的信息)
kubectl get -f xxx.yaml -o yaml

# 删除对象
kubectl delete -f xxx.yaml	# 建议方式
kubectl apply -f xxx.yaml --prune	# k8s自动识别不存在的对象进行删除

# Deployment
# https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/deployment/
# 查看 Deployment 创建状态
kubectl get deployments -n sock-shop
kubectl rollout status deployment/carts
# 查看每个 Pod 生成的标签
kubectl -n sock-shop get pods --show-labels

# 命令式更新名为nginx-deployment的Deployment中nginx容器的镜像
kubectl set image deployment/nginx-deployment nginx=nginx:1.16.1
# 通过编辑的方式更新镜像版本
kubectl edit deployment/nginx-deployment
# 查看 Deployment 创建 ReplicaSet 历史和状态
kubectl get rs -n sock-shop
# 获取 Deployment 的更多信息
kubectl describe deployments -n sock-shop

# 回滚 Deployment 到之前的版本
# 回滚到上一个
kubectl rollout undo deployment/nginx-deployment
# 先查看历史版本，然后回滚到指定版本
kubectl rollout history deployment/nginx-deployment
kubectl rollout undo deployment/nginx-deployment --to-revision=2

# 修改副本个数
kubectl scale deployment/nginx-deployment --replicas=2
# 如果集群启用了Pod的水平自动缩放，可以为 Deployment 设置自动缩放器，并基于现有 Pod 的 CPU 利用率选择要运行的 Pod 个数下限和上限。
kubectl autoscale deployment/nginx-deployment --min=10 --max=15 --cpu-percent=80

# 还支持金丝雀部署

...
```



## K8S 对象的配置

学习应用部署（写配置yaml文件）就是学习 K8S 对象的配置。

| 对象 | 说明 |
| ---- | ---- |
| Deployment | 为 [Pod](https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/) 和 [ReplicaSet](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/replicaset/) 提供声明式的更新能力，可以创建**无状态**应用。 |
| StatefulSet | 用于**有状态**应用程序的声明式更新和管理。 |
| DaemonSet | 用于在集群中运行一个pod的声明式更新和管理。|
| Job | 用于在集群上运行一次性任务的声明式更新和管理。|
| CronJob | 用于在集群上运行定期作业的声明式更新和管理。|
| Service | 用于定义一组pod的逻辑集合，以及访问这些pod的方式。|
| Pod | 一个Kubernetes中最基本的资源类型，它用于定义一个或多个容器的共同运行环境。|
| ReplicaSet | 用于确保在集群中运行指定数量的pod的声明式更新和管理。|
| ConfigMap | 用于存储非敏感数据（如配置文件）的声明式更新和管理。|
| Secret | 用于存储敏感数据（如密码和密钥）的声明式更新和管理。|
| ServiceAccount | 用于定义一个pod的身份验证信息，以及与Kubernetes API Server进行交互的权限。|
| Ingress | 用于定义从外部访问Kubernetes集群中服务的方式。|
| PersistentVolume | 用于定义持久化存储卷，并使它们在Kubernetes集群中可用。|
| StorageClass | 用于定义不同类型的存储，例如云存储、本地存储等，并为这些存储类型指定默认的参数和策略。|
| Namespace | 用于在Kubernetes集群中创建逻辑分区，从而将资源隔离开来，以提高安全性和可维护性。|
| ServiceMonitor | 用于自动发现和监控在Kubernetes集群中运行的服务。|
| HorizontalPodAutoscaler | 用于自动调整Kubernetes集群中的pod副本数量，以根据当前负载需求实现自动扩展或收缩。|
| NetworkPolicy | 用于定义网络访问策略，以控制pod之间的网络流量。|
| CustomResourceDefinition | 用于定义自定义资源，以扩展Kubernetes API和CRD操作。|
| PodDisruptionBudget | 用于定义维护期间可以安全中断的pod的最小数量，以确保Kubernetes集群的高可用性。|
| Role | 用于定义对Kubernetes资源的操作权限，例如读、写、更新、删除等。|
| ClusterRole | 与Role类似，但是可以在整个Kubernetes集群中使用。|

**对比了下官方文档对这些对象的说明，反而感觉还不如源码注释写的清晰**（而且比较方便查询，源码打开搜索即可）。

在不同的对象中相同的key可能表示不一样的意思，需要看其实际使用方式。

+ **Namespace**

  ```go
  // k8s.io/api/core/v1/types.go
  type Namespace struct {
      //内部继承 kind apiVersion 字段
  	metav1.TypeMeta `json:",inline"`
      //metadata
  	metav1.ObjectMeta `json:"metadata,omitempty" protobuf:"bytes,1,opt,name=metadata"`
  	Spec NamespaceSpec `json:"spec,omitempty" protobuf:"bytes,2,opt,name=spec"`
  	Status NamespaceStatus `json:"status,omitempty" protobuf:"bytes,3,opt,name=status"`
  }
  ```

  常用字段：

  + apiVersion

    API版本信息，猜测是对应K8S源码对象类的包路径，比如 `k8s.io/api/core/v1`，golang项目中常用类似v1/v2等目录兼容不同版本。

    每个对象都会包含这个字段。

  + kind

    对象类型，比如 Namespace Deployment Pod StatefulSet Job 等等，`kind: Namespace`对应K8S源码中的`Namespace`对象。

    每个对象都会包含这个字段。

  + metadata

    每个对象都会包含这个字段（ObjectMeta）。

    官方注释：

    ```go
    // ObjectMeta is metadata that all persisted resources must have, which includes all objects
    // users must create.
    type ObjectMeta struct {
        Name string `json:"name,omitempty" protobuf:"bytes,1,opt,name=name"`
        Labels map[string]string `json:"labels,omitempty" protobuf:"bytes,11,rep,name=labels"`
        Annotations map[string]string `json:"annotations,omitempty" protobuf:"bytes,12,rep,name=annotations"`
        //还有很多其他属性...
    }
    ```
    
    + name

+ **[Deployment](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/deployment/)**

  Deployment 为 [Pod](https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/) 和 [ReplicaSet](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/replicaset/) 提供声明式的更新能力。
  
  ```go
  type Deployment struct {
  	metav1.TypeMeta `json:",inline"`
  	metav1.ObjectMeta `json:"metadata,omitempty" protobuf:"bytes,1,opt,name=metadata"`
  	Spec DeploymentSpec `json:"spec,omitempty" protobuf:"bytes,2,opt,name=spec"`
  	Status DeploymentStatus `json:"status,omitempty" protobuf:"bytes,3,opt,name=status"`
  }
  ```
  
  常用字段：
  
  + apiVersion
  
  + kind
  
  + metadata
  
    + name
  
      当前 Deployment 名称，作为后续创建 ReplicaSet 和 Pod 的命名基础。 参阅编写 Deployment 规约获取更多详细信息。
  
    + labels
  
    + namespace
  
  + spec
  
    DeploymentSpec
  
+ **[Service](https://kubernetes.io/zh-cn/docs/concepts/services-networking/service/)**

  

## 资源配置文件案例

### Sock Shop complete-demo.yaml

文件每一行详细说明都写到 k8s/deploy/sock-shop 中了。

下面可以看到前端服务（service/front-end）暴露到了30001端口，可以从任意节点30001端口访问，如：http://192.168.122.10:30001。

这里的前端服务还有那么点网关的意思，接收请求，然后转发给后台服务。

```shell
$ kubectl -n sock-shop get svc,pod -o wide
NAME                   TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE   SELECTOR
service/carts          ClusterIP   10.108.110.166   <none>        80/TCP              22h   name=carts
service/carts-db       ClusterIP   10.99.86.111     <none>        27017/TCP           22h   name=carts-db
service/catalogue      ClusterIP   10.108.137.216   <none>        80/TCP              22h   name=catalogue
service/catalogue-db   ClusterIP   10.100.172.80    <none>        3306/TCP            22h   name=catalogue-db
service/front-end      NodePort    10.106.235.172   <none>        80:30001/TCP        22h   name=front-end
service/orders         ClusterIP   10.109.217.179   <none>        80/TCP              22h   name=orders
service/orders-db      ClusterIP   10.97.175.53     <none>        27017/TCP           22h   name=orders-db
service/payment        ClusterIP   10.100.44.202    <none>        80/TCP              22h   name=payment
service/queue-master   ClusterIP   10.97.143.96     <none>        80/TCP              22h   name=queue-master
service/rabbitmq       ClusterIP   10.110.156.251   <none>        5672/TCP,9090/TCP   22h   name=rabbitmq
service/session-db     ClusterIP   10.109.213.138   <none>        6379/TCP            22h   name=session-db
service/shipping       ClusterIP   10.111.72.222    <none>        80/TCP              22h   name=shipping
service/user           ClusterIP   10.100.229.40    <none>        80/TCP              22h   name=user
service/user-db        ClusterIP   10.96.22.185     <none>        27017/TCP           22h   name=user-db

NAME                               READY   STATUS    RESTARTS   AGE     IP            NODE               NOMINATED NODE   READINESS GATES
pod/carts-666b98fdc4-pn6xm         1/1     Running   0          22h     10.244.1.4    vm1.kwseeker.com   <none>           <none>
pod/carts-666b98fdc4-q8vjk         1/1     Running   0          4h42m   10.244.1.14   vm1.kwseeker.com   <none>           <none>
pod/carts-db-644ff6b576-8z9m2      1/1     Running   0          22h     10.244.2.6    vm2.kwseeker.com   <none>           <none>
pod/catalogue-d45f998bf-5ttpt      1/1     Running   0          22h     10.244.2.7    vm2.kwseeker.com   <none>           <none>
pod/catalogue-db-d764d45d6-vgl7l   1/1     Running   0          22h     10.244.1.5    vm1.kwseeker.com   <none>           <none>
pod/front-end-7899799bbd-t6gf9     1/1     Running   0          22h     10.244.2.8    vm2.kwseeker.com   <none>           <none>
pod/orders-779f959dc4-ld5gs        1/1     Running   0          22h     10.244.1.6    vm1.kwseeker.com   <none>           <none>
pod/orders-db-5bddcf9bdb-6ph89     1/1     Running   0          22h     10.244.2.9    vm2.kwseeker.com   <none>           <none>
pod/payment-67f94cc7b8-vgsth       1/1     Running   0          22h     10.244.1.7    vm1.kwseeker.com   <none>           <none>
pod/queue-master-cc96b5649-ktq54   1/1     Running   0          22h     10.244.2.10   vm2.kwseeker.com   <none>           <none>
pod/rabbitmq-5c6f77d9dd-zc8nc      2/2     Running   0          22h     10.244.1.8    vm1.kwseeker.com   <none>           <none>
pod/session-db-76d658cbf8-hdh5b    1/1     Running   0          22h     10.244.1.9    vm1.kwseeker.com   <none>           <none>
pod/shipping-7b856bf556-r2ngr      1/1     Running   0          22h     10.244.2.11   vm2.kwseeker.com   <none>           <none>
pod/user-745766f4f8-h9q6d          1/1     Running   0          22h     10.244.1.10   vm1.kwseeker.com   <none>           <none>
pod/user-db-5bfb568f5b-jt9vv       1/1     Running   0          22h     10.244.1.11   vm1.kwseeker.com   <none>           <none>
```

