# Dockerfile Reference 补充

对官方文档 https://docs.docker.com/ 未解释或未找到的一些问题的补充。



## 基础镜像的选择

可选基础镜像（从上到下越来越基础）：

+ 服务类官方镜像（nginx、redis、mongo、mysql 等）
+ 编程语言镜像（openjdk、python、golang 等）
+ 基础操作系统镜像（ubuntu、centos 等）
+ 空白镜像 （scratch）

参考：

+ [基础镜像的选择](https://dockertips.readthedocs.io/en/latest/dockerfile-guide/base-image.html)
+ [Choosing a Base Image For Your Dockerfile](https://vsupalov.com/choose-base-image/)
+ [对Docker基础镜像的思考，该不该选择alpine](https://cloud.tencent.com/developer/article/2168079)

