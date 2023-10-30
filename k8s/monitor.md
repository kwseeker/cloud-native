# K8S 监控

## [部署和访问 Kubernetes 仪表板](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/web-ui-dashboard/)

```shell
wget https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml -O dashboard.yml
kubectl apply -f dashboard.yml
# 修改
vi dashboard.yml
#spec:
#  ports:
#    - port: 443
#      targetPort: 8443
#  selector:
#    k8s-app: kubernetes-dashboard
kubectl delete -f dashboard.yml
kubectl apply -f dashboard.yml
kubectl get pods -n kubernetes-dashboard
kubectl get pods,svc -n kubernetes-dashboard
# 临时修改 type: ClusterIP 为 type: NodePort
#kubectl -n kubernetes-dashboard edit service kubernetes-dashboard
# 通过下面两个命令分别获取ip和端口
#kubectl -n kubernetes-dashboard get service kubernetes-dashboard
kubectl get pods -A -o wide | grep kubernetes-dashboard
# 创建 JWT token, 这里用默认创建的用户
kubectl -n kubernetes-dashboard create token kubernetes-dashboard
```

recommended.yaml 创建了以下**资源**：

+ Namespace

  命名空间名：kubernetes-dashboard

+ ServiceAccount

  服务账户名：kubernetes-dashboard

+ Service

  服务名：kubernetes-dashboard

  ```yaml
  spec:
    ports:
      - port: 443
        targetPort: 8443
    selector:
      k8s-app: kubernetes-dashboard
  ```

+ Secret

  Secret 是一种包含少量敏感信息例如密码、令牌或密钥的对象。 这样的信息可能会被放在 [Pod](https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/) 规约中或者镜像中。 使用 Secret 意味着你不需要在应用程序代码中包含机密数据。

  这里创建了三个Opaque类型的Secret。

+ ConfigMap

+ Role

+ ClusterRole

+ RoleBinding

+ ClusterRoleBinding

+ Deployment

  镜像：kubernetesui/dashboard:v2.7.0

+ Service

  服务名：dashboard-metrics-scraper

+ Deployment

  镜像：kubernetesui/metrics-scraper:v1.0.8
