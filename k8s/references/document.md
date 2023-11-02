# 官方文档目录

-  

  [文档](https://kubernetes.io/zh-cn/docs/home/)

  -  [Kubernetes 文档支持的版本](https://kubernetes.io/zh-cn/docs/home/supported-doc-versions/)

-  

  [入门](https://kubernetes.io/zh-cn/docs/setup/)

  -  [学习环境](https://kubernetes.io/zh-cn/docs/setup/learning-environment/)

  -  

    [生产环境](https://kubernetes.io/zh-cn/docs/setup/production-environment/)

    -  [容器运行时](https://kubernetes.io/zh-cn/docs/setup/production-environment/container-runtimes/)

    -  

      [使用部署工具安装 Kubernetes](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/)

      -  

        [使用 kubeadm 引导集群](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/)

        -  [安装 kubeadm](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
        -  [对 kubeadm 进行故障排查](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/)
        -  [使用 kubeadm 创建集群](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)
        -  [使用 kubeadm API 定制组件](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/control-plane-flags/)
        -  [高可用拓扑选项](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/ha-topology/)
        -  [利用 kubeadm 创建高可用集群](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/high-availability/)
        -  [使用 kubeadm 创建一个高可用 etcd 集群](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/setup-ha-etcd-with-kubeadm/)
        -  [使用 kubeadm 配置集群中的每个 kubelet](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/kubelet-integration/)
        -  [使用 kubeadm 支持双协议栈](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/dual-stack-support/)

      -  [使用 kOps 安装 Kubernetes](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kops/)

      -  [使用 Kubespray 安装 Kubernetes](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubespray/)

    -  [Turnkey 云解决方案](https://kubernetes.io/zh-cn/docs/setup/production-environment/turnkey-solutions/)

  -  

    [最佳实践](https://kubernetes.io/zh-cn/docs/setup/best-practices/)

    -  [大规模集群的注意事项](https://kubernetes.io/zh-cn/docs/setup/best-practices/cluster-large/)
    -  [运行于多可用区环境](https://kubernetes.io/zh-cn/docs/setup/best-practices/multiple-zones/)
    -  [校验节点设置](https://kubernetes.io/zh-cn/docs/setup/best-practices/node-conformance/)
    -  [强制实施 Pod 安全性标准](https://kubernetes.io/zh-cn/docs/setup/best-practices/enforcing-pod-security-standards/)
    -  [PKI 证书和要求](https://kubernetes.io/zh-cn/docs/setup/best-practices/certificates/)

-  

  [概念](https://kubernetes.io/zh-cn/docs/concepts/)

  -  

    [概述](https://kubernetes.io/zh-cn/docs/concepts/overview/)

    -  

      [Kubernetes 对象](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/)

      -  [Kubernetes 对象管理](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/object-management/)
      -  [对象名称和 ID](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/names/)
      -  [标签和选择算符](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/labels/)
      -  [名字空间](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/namespaces/)
      -  [注解](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/annotations/)
      -  [字段选择器](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/field-selectors/)
      -  [Finalizers](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/finalizers/)
      -  [属主与附属](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/owners-dependents/)
      -  [推荐使用的标签](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/common-labels/)

    -  [Kubernetes 组件](https://kubernetes.io/zh-cn/docs/concepts/overview/components/)

    -  [Kubernetes API](https://kubernetes.io/zh-cn/docs/concepts/overview/kubernetes-api/)

  -  

    [Kubernetes 架构](https://kubernetes.io/zh-cn/docs/concepts/architecture/)

    -  [节点](https://kubernetes.io/zh-cn/docs/concepts/architecture/nodes/)
    -  [节点与控制面之间的通信](https://kubernetes.io/zh-cn/docs/concepts/architecture/control-plane-node-communication/)
    -  [控制器](https://kubernetes.io/zh-cn/docs/concepts/architecture/controller/)
    -  [租约（Lease）](https://kubernetes.io/zh-cn/docs/concepts/architecture/leases/)
    -  [云控制器管理器](https://kubernetes.io/zh-cn/docs/concepts/architecture/cloud-controller/)
    -  [关于 cgroup v2](https://kubernetes.io/zh-cn/docs/concepts/architecture/cgroups/)
    -  [容器运行时接口（CRI）](https://kubernetes.io/zh-cn/docs/concepts/architecture/cri/)
    -  [垃圾收集](https://kubernetes.io/zh-cn/docs/concepts/architecture/garbage-collection/)
    -  [混合版本代理](https://kubernetes.io/zh-cn/docs/concepts/architecture/mixed-version-proxy/)

  -  

    [容器](https://kubernetes.io/zh-cn/docs/concepts/containers/)

    -  [镜像](https://kubernetes.io/zh-cn/docs/concepts/containers/images/)
    -  [容器环境](https://kubernetes.io/zh-cn/docs/concepts/containers/container-environment/)
    -  [容器运行时类（Runtime Class）](https://kubernetes.io/zh-cn/docs/concepts/containers/runtime-class/)
    -  [容器生命周期回调](https://kubernetes.io/zh-cn/docs/concepts/containers/container-lifecycle-hooks/)

  -  

    [工作负载](https://kubernetes.io/zh-cn/docs/concepts/workloads/)

    -  

      [Pod](https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/)

      -  [Pod 的生命周期](https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/pod-lifecycle/)
      -  [Init 容器](https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/init-containers/)
      -  [干扰（Disruptions）](https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/disruptions/)
      -  [临时容器](https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/ephemeral-containers/)
      -  [Pod QoS 类](https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/pod-qos/)
      -  [用户命名空间](https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/user-namespaces/)
      -  [Downward API](https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/downward-api/)

    -  

      [工作负载资源](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/)

      -  [Deployments](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/deployment/)
      -  [ReplicaSet](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/replicaset/)
      -  [StatefulSet](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/statefulset/)
      -  [DaemonSet](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/daemonset/)
      -  [Job](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/job/)
      -  [已完成 Job 的自动清理](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/ttlafterfinished/)
      -  [CronJob](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/cron-jobs/)
      -  [ReplicationController](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/replicationcontroller/)

  -  

    [服务、负载均衡和联网](https://kubernetes.io/zh-cn/docs/concepts/services-networking/)

    -  [服务（Service）](https://kubernetes.io/zh-cn/docs/concepts/services-networking/service/)
    -  [Ingress](https://kubernetes.io/zh-cn/docs/concepts/services-networking/ingress/)
    -  [Ingress 控制器](https://kubernetes.io/zh-cn/docs/concepts/services-networking/ingress-controllers/)
    -  [EndpointSlice](https://kubernetes.io/zh-cn/docs/concepts/services-networking/endpoint-slices/)
    -  [网络策略](https://kubernetes.io/zh-cn/docs/concepts/services-networking/network-policies/)
    -  [Service 与 Pod 的 DNS](https://kubernetes.io/zh-cn/docs/concepts/services-networking/dns-pod-service/)
    -  [IPv4/IPv6 双协议栈](https://kubernetes.io/zh-cn/docs/concepts/services-networking/dual-stack/)
    -  [拓扑感知路由](https://kubernetes.io/zh-cn/docs/concepts/services-networking/topology-aware-routing/)
    -  [Windows 网络](https://kubernetes.io/zh-cn/docs/concepts/services-networking/windows-networking/)
    -  [Service ClusterIP 分配](https://kubernetes.io/zh-cn/docs/concepts/services-networking/cluster-ip-allocation/)
    -  [服务内部流量策略](https://kubernetes.io/zh-cn/docs/concepts/services-networking/service-traffic-policy/)

  -  

    [存储](https://kubernetes.io/zh-cn/docs/concepts/storage/)

    -  [卷](https://kubernetes.io/zh-cn/docs/concepts/storage/volumes/)
    -  [持久卷](https://kubernetes.io/zh-cn/docs/concepts/storage/persistent-volumes/)
    -  [投射卷](https://kubernetes.io/zh-cn/docs/concepts/storage/projected-volumes/)
    -  [临时卷](https://kubernetes.io/zh-cn/docs/concepts/storage/ephemeral-volumes/)
    -  [存储类](https://kubernetes.io/zh-cn/docs/concepts/storage/storage-classes/)
    -  [动态卷制备](https://kubernetes.io/zh-cn/docs/concepts/storage/dynamic-provisioning/)
    -  [卷快照](https://kubernetes.io/zh-cn/docs/concepts/storage/volume-snapshots/)
    -  [卷快照类](https://kubernetes.io/zh-cn/docs/concepts/storage/volume-snapshot-classes/)
    -  [CSI 卷克隆](https://kubernetes.io/zh-cn/docs/concepts/storage/volume-pvc-datasource/)
    -  [存储容量](https://kubernetes.io/zh-cn/docs/concepts/storage/storage-capacity/)
    -  [特定于节点的卷数限制](https://kubernetes.io/zh-cn/docs/concepts/storage/storage-limits/)
    -  [卷健康监测](https://kubernetes.io/zh-cn/docs/concepts/storage/volume-health-monitoring/)
    -  [Windows 存储](https://kubernetes.io/zh-cn/docs/concepts/storage/windows-storage/)

  -  

    [配置](https://kubernetes.io/zh-cn/docs/concepts/configuration/)

    -  [配置最佳实践](https://kubernetes.io/zh-cn/docs/concepts/configuration/overview/)
    -  [ConfigMap](https://kubernetes.io/zh-cn/docs/concepts/configuration/configmap/)
    -  [Secret](https://kubernetes.io/zh-cn/docs/concepts/configuration/secret/)
    -  [为 Pod 和容器管理资源](https://kubernetes.io/zh-cn/docs/concepts/configuration/manage-resources-containers/)
    -  [使用 kubeconfig 文件组织集群访问](https://kubernetes.io/zh-cn/docs/concepts/configuration/organize-cluster-access-kubeconfig/)
    -  [Windows 节点的资源管理](https://kubernetes.io/zh-cn/docs/concepts/configuration/windows-resource-management/)

  -  

    [安全](https://kubernetes.io/zh-cn/docs/concepts/security/)

    -  [云原生安全概述](https://kubernetes.io/zh-cn/docs/concepts/security/overview/)
    -  [Pod 安全性标准](https://kubernetes.io/zh-cn/docs/concepts/security/pod-security-standards/)
    -  [Service Accounts](https://kubernetes.io/docs/concepts/security/service-accounts/)
    -  [Pod 安全性准入](https://kubernetes.io/zh-cn/docs/concepts/security/pod-security-admission/)
    -  [Pod 安全策略](https://kubernetes.io/zh-cn/docs/concepts/security/pod-security-policy/)
    -  [Windows 节点的安全性](https://kubernetes.io/zh-cn/docs/concepts/security/windows-security/)
    -  [Kubernetes API 访问控制](https://kubernetes.io/zh-cn/docs/concepts/security/controlling-access/)
    -  [基于角色的访问控制良好实践](https://kubernetes.io/zh-cn/docs/concepts/security/rbac-good-practices/)
    -  [Kubernetes Secret 良好实践](https://kubernetes.io/zh-cn/docs/concepts/security/secrets-good-practices/)
    -  [多租户](https://kubernetes.io/zh-cn/docs/concepts/security/multi-tenancy/)
    -  [Hardening Guide - Authentication Mechanisms](https://kubernetes.io/docs/concepts/security/hardening-guide/authentication-mechanisms/)
    -  [Kubernetes API 服务器旁路风险](https://kubernetes.io/zh-cn/docs/concepts/security/api-server-bypass-risks/)
    -  [安全检查清单](https://kubernetes.io/zh-cn/docs/concepts/security/security-checklist/)

  -  

    [策略](https://kubernetes.io/zh-cn/docs/concepts/policy/)

    -  [限制范围](https://kubernetes.io/zh-cn/docs/concepts/policy/limit-range/)
    -  [资源配额](https://kubernetes.io/zh-cn/docs/concepts/policy/resource-quotas/)
    -  [进程 ID 约束与预留](https://kubernetes.io/zh-cn/docs/concepts/policy/pid-limiting/)
    -  [节点资源管理器](https://kubernetes.io/zh-cn/docs/concepts/policy/node-resource-managers/)

  -  

    [调度、抢占和驱逐](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/)

    -  [Kubernetes 调度器](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/kube-scheduler/)
    -  [将 Pod 指派给节点](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/assign-pod-node/)
    -  [Pod 开销](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/pod-overhead/)
    -  [Pod 调度就绪态](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/pod-scheduling-readiness/)
    -  [Pod 拓扑分布约束](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/topology-spread-constraints/)
    -  [污点和容忍度](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/taint-and-toleration/)
    -  [调度框架](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/scheduling-framework/)
    -  [动态资源分配](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/dynamic-resource-allocation/)
    -  [调度器性能调优](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/scheduler-perf-tuning/)
    -  [资源装箱](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/resource-bin-packing/)
    -  [Pod 优先级和抢占](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/pod-priority-preemption/)
    -  [节点压力驱逐](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/node-pressure-eviction/)
    -  [API 发起的驱逐](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/api-eviction/)

  -  

    [集群管理](https://kubernetes.io/zh-cn/docs/concepts/cluster-administration/)

    -  [证书](https://kubernetes.io/zh-cn/docs/concepts/cluster-administration/certificates/)
    -  [管理资源](https://kubernetes.io/zh-cn/docs/concepts/cluster-administration/manage-deployment/)
    -  [集群网络系统](https://kubernetes.io/zh-cn/docs/concepts/cluster-administration/networking/)
    -  [日志架构](https://kubernetes.io/zh-cn/docs/concepts/cluster-administration/logging/)
    -  [Kubernetes 系统组件指标](https://kubernetes.io/zh-cn/docs/concepts/cluster-administration/system-metrics/)
    -  [系统日志](https://kubernetes.io/zh-cn/docs/concepts/cluster-administration/system-logs/)
    -  [追踪 Kubernetes 系统组件](https://kubernetes.io/zh-cn/docs/concepts/cluster-administration/system-traces/)
    -  [Kubernetes 中的代理](https://kubernetes.io/zh-cn/docs/concepts/cluster-administration/proxies/)
    -  [API 优先级和公平性](https://kubernetes.io/zh-cn/docs/concepts/cluster-administration/flow-control/)
    -  [安装扩展（Addon）](https://kubernetes.io/zh-cn/docs/concepts/cluster-administration/addons/)

  -  

    [Kubernetes 中的 Windows](https://kubernetes.io/zh-cn/docs/concepts/windows/)

    -  [Kubernetes 中的 Windows 容器](https://kubernetes.io/zh-cn/docs/concepts/windows/intro/)
    -  [Kubernetes 中的 Windows 容器调度指南](https://kubernetes.io/zh-cn/docs/concepts/windows/user-guide/)

  -  

    [扩展 Kubernetes](https://kubernetes.io/zh-cn/docs/concepts/extend-kubernetes/)

    -  [Operator 模式](https://kubernetes.io/zh-cn/docs/concepts/extend-kubernetes/operator/)

    -  

      [计算、存储和网络扩展](https://kubernetes.io/zh-cn/docs/concepts/extend-kubernetes/compute-storage-net/)

      -  [网络插件](https://kubernetes.io/zh-cn/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/)
      -  [设备插件](https://kubernetes.io/zh-cn/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/)

    -  

      [扩展 Kubernetes API](https://kubernetes.io/zh-cn/docs/concepts/extend-kubernetes/api-extension/)

      -  [定制资源](https://kubernetes.io/zh-cn/docs/concepts/extend-kubernetes/api-extension/custom-resources/)
      -  [Kubernetes API 聚合层](https://kubernetes.io/zh-cn/docs/concepts/extend-kubernetes/api-extension/apiserver-aggregation/)

-  

  [任务](https://kubernetes.io/zh-cn/docs/tasks/)

  -  

    [安装工具](https://kubernetes.io/zh-cn/docs/tasks/tools/)

    -  [在 Linux 系统中安装并设置 kubectl](https://kubernetes.io/zh-cn/docs/tasks/tools/install-kubectl-linux/)
    -  [在 macOS 系统上安装和设置 kubectl](https://kubernetes.io/zh-cn/docs/tasks/tools/install-kubectl-macos/)
    -  [在 Windows 上安装 kubectl](https://kubernetes.io/zh-cn/docs/tasks/tools/install-kubectl-windows/)

  -  

    [管理集群](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/)

    -  

      [用 kubeadm 进行管理](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/kubeadm/)

      -  [使用 kubeadm 进行证书管理](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/kubeadm/kubeadm-certs/)
      -  [配置 cgroup 驱动](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/kubeadm/configure-cgroup-driver/)
      -  [重新配置 kubeadm 集群](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/kubeadm/kubeadm-reconfigure/)
      -  [升级 kubeadm 集群](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/)
      -  [升级 Linux 节点](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/)
      -  [升级 Windows 节点](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/kubeadm/upgrading-windows-nodes/)
      -  [更改 Kubernetes 软件包仓库](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/kubeadm/change-package-repository/)

    -  

      [从 dockershim 迁移](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/migrating-from-dockershim/)

      -  [将节点上的容器运行时从 Docker Engine 改为 containerd](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/migrating-from-dockershim/change-runtime-containerd/)
      -  [将 Docker Engine 节点从 dockershim 迁移到 cri-dockerd](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/migrating-from-dockershim/migrate-dockershim-dockerd/)
      -  [查明节点上所使用的容器运行时](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/migrating-from-dockershim/find-out-runtime-you-use/)
      -  [排查 CNI 插件相关的错误](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/migrating-from-dockershim/troubleshooting-cni-plugin-related-errors/)
      -  [检查移除 Dockershim 是否对你有影响](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/migrating-from-dockershim/check-if-dockershim-removal-affects-you/)
      -  [从 dockershim 迁移遥测和安全代理](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/migrating-from-dockershim/migrating-telemetry-and-security-agents/)

    -  [手动生成证书](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/certificates/)

    -  

      [管理内存、CPU 和 API 资源](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/manage-resources/)

      -  [为命名空间配置默认的内存请求和限制](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/manage-resources/memory-default-namespace/)
      -  [为命名空间配置默认的 CPU 请求和限制](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/manage-resources/cpu-default-namespace/)
      -  [配置命名空间的最小和最大内存约束](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/manage-resources/memory-constraint-namespace/)
      -  [为命名空间配置 CPU 最小和最大约束](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/manage-resources/cpu-constraint-namespace/)
      -  [为命名空间配置内存和 CPU 配额](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/manage-resources/quota-memory-cpu-namespace/)
      -  [配置命名空间下 Pod 配额](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/manage-resources/quota-pod-namespace/)

    -  

      [安装网络策略驱动](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/network-policy-provider/)

      -  [使用 Antrea 提供 NetworkPolicy](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/network-policy-provider/antrea-network-policy/)
      -  [使用 Calico 提供 NetworkPolicy](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/network-policy-provider/calico-network-policy/)
      -  [使用 Cilium 提供 NetworkPolicy](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/network-policy-provider/cilium-network-policy/)
      -  [使用 kube-router 提供 NetworkPolicy](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/network-policy-provider/kube-router-network-policy/)
      -  [使用 Romana 提供 NetworkPolicy](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/network-policy-provider/romana-network-policy/)
      -  [使用 Weave Net 提供 NetworkPolicy](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/network-policy-provider/weave-network-policy/)

    -  [使用 Kubernetes API 访问集群](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/access-cluster-api/)

    -  [为节点发布扩展资源](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/extended-resource-node/)

    -  [自动扩缩集群 DNS 服务](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)

    -  [从轮询切换为基于 CRI 事件的更新来获取容器状态](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/switch-to-evented-pleg/)

    -  [改变默认 StorageClass](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/change-default-storage-class/)

    -  [更改 PersistentVolume 的回收策略](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/change-pv-reclaim-policy/)

    -  [Kubernetes 云管理控制器](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/running-cloud-controller/)

    -  [配置 kubelet 镜像凭据提供程序](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/kubelet-credential-provider/)

    -  [配置 API 对象配额](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/quota-api-object/)

    -  [控制节点上的 CPU 管理策略](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/cpu-management-policies/)

    -  [控制节点上的拓扑管理策略](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/topology-manager/)

    -  [自定义 DNS 服务](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/dns-custom-nameservers/)

    -  [调试 DNS 问题](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/dns-debugging-resolution/)

    -  [声明网络策略](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/declare-network-policy/)

    -  [开发云控制器管理器](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/developing-cloud-controller-manager/)

    -  [启用/禁用 Kubernetes API](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/enable-disable-api/)

    -  [静态加密机密数据](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/encrypt-data/)

    -  [解密已静态加密的机密数据](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/decrypt-data/)

    -  [关键插件 Pod 的调度保证](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/guaranteed-scheduling-critical-addon-pods/)

    -  [IP Masquerade Agent 用户指南](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/ip-masq-agent/)

    -  [限制存储使用量](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/limit-storage-consumption/)

    -  [迁移多副本的控制面以使用云控制器管理器](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/controller-manager-leader-migration/)

    -  [名字空间演练](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/namespaces-walkthrough/)

    -  [为 Kubernetes 运行 etcd 集群](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/configure-upgrade-etcd/)

    -  [为系统守护进程预留计算资源](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/reserve-compute-resources/)

    -  [以非 root 用户身份运行 Kubernetes 节点组件](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/kubelet-in-userns/)

    -  [安全地清空一个节点](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/safely-drain-node/)

    -  [保护集群](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/securing-a-cluster/)

    -  [通过配置文件设置 kubelet 参数](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/kubelet-config-file/)

    -  [通过名字空间共享集群](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/namespaces/)

    -  [升级集群](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/cluster-upgrade/)

    -  [在集群中使用级联删除](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/use-cascading-deletion/)

    -  [使用 KMS 驱动进行数据加密](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/kms-provider/)

    -  [使用 CoreDNS 进行服务发现](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/coredns/)

    -  [在 Kubernetes 集群中使用 NodeLocal DNSCache](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/nodelocaldns/)

    -  [在 Kubernetes 集群中使用 sysctl](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/sysctl-cluster/)

    -  [使用 NUMA 感知的内存管理器](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/memory-manager/)

    -  [验证已签名容器镜像](https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/verify-signed-artifacts/)

  -  

    [配置 Pods 和容器](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/)

    -  [为容器和 Pod 分配内存资源](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/assign-memory-resource/)
    -  [为容器和 Pods 分配 CPU 资源](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/assign-cpu-resource/)
    -  [调整分配给容器的 CPU 和内存资源](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/resize-container-resources/)
    -  [为 Windows Pod 和容器配置 GMSA](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-gmsa/)
    -  [为 Windows 的 Pod 和容器配置 RunAsUserName](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-runasusername/)
    -  [创建 Windows HostProcess Pod](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/create-hostprocess-pod/)
    -  [配置 Pod 的服务质量](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/quality-service-pod/)
    -  [为容器分派扩展资源](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/extended-resource/)
    -  [配置 Pod 以使用卷进行存储](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-volume-storage/)
    -  [配置 Pod 以使用 PersistentVolume 作为存储](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-persistent-volume-storage/)
    -  [配置 Pod 使用投射卷作存储](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-projected-volume-storage/)
    -  [为 Pod 或容器配置安全上下文](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/security-context/)
    -  [为 Pod 配置服务账号](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-service-account/)
    -  [从私有仓库拉取镜像](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/pull-image-private-registry/)
    -  [配置存活、就绪和启动探针](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
    -  [将 Pod 分配给节点](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/assign-pods-nodes/)
    -  [用节点亲和性把 Pod 分配到节点](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/)
    -  [配置 Pod 初始化](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-pod-initialization/)
    -  [为容器的生命周期事件设置处理函数](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/attach-handler-lifecycle-event/)
    -  [配置 Pod 使用 ConfigMap](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-pod-configmap/)
    -  [在 Pod 中的容器之间共享进程命名空间](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/share-process-namespace/)
    -  [为 Pod 配置用户名字空间](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/user-namespaces/)
    -  [创建静态 Pod](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/static-pod/)
    -  [将 Docker Compose 文件转换为 Kubernetes 资源](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/translate-compose-kubernetes/)
    -  [通过配置内置准入控制器实施 Pod 安全标准](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/enforce-standards-admission-controller/)
    -  [使用名字空间标签来实施 Pod 安全性标准](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/enforce-standards-namespace-labels/)
    -  [从 PodSecurityPolicy 迁移到内置的 PodSecurity 准入控制器](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/migrate-from-psp/)

  -  

    [监控、日志和调试](https://kubernetes.io/zh-cn/docs/tasks/debug/)

    -  

      [集群故障排查](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-cluster/)

      -  [kubectl 故障排查](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-cluster/troubleshoot-kubectl/)
      -  [资源监控工具](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-cluster/resource-usage-monitoring/)
      -  [资源指标管道](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/)
      -  [节点健康监测](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-cluster/monitor-node-health/)
      -  [使用 crictl 对 Kubernetes 节点进行调试](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-cluster/crictl/)
      -  [Windows 调试技巧](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-cluster/windows/)
      -  [审计](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-cluster/audit/)
      -  [使用 telepresence 在本地开发和调试服务](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-cluster/local-debugging/)
      -  [用 Kubectl 调试 Kubernetes 节点](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-cluster/kubectl-node-debug/)

    -  

      [应用故障排除](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-application/)

      -  [调试 Pod](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-application/debug-pods/)
      -  [调试 Service](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-application/debug-service/)
      -  [调试 StatefulSet](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-application/debug-statefulset/)
      -  [确定 Pod 失败的原因](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-application/determine-reason-pod-failure/)
      -  [调试 Init 容器](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-application/debug-init-containers/)
      -  [调试运行中的 Pod](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-application/debug-running-pod/)
      -  [获取正在运行容器的 Shell](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-application/get-shell-running-container/)

  -  

    [管理 Kubernetes 对象](https://kubernetes.io/zh-cn/docs/tasks/manage-kubernetes-objects/)

    -  [使用配置文件对 Kubernetes 对象进行声明式管理](https://kubernetes.io/zh-cn/docs/tasks/manage-kubernetes-objects/declarative-config/)
    -  [使用 Kustomize 对 Kubernetes 对象进行声明式管理](https://kubernetes.io/zh-cn/docs/tasks/manage-kubernetes-objects/kustomization/)
    -  [使用指令式命令管理 Kubernetes 对象](https://kubernetes.io/zh-cn/docs/tasks/manage-kubernetes-objects/imperative-command/)
    -  [使用配置文件对 Kubernetes 对象进行命令式管理](https://kubernetes.io/zh-cn/docs/tasks/manage-kubernetes-objects/imperative-config/)
    -  [使用 kubectl patch 更新 API 对象](https://kubernetes.io/zh-cn/docs/tasks/manage-kubernetes-objects/update-api-object-kubectl-patch/)

  -  

    [管理 Secrets](https://kubernetes.io/zh-cn/docs/tasks/configmap-secret/)

    -  [使用 kubectl 管理 Secret](https://kubernetes.io/zh-cn/docs/tasks/configmap-secret/managing-secret-using-kubectl/)
    -  [使用配置文件管理 Secret](https://kubernetes.io/zh-cn/docs/tasks/configmap-secret/managing-secret-using-config-file/)
    -  [使用 Kustomize 管理 Secret](https://kubernetes.io/zh-cn/docs/tasks/configmap-secret/managing-secret-using-kustomize/)

  -  

    [给应用注入数据](https://kubernetes.io/zh-cn/docs/tasks/inject-data-application/)

    -  [为容器设置启动时要执行的命令和参数](https://kubernetes.io/zh-cn/docs/tasks/inject-data-application/define-command-argument-container/)
    -  [定义相互依赖的环境变量](https://kubernetes.io/zh-cn/docs/tasks/inject-data-application/define-interdependent-environment-variables/)
    -  [为容器设置环境变量](https://kubernetes.io/zh-cn/docs/tasks/inject-data-application/define-environment-variable-container/)
    -  [通过环境变量将 Pod 信息呈现给容器](https://kubernetes.io/zh-cn/docs/tasks/inject-data-application/environment-variable-expose-pod-information/)
    -  [通过文件将 Pod 信息呈现给容器](https://kubernetes.io/zh-cn/docs/tasks/inject-data-application/downward-api-volume-expose-pod-information/)
    -  [使用 Secret 安全地分发凭据](https://kubernetes.io/zh-cn/docs/tasks/inject-data-application/distribute-credentials-secure/)

  -  

    [运行应用](https://kubernetes.io/zh-cn/docs/tasks/run-application/)

    -  [使用 Deployment 运行一个无状态应用](https://kubernetes.io/zh-cn/docs/tasks/run-application/run-stateless-application-deployment/)
    -  [运行一个单实例有状态应用](https://kubernetes.io/zh-cn/docs/tasks/run-application/run-single-instance-stateful-application/)
    -  [运行一个有状态的应用程序](https://kubernetes.io/zh-cn/docs/tasks/run-application/run-replicated-stateful-application/)
    -  [扩缩 StatefulSet](https://kubernetes.io/zh-cn/docs/tasks/run-application/scale-stateful-set/)
    -  [删除 StatefulSet](https://kubernetes.io/zh-cn/docs/tasks/run-application/delete-stateful-set/)
    -  [强制删除 StatefulSet 中的 Pod](https://kubernetes.io/zh-cn/docs/tasks/run-application/force-delete-stateful-set-pod/)
    -  [Pod 水平自动扩缩](https://kubernetes.io/zh-cn/docs/tasks/run-application/horizontal-pod-autoscale/)
    -  [HorizontalPodAutoscaler 演练](https://kubernetes.io/zh-cn/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)
    -  [为应用程序设置干扰预算（Disruption Budget）](https://kubernetes.io/zh-cn/docs/tasks/run-application/configure-pdb/)
    -  [从 Pod 中访问 Kubernetes API](https://kubernetes.io/zh-cn/docs/tasks/run-application/access-api-from-pod/)

  -  

    [运行 Jobs](https://kubernetes.io/zh-cn/docs/tasks/job/)

    -  [使用 CronJob 运行自动化任务](https://kubernetes.io/zh-cn/docs/tasks/job/automated-tasks-with-cron-jobs/)
    -  [使用工作队列进行粗粒度并行处理](https://kubernetes.io/zh-cn/docs/tasks/job/coarse-parallel-processing-work-queue/)
    -  [带 Pod 间通信的 Job](https://kubernetes.io/zh-cn/docs/tasks/job/job-with-pod-to-pod-communication/)
    -  [使用工作队列进行精细的并行处理](https://kubernetes.io/zh-cn/docs/tasks/job/fine-parallel-processing-work-queue/)
    -  [使用索引作业完成静态工作分配下的并行处理](https://kubernetes.io/zh-cn/docs/tasks/job/indexed-parallel-processing-static/)
    -  [使用展开的方式进行并行处理](https://kubernetes.io/zh-cn/docs/tasks/job/parallel-processing-expansion/)
    -  [使用 Pod 失效策略处理可重试和不可重试的 Pod 失效](https://kubernetes.io/zh-cn/docs/tasks/job/pod-failure-policy/)

  -  

    [访问集群中的应用程序](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/)

    -  [部署和访问 Kubernetes 仪表板（Dashboard）](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/web-ui-dashboard/)
    -  [访问集群](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/access-cluster/)
    -  [配置对多集群的访问](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/configure-access-multiple-clusters/)
    -  [使用端口转发来访问集群中的应用](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/port-forward-access-application-cluster/)
    -  [使用服务来访问集群中的应用](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/service-access-application-cluster/)
    -  [使用 Service 把前端连接到后端](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/connecting-frontend-backend/)
    -  [创建外部负载均衡器](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/create-external-load-balancer/)
    -  [列出集群中所有运行容器的镜像](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/list-all-running-container-images/)
    -  [在 Minikube 环境中使用 NGINX Ingress 控制器配置 Ingress](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/ingress-minikube/)
    -  [同 Pod 内的容器使用共享卷通信](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/communicate-containers-same-pod-shared-volume/)
    -  [为集群配置 DNS](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/configure-dns-cluster/)
    -  [访问集群上运行的服务](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/access-cluster-services/)

  -  

    [扩展 Kubernetes](https://kubernetes.io/zh-cn/docs/tasks/extend-kubernetes/)

    -  [配置聚合层](https://kubernetes.io/zh-cn/docs/tasks/extend-kubernetes/configure-aggregation-layer/)

    -  

      [使用自定义资源](https://kubernetes.io/zh-cn/docs/tasks/extend-kubernetes/custom-resources/)

      -  [使用 CustomResourceDefinition 扩展 Kubernetes API](https://kubernetes.io/zh-cn/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/)
      -  [CustomResourceDefinition 的版本](https://kubernetes.io/zh-cn/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definition-versioning/)

    -  [安装一个扩展的 API server](https://kubernetes.io/zh-cn/docs/tasks/extend-kubernetes/setup-extension-api-server/)

    -  [配置多个调度器](https://kubernetes.io/zh-cn/docs/tasks/extend-kubernetes/configure-multiple-schedulers/)

    -  [使用 HTTP 代理访问 Kubernetes API](https://kubernetes.io/zh-cn/docs/tasks/extend-kubernetes/http-proxy-access-api/)

    -  [使用 SOCKS5 代理访问 Kubernetes API](https://kubernetes.io/zh-cn/docs/tasks/extend-kubernetes/socks5-proxy-access-api/)

    -  [设置 Konnectivity 服务](https://kubernetes.io/zh-cn/docs/tasks/extend-kubernetes/setup-konnectivity/)

  -  

    [TLS](https://kubernetes.io/zh-cn/docs/tasks/tls/)

    -  [管理集群中的 TLS 认证](https://kubernetes.io/zh-cn/docs/tasks/tls/managing-tls-in-a-cluster/)
    -  [手动轮换 CA 证书](https://kubernetes.io/zh-cn/docs/tasks/tls/manual-rotation-of-ca-certificates/)
    -  [为 kubelet 配置证书轮换](https://kubernetes.io/zh-cn/docs/tasks/tls/certificate-rotation/)

  -  

    [管理集群守护进程](https://kubernetes.io/zh-cn/docs/tasks/manage-daemon/)

    -  [对 DaemonSet 执行滚动更新](https://kubernetes.io/zh-cn/docs/tasks/manage-daemon/update-daemon-set/)
    -  [对 DaemonSet 执行回滚](https://kubernetes.io/zh-cn/docs/tasks/manage-daemon/rollback-daemon-set/)
    -  [仅在某些节点上运行 Pod](https://kubernetes.io/zh-cn/docs/tasks/manage-daemon/pods-some-nodes/)

  -  

    [网络](https://kubernetes.io/zh-cn/docs/tasks/network/)

    -  [使用 HostAliases 向 Pod /etc/hosts 文件添加条目](https://kubernetes.io/zh-cn/docs/tasks/network/customize-hosts-file-for-pods/)
    -  [验证 IPv4/IPv6 双协议栈](https://kubernetes.io/zh-cn/docs/tasks/network/validate-dual-stack/)

  -  [调度 GPU](https://kubernetes.io/zh-cn/docs/tasks/manage-gpus/scheduling-gpus/)

  -  [管理巨页（HugePage）](https://kubernetes.io/zh-cn/docs/tasks/manage-hugepages/scheduling-hugepages/)

  -  [用插件扩展 kubectl](https://kubernetes.io/zh-cn/docs/tasks/extend-kubectl/kubectl-plugins/)

-  

  [教程](https://kubernetes.io/zh-cn/docs/tutorials/)

  -  [你好，Minikube](https://kubernetes.io/zh-cn/docs/tutorials/hello-minikube/)

  -  

    [学习 Kubernetes 基础知识](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/)

    -  

      [创建集群](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/create-cluster/)

      -  [使用 Minikube 创建集群](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/create-cluster/cluster-intro/)

    -  

      [部署应用](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/deploy-app/)

      -  [使用 kubectl 创建 Deployment](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/deploy-app/deploy-intro/)

    -  

      [了解你的应用](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/explore/)

      -  [查看 Pod 和节点](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/explore/explore-intro/)
      -  [交互式教程 - 探索你的应用](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/explore/explore-interactive/)

    -  

      [公开地暴露你的应用](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/expose/)

      -  [使用 Service 暴露你的应用](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/expose/expose-intro/)

    -  

      [扩缩你的应用](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/scale/)

      -  [运行应用程序的多个实例](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/scale/scale-intro/)

    -  

      [更新你的应用](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/update/)

      -  [执行滚动更新](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/update/update-intro/)
      -  [交互式教程 - 更新你的应用](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/update/update-interactive/)

  -  

    [配置](https://kubernetes.io/zh-cn/docs/tutorials/configuration/)

    -  

      [示例：配置 java 微服务](https://kubernetes.io/zh-cn/docs/tutorials/configuration/configure-java-microservice/)

      -  [使用 MicroProfile、ConfigMaps、Secrets 实现外部化应用配置](https://kubernetes.io/zh-cn/docs/tutorials/configuration/configure-java-microservice/configure-java-microservice/)
      -  [互动教程 - 配置 java 微服务](https://kubernetes.io/zh-cn/docs/tutorials/configuration/configure-java-microservice/configure-java-microservice-interactive/)

    -  [使用 ConfigMap 来配置 Redis](https://kubernetes.io/zh-cn/docs/tutorials/configuration/configure-redis-using-configmap/)

  -  

    [安全](https://kubernetes.io/zh-cn/docs/tutorials/security/)

    -  [在集群级别应用 Pod 安全标准](https://kubernetes.io/zh-cn/docs/tutorials/security/cluster-level-pss/)
    -  [在名字空间级别应用 Pod 安全标准](https://kubernetes.io/zh-cn/docs/tutorials/security/ns-level-pss/)
    -  [使用 AppArmor 限制容器对资源的访问](https://kubernetes.io/zh-cn/docs/tutorials/security/apparmor/)
    -  [使用 seccomp 限制容器的系统调用](https://kubernetes.io/zh-cn/docs/tutorials/security/seccomp/)

  -  

    [无状态的应用](https://kubernetes.io/zh-cn/docs/tutorials/stateless-application/)

    -  [公开外部 IP 地址以访问集群中应用程序](https://kubernetes.io/zh-cn/docs/tutorials/stateless-application/expose-external-ip-address/)
    -  [示例：使用 Redis 部署 PHP 留言板应用](https://kubernetes.io/zh-cn/docs/tutorials/stateless-application/guestbook/)

  -  

    [有状态的应用](https://kubernetes.io/zh-cn/docs/tutorials/stateful-application/)

    -  [StatefulSet 基础](https://kubernetes.io/zh-cn/docs/tutorials/stateful-application/basic-stateful-set/)
    -  [示例：使用持久卷部署 WordPress 和 MySQL](https://kubernetes.io/zh-cn/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/)
    -  [示例：使用 StatefulSet 部署 Cassandra](https://kubernetes.io/zh-cn/docs/tutorials/stateful-application/cassandra/)
    -  [运行 ZooKeeper，一个分布式协调系统](https://kubernetes.io/zh-cn/docs/tutorials/stateful-application/zookeeper/)

  -  

    [Service](https://kubernetes.io/zh-cn/docs/tutorials/services/)

    -  [使用 Service 连接到应用](https://kubernetes.io/zh-cn/docs/tutorials/services/connect-applications-service/)
    -  [使用源 IP](https://kubernetes.io/zh-cn/docs/tutorials/services/source-ip/)
    -  [探索 Pod 及其端点的终止行为](https://kubernetes.io/zh-cn/docs/tutorials/services/pods-and-endpoint-termination-flow/)

-  

  [参考](https://kubernetes.io/zh-cn/docs/reference/)

  -  [词汇表](https://kubernetes.io/zh-cn/docs/reference/glossary/)

  -  

    [API 概述](https://kubernetes.io/zh-cn/docs/reference/using-api/)

    -  [Kubernetes API 概念](https://kubernetes.io/zh-cn/docs/reference/using-api/api-concepts/)
    -  [服务器端应用（Server-Side Apply）](https://kubernetes.io/zh-cn/docs/reference/using-api/server-side-apply/)
    -  [客户端库](https://kubernetes.io/zh-cn/docs/reference/using-api/client-libraries/)
    -  [Kubernetes 中的通用表达式语言](https://kubernetes.io/zh-cn/docs/reference/using-api/cel/)
    -  [Kubernetes 弃用策略](https://kubernetes.io/zh-cn/docs/reference/using-api/deprecation-policy/)
    -  [已弃用 API 的迁移指南](https://kubernetes.io/zh-cn/docs/reference/using-api/deprecation-guide/)
    -  [Kubernetes API 健康端点](https://kubernetes.io/zh-cn/docs/reference/using-api/health-checks/)

  -  

    [API 访问控制](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/)

    -  [用户认证](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/authentication/)
    -  [使用启动引导令牌（Bootstrap Tokens）认证](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/bootstrap-tokens/)
    -  [证书和证书签名请求](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/certificate-signing-requests/)
    -  [准入控制器](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/admission-controllers/)
    -  [动态准入控制](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/extensible-admission-controllers/)
    -  [管理服务账号](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/service-accounts-admin/)
    -  [鉴权概述](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/authorization/)
    -  [使用 RBAC 鉴权](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/rbac/)
    -  [使用 ABAC 鉴权](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/abac/)
    -  [使用 Node 鉴权](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/node/)
    -  [从 PodSecurityPolicy 映射到 Pod 安全性标准](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/psp-to-pod-security-standards/)
    -  [Webhook 模式](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/webhook/)
    -  [Kubelet 认证/鉴权](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/kubelet-authn-authz/)
    -  [TLS 启动引导](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/kubelet-tls-bootstrapping/)
    -  [验证准入策略（ValidatingAdmissionPolicy）](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/validating-admission-policy/)

  -  

    [众所周知的标签、注解和污点](https://kubernetes.io/zh-cn/docs/reference/labels-annotations-taints/)

    -  [审计注解](https://kubernetes.io/zh-cn/docs/reference/labels-annotations-taints/audit-annotations/)

  -  

    [Kubernetes API](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/)

    -  

      [工作负载资源](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/)

      -  [Pod](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/pod-v1/)
      -  [PodTemplate](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/pod-template-v1/)
      -  [ReplicationController](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/replication-controller-v1/)
      -  [ReplicaSet](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/replica-set-v1/)
      -  [Deployment](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/deployment-v1/)
      -  [StatefulSet](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/stateful-set-v1/)
      -  [ControllerRevision](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/controller-revision-v1/)
      -  [DaemonSet](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/daemon-set-v1/)
      -  [Job](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/job-v1/)
      -  [CronJob](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/cron-job-v1/)
      -  [HorizontalPodAutoscaler](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v1/)
      -  [HorizontalPodAutoscaler](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2/)
      -  [PriorityClass](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/priority-class-v1/)
      -  [PodSchedulingContext v1alpha2](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/pod-scheduling-context-v1alpha2/)
      -  [ResourceClaim v1alpha2](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/resource-claim-v1alpha2/)
      -  [ResourceClaimTemplate v1alpha2](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/resource-claim-template-v1alpha2/)
      -  [ResourceClass v1alpha2](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/workload-resources/resource-class-v1alpha2/)

    -  

      [Service 资源](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/service-resources/)

      -  [Service](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/service-resources/service-v1/)
      -  [Endpoints](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/service-resources/endpoints-v1/)
      -  [EndpointSlice](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/service-resources/endpoint-slice-v1/)
      -  [Ingress](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/service-resources/ingress-v1/)
      -  [IngressClass](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/service-resources/ingress-class-v1/)

    -  

      [配置和存储资源](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/config-and-storage-resources/)

      -  [ConfigMap](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/config-and-storage-resources/config-map-v1/)
      -  [Secret](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/config-and-storage-resources/secret-v1/)
      -  [Volume](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/config-and-storage-resources/volume/)
      -  [PersistentVolumeClaim](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/)
      -  [PersistentVolume](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/)
      -  [StorageClass](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/config-and-storage-resources/storage-class-v1/)
      -  [VolumeAttachment](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/config-and-storage-resources/volume-attachment-v1/)
      -  [CSIDriver](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/config-and-storage-resources/csi-driver-v1/)
      -  [CSINode](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/config-and-storage-resources/csi-node-v1/)
      -  [CSIStorageCapacity](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/config-and-storage-resources/csi-storage-capacity-v1/)

    -  

      [身份认证资源](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authentication-resources/)

      -  [ServiceAccount](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authentication-resources/service-account-v1/)
      -  [TokenRequest](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authentication-resources/token-request-v1/)
      -  [TokenReview](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authentication-resources/token-review-v1/)
      -  [CertificateSigningRequest](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authentication-resources/certificate-signing-request-v1/)
      -  [ClusterTrustBundle v1alpha1](https://kubernetes.io/docs/reference/kubernetes-api/authentication-resources/cluster-trust-bundle-v1alpha1/)
      -  [SelfSubjectReview](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authentication-resources/self-subject-review-v1/)

    -  

      [鉴权资源](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authorization-resources/)

      -  [LocalSubjectAccessReview](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authorization-resources/local-subject-access-review-v1/)
      -  [SelfSubjectAccessReview](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authorization-resources/self-subject-access-review-v1/)
      -  [SelfSubjectRulesReview](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authorization-resources/self-subject-rules-review-v1/)
      -  [SubjectAccessReview](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authorization-resources/subject-access-review-v1/)
      -  [ClusterRole](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authorization-resources/cluster-role-v1/)
      -  [ClusterRoleBinding](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authorization-resources/cluster-role-binding-v1/)
      -  [Role](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authorization-resources/role-v1/)
      -  [RoleBinding](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/authorization-resources/role-binding-v1/)

    -  

      [策略资源](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/policy-resources/)

      -  [LimitRange](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/policy-resources/limit-range-v1/)
      -  [ResourceQuota](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/policy-resources/resource-quota-v1/)
      -  [NetworkPolicy](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/policy-resources/network-policy-v1/)
      -  [PodDisruptionBudget](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/policy-resources/pod-disruption-budget-v1/)
      -  [IPAddress v1alpha1](https://kubernetes.io/docs/reference/kubernetes-api/policy-resources/ip-address-v1alpha1/)

    -  

      [扩展资源](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/extend-resources/)

      -  [CustomResourceDefinition](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/extend-resources/custom-resource-definition-v1/)
      -  [MutatingWebhookConfiguration](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/extend-resources/mutating-webhook-configuration-v1/)
      -  [ValidatingWebhookConfiguration](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/extend-resources/validating-webhook-configuration-v1/)
      -  [ValidatingAdmissionPolicy v1beta1](https://kubernetes.io/docs/reference/kubernetes-api/extend-resources/validating-admission-policy-v1beta1/)

    -  

      [集群资源](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/cluster-resources/)

      -  [Node](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/cluster-resources/node-v1/)
      -  [Namespace](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/cluster-resources/namespace-v1/)
      -  [Event](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/cluster-resources/event-v1/)
      -  [APIService](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/cluster-resources/api-service-v1/)
      -  [Lease](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/cluster-resources/lease-v1/)
      -  [RuntimeClass](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/cluster-resources/runtime-class-v1/)
      -  [FlowSchema v1beta3](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/cluster-resources/flow-schema-v1beta3/)
      -  [PriorityLevelConfiguration v1beta3](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/cluster-resources/priority-level-configuration-v1beta3/)
      -  [Binding](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/cluster-resources/binding-v1/)
      -  [ComponentStatus](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/cluster-resources/component-status-v1/)
      -  [ClusterCIDR v1alpha1](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/cluster-resources/cluster-cidr-v1alpha1/)

    -  

      [公共定义](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/)

      -  [DeleteOptions](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/delete-options/)
      -  [LabelSelector](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/label-selector/)
      -  [ListMeta](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/list-meta/)
      -  [LocalObjectReference](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/local-object-reference/)
      -  [NodeSelectorRequirement](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/node-selector-requirement/)
      -  [ObjectFieldSelector](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/object-field-selector/)
      -  [ObjectMeta](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/object-meta/)
      -  [ObjectReference](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/object-reference/)
      -  [Patch](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/patch/)
      -  [Quantity](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/quantity/)
      -  [ResourceFieldSelector](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/resource-field-selector/)
      -  [Status](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/status/)
      -  [TypedLocalObjectReference](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-definitions/typed-local-object-reference/)

    -  

      [其他资源](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/other-resources/)

      -  [ValidatingAdmissionPolicyBindingList v1beta1](https://kubernetes.io/docs/reference/kubernetes-api/other-resources/validating-admission-policy-binding-list-v1beta1/)
      -  [ValidatingAdmissionPolicyBindingList v1beta1](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/other-resources/validating-admission-policy-binding-list-v1alpha1/)

    -  [常用参数](https://kubernetes.io/zh-cn/docs/reference/kubernetes-api/common-parameters/common-parameters/)

  -  

    [插桩](https://kubernetes.io/zh-cn/docs/reference/instrumentation/)

    -  [服务水平指示器指标](https://kubernetes.io/zh-cn/docs/reference/instrumentation/slis/)
    -  [CRI Pod 和容器指标](https://kubernetes.io/zh-cn/docs/reference/instrumentation/cri-pod-container-metrics/)
    -  [节点指标数据](https://kubernetes.io/zh-cn/docs/reference/instrumentation/node-metrics/)
    -  [Kubernetes Metrics Reference](https://kubernetes.io/docs/reference/instrumentation/metrics/)

  -  

    [Kubernetes 问题和安全](https://kubernetes.io/zh-cn/docs/reference/issues-security/)

    -  [Kubernetes 问题追踪](https://kubernetes.io/zh-cn/docs/reference/issues-security/issues/)
    -  [Kubernetes 安全和信息披露](https://kubernetes.io/zh-cn/docs/reference/issues-security/security/)
    -  [CVE feed](https://kubernetes.io/zh-cn/docs/reference/issues-security/official-cve-feed/)

  -  

    [节点参考信息](https://kubernetes.io/zh-cn/docs/reference/node/)

    -  [Kubelet Checkpoint API](https://kubernetes.io/zh-cn/docs/reference/node/kubelet-checkpoint-api/)
    -  [关于 dockershim 移除和使用兼容 CRI 运行时的文章](https://kubernetes.io/zh-cn/docs/reference/node/topics-on-dockershim-and-cri-compatible-runtimes/)
    -  [Kubelet 设备管理器 API 版本](https://kubernetes.io/zh-cn/docs/reference/node/device-plugin-api-versions/)
    -  [节点状态](https://kubernetes.io/zh-cn/docs/reference/node/node-status/)
    - 

  -  

    [网络参考](https://kubernetes.io/zh-cn/docs/reference/networking/)

    -  [Service 所用的协议](https://kubernetes.io/zh-cn/docs/reference/networking/service-protocols/)
    -  [端口和协议](https://kubernetes.io/zh-cn/docs/reference/networking/ports-and-protocols/)
    -  [虚拟 IP 和服务代理](https://kubernetes.io/zh-cn/docs/reference/networking/virtual-ips/)

  -  

    [安装工具](https://kubernetes.io/zh-cn/docs/reference/setup-tools/)

    -  

      [Kubeadm](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/)

      -  [kubeadm init](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-init/)
      -  [kubeadm join](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-join/)
      -  [kubeadm upgrade](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-upgrade/)
      -  [kubeadm config](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-config/)
      -  [kubeadm reset](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-reset/)
      -  [kubeadm token](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-token/)
      -  [kubeadm version](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-version/)
      -  [kubeadm alpha](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-alpha/)
      -  [kubeadm certs](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-certs/)
      -  [kubeadm init phase](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-init-phase/)
      -  [kubeadm join phase](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-join-phase/)
      -  [kubeadm kubeconfig](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-kubeconfig/)
      -  [kubeadm reset phase](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-reset-phase/)
      -  [kubeadm upgrade phase](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-upgrade-phase/)
      -  [实现细节](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/implementation-details/)

  -  

    [命令行工具 (kubectl)](https://kubernetes.io/zh-cn/docs/reference/kubectl/)

    -  [kubectl 备忘单](https://kubernetes.io/zh-cn/docs/reference/kubectl/cheatsheet/)
    -  [kubectl 命令](https://kubernetes.io/zh-cn/docs/reference/kubectl/kubectl-cmds/)
    -  [kubectl](https://kubernetes.io/zh-cn/docs/reference/kubectl/kubectl/)
    -  [JSONPath 支持](https://kubernetes.io/zh-cn/docs/reference/kubectl/jsonpath/)
    -  [适用于 Docker 用户的 kubectl](https://kubernetes.io/zh-cn/docs/reference/kubectl/docker-cli-to-kubectl/)
    -  [kubectl 的用法约定](https://kubernetes.io/zh-cn/docs/reference/kubectl/conventions/)

  -  

    [调试集群](https://kubernetes.io/zh-cn/docs/reference/debug-cluster/)

    -  [流控](https://kubernetes.io/zh-cn/docs/reference/debug-cluster/flow-control/)

  -  

    [组件工具](https://kubernetes.io/zh-cn/docs/reference/command-line-tools-reference/)

    -  [特性门控](https://kubernetes.io/zh-cn/docs/reference/command-line-tools-reference/feature-gates/)
    -  [特性门控（已移除）](https://kubernetes.io/zh-cn/docs/reference/command-line-tools-reference/feature-gates-removed/)
    -  [kubelet](https://kubernetes.io/zh-cn/docs/reference/command-line-tools-reference/kubelet/)
    -  [kube-apiserver](https://kubernetes.io/zh-cn/docs/reference/command-line-tools-reference/kube-apiserver/)
    -  [kube-controller-manager](https://kubernetes.io/zh-cn/docs/reference/command-line-tools-reference/kube-controller-manager/)
    -  [kube-proxy](https://kubernetes.io/zh-cn/docs/reference/command-line-tools-reference/kube-proxy/)
    -  [kube-scheduler](https://kubernetes.io/zh-cn/docs/reference/command-line-tools-reference/kube-scheduler/)

  -  

    [配置 API](https://kubernetes.io/zh-cn/docs/reference/config-api/)

    -  [Event Rate Limit Configuration (v1alpha1)](https://kubernetes.io/zh-cn/docs/reference/config-api/apiserver-eventratelimit.v1alpha1/)
    -  [Image Policy API (v1alpha1)](https://kubernetes.io/zh-cn/docs/reference/config-api/imagepolicy.v1alpha1/)
    -  [kube 配置 (v1)](https://kubernetes.io/zh-cn/docs/reference/config-api/kubeconfig.v1/)
    -  [kube-apiserver Admission (v1)](https://kubernetes.io/docs/reference/config-api/apiserver-admission.v1/)
    -  [kube-apiserver Audit 配置 (v1)](https://kubernetes.io/zh-cn/docs/reference/config-api/apiserver-audit.v1/)
    -  [kube-apiserver 加密配置 (v1)](https://kubernetes.io/zh-cn/docs/reference/config-api/apiserver-encryption.v1/)
    -  [kube-apiserver 配置 (v1)](https://kubernetes.io/zh-cn/docs/reference/config-api/apiserver-config.v1/)
    -  [kube-apiserver 配置 (v1alpha1)](https://kubernetes.io/zh-cn/docs/reference/config-api/apiserver-config.v1alpha1/)
    -  [kube-apiserver 配置 (v1beta1)](https://kubernetes.io/zh-cn/docs/reference/config-api/apiserver-config.v1beta1/)
    -  [kube-controller-manager Configuration (v1alpha1)](https://kubernetes.io/docs/reference/config-api/kube-controller-manager-config.v1alpha1/)
    -  [kube-proxy 配置 (v1alpha1)](https://kubernetes.io/zh-cn/docs/reference/config-api/kube-proxy-config.v1alpha1/)
    -  [kube-scheduler 配置 (v1)](https://kubernetes.io/zh-cn/docs/reference/config-api/kube-scheduler-config.v1/)
    -  [kube-scheduler 配置 (v1beta3)](https://kubernetes.io/zh-cn/docs/reference/config-api/kube-scheduler-config.v1beta3/)
    -  [kubeadm Configuration (v1beta4)](https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta4/)
    -  [kubeadm 配置 (v1beta3)](https://kubernetes.io/zh-cn/docs/reference/config-api/kubeadm-config.v1beta3/)
    -  [Kubelet CredentialProvider (v1)](https://kubernetes.io/zh-cn/docs/reference/config-api/kubelet-credentialprovider.v1/)
    -  [Kubelet CredentialProvider (v1alpha1)](https://kubernetes.io/zh-cn/docs/reference/config-api/kubelet-credentialprovider.v1alpha1/)
    -  [Kubelet CredentialProvider (v1beta1)](https://kubernetes.io/zh-cn/docs/reference/config-api/kubelet-credentialprovider.v1beta1/)
    -  [Kubelet 配置 (v1)](https://kubernetes.io/zh-cn/docs/reference/config-api/kubelet-config.v1/)
    -  [Kubelet 配置 (v1alpha1)](https://kubernetes.io/zh-cn/docs/reference/config-api/kubelet-config.v1alpha1/)
    -  [Kubelet 配置 (v1beta1)](https://kubernetes.io/zh-cn/docs/reference/config-api/kubelet-config.v1beta1/)
    -  [WebhookAdmission 配置 (v1)](https://kubernetes.io/zh-cn/docs/reference/config-api/apiserver-webhookadmission.v1/)
    -  [客户端身份认证（Client Authentication） (v1)](https://kubernetes.io/zh-cn/docs/reference/config-api/client-authentication.v1/)
    -  [客户端身份认证（Client Authentication）(v1beta1)](https://kubernetes.io/zh-cn/docs/reference/config-api/client-authentication.v1beta1/)

  -  

    [外部 API](https://kubernetes.io/zh-cn/docs/reference/external-api/)

    -  [Kubernetes 外部指标 (v1beta1)](https://kubernetes.io/zh-cn/docs/reference/external-api/external-metrics.v1beta1/)
    -  [Kubernetes 指标 (v1beta1)](https://kubernetes.io/zh-cn/docs/reference/external-api/metrics.v1beta1/)
    -  [Kubernetes 自定义指标 (v1beta2)](https://kubernetes.io/zh-cn/docs/reference/external-api/custom-metrics.v1beta2/)

  -  

    [调度](https://kubernetes.io/zh-cn/docs/reference/scheduling/)

    -  [调度器配置](https://kubernetes.io/zh-cn/docs/reference/scheduling/config/)
    -  [调度策略](https://kubernetes.io/zh-cn/docs/reference/scheduling/policies/)

  -  

    [其他工具](https://kubernetes.io/zh-cn/docs/reference/tools/)

    -  [从 Docker 命令行映射到 crictl](https://kubernetes.io/zh-cn/docs/reference/tools/map-crictl-dockercli/)

-  

  [贡献](https://kubernetes.io/zh-cn/docs/contribute/)

  -  [提出内容改进建议](https://kubernetes.io/zh-cn/docs/contribute/suggesting-improvements/)

  -  

    [贡献新内容](https://kubernetes.io/zh-cn/docs/contribute/new-content/)

    -  [发起拉取请求（PR）](https://kubernetes.io/zh-cn/docs/contribute/new-content/open-a-pr/)
    -  [为发行版本撰写文档](https://kubernetes.io/zh-cn/docs/contribute/new-content/new-features/)
    -  [博客和案例分析](https://kubernetes.io/zh-cn/docs/contribute/new-content/blogs-case-studies/)

  -  

    [评阅变更](https://kubernetes.io/zh-cn/docs/contribute/review/)

    -  [评审 PR](https://kubernetes.io/zh-cn/docs/contribute/review/reviewing-prs/)
    -  [评阅人和批准人](https://kubernetes.io/zh-cn/docs/contribute/review/for-approvers/)

  -  [本地化 Kubernetes 文档](https://kubernetes.io/zh-cn/docs/contribute/localization/)

  -  

    [参与 SIG Docs](https://kubernetes.io/zh-cn/docs/contribute/participate/)

    -  [角色与责任](https://kubernetes.io/zh-cn/docs/contribute/participate/roles-and-responsibilities/)
    -  [Issue 管理者](https://kubernetes.io/zh-cn/docs/contribute/participate/issue-wrangler/)
    -  [PR 管理者](https://kubernetes.io/zh-cn/docs/contribute/participate/pr-wranglers/)

  -  

    [更新参考文档](https://kubernetes.io/zh-cn/docs/contribute/generate-ref-docs/)

    -  [Quickstart](https://kubernetes.io/zh-cn/docs/contribute/generate-ref-docs/quickstart/)
    -  [为上游 Kubernetes 代码库做出贡献](https://kubernetes.io/zh-cn/docs/contribute/generate-ref-docs/contribute-upstream/)
    -  [为 Kubernetes API 生成参考文档](https://kubernetes.io/zh-cn/docs/contribute/generate-ref-docs/kubernetes-api/)
    -  [为 kubectl 命令集生成参考文档](https://kubernetes.io/zh-cn/docs/contribute/generate-ref-docs/kubectl/)
    -  [为 Kubernetes 组件和工具生成参考文档](https://kubernetes.io/zh-cn/docs/contribute/generate-ref-docs/kubernetes-components/)
    - 

  -  

    [文档样式概述](https://kubernetes.io/zh-cn/docs/contribute/style/)

    -  [内容指南](https://kubernetes.io/zh-cn/docs/contribute/style/content-guide/)
    -  [样式指南](https://kubernetes.io/zh-cn/docs/contribute/style/style-guide/)
    -  [图表指南](https://kubernetes.io/zh-cn/docs/contribute/style/diagram-guide/)
    -  [撰写新主题](https://kubernetes.io/zh-cn/docs/contribute/style/write-new-topic/)
    -  [页面内容类型](https://kubernetes.io/zh-cn/docs/contribute/style/page-content-types/)
    -  [内容组织](https://kubernetes.io/zh-cn/docs/contribute/style/content-organization/)
    -  [定制 Hugo 短代码](https://kubernetes.io/zh-cn/docs/contribute/style/hugo-shortcodes/)

  -  [进阶贡献](https://kubernetes.io/zh-cn/docs/contribute/advanced/)

  -  [查看站点分析](https://kubernetes.io/zh-cn/docs/contribute/analytics/)

  -  [中文本地化样式指南](https://kubernetes.io/zh-cn/docs/contribute/localization_zh/)

-  [测试页面（中文版）](https://kubernetes.io/zh-cn/docs/test/)