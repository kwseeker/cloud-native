# 本地开发环境部署

后端本地开发测试，经常需要启动很多中间件或服务。这里为了后面迁移电脑方便，将常用的中间件的docker部署脚本汇总记录一下，后面重装系统后可以实现一键部署。

分为本地单机环境、本地伪集群环境。



## 本地单机环境

### 共享网络

所有中间件都是单节点部署，共享一个bridge网络。

```shell
# 首先创建桥接网络
docker network create --driver bridge --subnet 172.180.0.0/16 local-standalone
```

### 数据库

#### MySQL

+ MySQL-5.7.24

  ```shell
  # sa: standalone缩写
  docker run -d --name mysql-sa-57 \
  	-p 3306:3306 \
  	-e MYSQL_ROOT_PASSWORD=123456 \
  	--network local-standalone \
  	mysql:5.7.24
  ```

#### Redis



#### ElasticSearch

+ **ElasticSearch-8.1.0**

  ```shell
  docker run --name es-single \
  -e "discovery.type=single-node" \
  -e "cluster.routing.allocation.disk.watermark.low=97%" \
  -e "cluster.routing.allocation.disk.watermark.high=98%" \
  -e "cluster.routing.allocation.disk.watermark.flood_stage=99%" \
  -e "xpack.security.enabled=false" \
  -e "xpack.security.http.ssl:enabled=false" \
  -e ES_JAVA_OPTS="-Xms256m -Xmx1024m" \
  --network local-standalone \
  -d elasticsearch:8.1.0
  ```


#### ElasticHD

```shell
# ElasticHD, UI端口默认9800
docker run --name es-hd-single -p 9800:9800 --network local-standalone -d containerize/elastichd:latest
```

### 服务注册中心&配置中心

#### Nacos

#### Zookeeper

#### Consul

### 消息中间件

#### RocketMQ

### 路由追踪&监控

#### SkyWalking

```shell
# docker 启动 skywalking OAP
# docker run 不支持通过容器名称调用，docker-compose可以
docker run --name oap-server-single \
	-e TZ=Asia/Shanghai \
    -e SW_STORAGE=elasticsearch \
    -e SW_CORE_REST_PORT=12800 \
    -e SW_CORE_GRPC_PORT=11800 \
    -e SW_STORAGE_ES_CLUSTER_NODES=es-single:9200  \
    -e JAVA_OPTS="-Xms256m -Xmx1G " \
    --network local-standalone \
    -d apache/skywalking-oap-server:9.0.0
    
# skywalking GUI
docker run --name skywalking-ui-single \
	-p 28080:8080 \
	-e TZ=Asia/Shanghai \
	-e SW_OAP_ADDRESS=http://oap-server-single:12800 \
	--network local-standalone \
	-d apache/skywalking-ui:9.0.0    
```

## 本地伪集群环境

```shell
# 首先创建桥接网络
docker network create --driver bridge --subnet 172.190.0.0/16 local-cluster
```



