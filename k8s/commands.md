# K8S 指令



## kubectl

```shell
# shell 自动补全
yum install -y bash-completion 
source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc

kubectl -h

kubectl cluster-info
kubectl api-resources
kubectl config view

# 节点相关
kubectl get nodes
kubectl get nodes --show-labels
```

