# 如何学 K8S

以程序执行的思维看K8S的文档。

1. 看K8S的软件架构

   主要看有什么组件，组件之间的关系。

   一个外部请求是怎么在K8S中各组件流转的。

2. 使用 kvm 创建虚拟机集群并搭建K8S平台

   最好是用Linux系统物理机，虚拟机用 kvm 创建，像什么VMWare、VirtualBox之流的太消耗资源了，最早学习K8S时用的VirtualBox创建的虚拟机集群，部署K8S之后部署应用，内存占用非常高。

3. 使用别人写好的微服务项目在K8S上部署

   学K8S使用主要就是学K8S中一堆K8S对象的配置，这些对象对应K8S源码中的 golang 对象。

   最好有 golang 基础，文档不一定会将所有对象的所有字段都讲全。最好是文档和源码注释配合着看。

   如果想深入学习还是需要看K8S源码。

4. 自己独立写配置文件在K8S上部署

5. 使用K8S接口开发K8S拓展组件