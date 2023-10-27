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
  
  > mysql -h127.0.0.1 -uroot -P3306 --ssl-mode=DISABLED -p
  >
  > 新版本mysql客户端命令默认启用SSL协议，如果要关闭的话需要传参数`--ssl-mode=DISABLED`。
  >
  > 另外注意当`-h`选项填写为localhost时，可能会报`ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)`，原因其实是**因为这个服务端UDS Socket文件不存在，因为我本地只装了MySQL客户端，没有装mysql-server (Docker安装的)**，所以当然不会有这个文件；当主机填写为127.0.0.1时mysql会采用TCP方式连接（连接正常）, TCP的socket文件由proc虚拟文件系统管理。
  >
  > 很多相同配置 Window 上可以运行但是 Linux 异常大多都是权限问题。
  >
  >  Unix Domain Socket 创建 `int fd = socket(AF_UNIX, SOCKET_STREAM, 0);`
  >
  > 关于Unix Domain Socket原理：[本机网络 IO 之 Unix Domain Socket 性能分析](https://zhuanlan.zhihu.com/p/448373622)

#### Redis

+ Redis-6.2.13

  ```shell
  docker run -d --name redis-single \
  	-p 6379:6379 \
  	redis:6.2.13 redis-server --save 60 1 --loglevel warning
  ```

#### ElasticSearch

+ **ElasticSearch-8.1.0**

  ```shell
  # 访问：http://127.0.0.1:9200/ 返回节点信息json则启动成功
  # 9200：客户端请求处理端口，9300： ES集群节点通信端口
  docker run --name es-single \
  	-p 9200:9200 \
  	-e "discovery.type=single-node" \
  	-e "cluster.routing.allocation.disk.watermark.low=97%" \
  	-e "cluster.routing.allocation.disk.watermark.high=98%" \
  	-e "cluster.routing.allocation.disk.watermark.flood_stage=99%" \
  	-e "xpack.security.enabled=false" \
  	-e "xpack.security.http.ssl:enabled=false" \
  	-e ES_JAVA_OPTS="-Xms256m -Xmx1024m" \
  	-v /home/lee/docker/es-single/data:/usr/share/elasticsearch/data \
  	-v /home/lee/docker/es-single/plugins:/usr/share/elasticsearch/plugins \
  	--network local-standalone \
  	-d elasticsearch:8.1.0
  # 然后需要安装中文分词插件，支持中文搜索, https://github.com/medcl/elasticsearch-analysis-ik/releases, 选择和ES同版本的(版本必须严格一致)
  # 下载后解压到 plugins/ik/ 目录下，重启容器， 然后检查下效果
  # ik_max_word ：IK 最大化分词，会将文本做最细粒度的拆分
  curl -X POST http://localhost:9200/_analyze \
    -H 'content-type: application/json' \
    -d '{
          "analyzer": "ik_max_word",
          "text": "百事可乐"
  }'
  # ik_smart ：IK 智能分词，会做最粗粒度的拆分
  curl -X POST http://localhost:9200/_analyze \
    -H 'content-type: application/json' \
    -d '{
          "analyzer": "ik_smart",
          "text": "百事可乐"
  }'
  ```

+ **ElasticSearch-7.17.6**

  ```shell
  # 访问：http://127.0.0.1:9201/ 返回节点信息json则启动成功
  docker run --name es-7-single \
  	-p 9201:9200 \
  	-e "discovery.type=single-node" \
  	-e "cluster.routing.allocation.disk.watermark.low=97%" \
  	-e "cluster.routing.allocation.disk.watermark.high=98%" \
  	-e "cluster.routing.allocation.disk.watermark.flood_stage=99%" \
  	-e "xpack.security.enabled=false" \
  	-e "xpack.security.http.ssl:enabled=false" \
  	-e ES_JAVA_OPTS="-Xms256m -Xmx1024m" \
  	-v /home/lee/docker/es-7-single/data:/usr/share/elasticsearch/data \
  	-v /home/lee/docker/es-7-single/plugins:/usr/share/elasticsearch/plugins \
  	--network local-standalone \
  	-d elasticsearch:7.17.6
  ```

#### ElasticHD

```shell
# ElasticHD, UI端口默认9800
docker run --name es-hd-single -p 9800:9800 --network local-standalone -d containerize/elastichd:latest
```

#### Kibana

+ **Kibana-8.1.0**

  ```shell
  docker run --name kibana-8-single \
  	-e ELASTICSEARCH_HOSTS="http://es-single:9200" \
  	--network local-standalone \
  	-p 5601:5601 \
  	-d kibana:8.1.0
  ```

+ **Kibana-7.17.6**

  ```shell
  # 注意这个版本配置es ip端口的环境变量是 ELASTICSEARCH_HOSTS，不同版本这个环境变量可能不同
  # 查对应版本的官方文档最靠谱：https://www.elastic.co/guide/en/kibana/7.17/docker.html
  docker run --name kibana-7-single \
  	-e ELASTICSEARCH_HOSTS="http://es-7-single:9200" \
  	--network local-standalone \
  	-p 5602:5601 \
  	-d kibana:7.17.6
  ```

### 服务注册中心&配置中心

#### Nacos

+ nacos-server:2.0.2

    ```shell
    # http://127.0.0.1:8848/nacos/ 用户名/密码：nacos/nacos
    # https://hub.docker.com/r/nacos/nacos-server
    # 9848是RPC端口
    docker run --name nacos-single \
        -e MODE=standalone \
        -e MYSQL_SERVICE_HOST=mysql-sa-57 \
        -e MYSQL_SERVICE_PORT=3306 \
        -e MYSQL_SERVICE_USER=root \
        -e MYSQL_SERVICE_PASSWORD=123456 \
        -e MYSQL_SERVICE_DB_NAME=nacos \
        -e JVM_XMS=256m \
    	-e JVM_XMX=512m \
        -p 8848:8848 \
        -p 9848:9848 \
        -d nacos/nacos-server:2.0.2
    ```

#### Zookeeper

#### Consul

### 消息中间件

#### RocketMQ

这里使用官方镜像部署，之前使用非官方景象部署的脚本参考：https://github.com/kwseeker/message-queue/blob/master/deploy/rocketmq/docker-compose-simple.yml

+ rocketmq-4.9.7

  ```shell
  # namesrv
  docker run --name rmq-namesrv-single \
      -e JAVA_OPT_EXT="-server -Xms128m -Xmx512m" \
      -p 9876:9876 \
      -d apache/rocketmq:4.9.7 \
      sh mqnamesrv
  # broker
  docker run --name rmq-broker-single \
  	-e JAVA_OPT_EXT="-server -Xms128m -Xmx512m" \
  	-e NAMESRV_ADDR="rmq-namesrv-single:9876" \
      -p 10909:10909 \
      -p 10911:10911 \
      -p 10912:10912 \
      -d apache/rocketmq:4.9.7 \
      sh mqbroker -c /home/rocketmq/rocketmq-4.9.7/conf/broker.conf
  ```

+ rocketmq-dashboard:1.0.0

  ```shell
  # http://localhost:28081/
  docker run --name rmq-dashboard-single \
      -e JAVA_OPTS="-Drocketmq.namesrv.addr=rmq-namesrv-single:9876" \
      -p 28081:8080 \
      -d apacherocketmq/rocketmq-dashboard:1.0.0
  # 填容器名报错
  # [2023-08-09 06:44:47.987]  WARN validate object ClientConfig [namesrvAddr=rmq-namesrv-single:9876, clientIP=172.17.0.6, instanceName=1691563470002, clientCallbackExecutorThreads=8, pollNameServerInterval=30000, heartbeatBrokerInterval=30000, persistConsumerOffsetInterval=5000, pullTimeDelayMillsWhenException=1000, unitMode=false, unitName=null, vipChannelEnabled=true, useTLS=false, language=JAVA, namespace=null] err
  # org.apache.rocketmq.remoting.exception.RemotingConnectException: connect to [rmq-namesrv-single:9876] failed
  # 	at org.apache.rocketmq.remoting.netty.NettyRemotingClient.getAndCreateNameserverChannel(NettyRemotingClient.java:445)
      
  # Docker容器内部嵌入了一个DNS服务用于将容器名转成IP
  # 原因：内嵌DNS服务（估计是DNS协议）工作在应用层协议，但是NettyRemotingClient建立的TCP连接，走不到DNS服务。
      
  # 换成IP是可以的，但是使用IP不优雅(改用--link,虽然这个参数官方不推荐使用但是暂没啥好方法)
  docker run --name rmq-dashboard-single \
      -e JAVA_OPTS="-Drocketmq.namesrv.addr=rmq-namesrv-single:9876" \
      -p 28081:8080 \
      --link rmq-namesrv-single \
      -d apacherocketmq/rocketmq-dashboard:1.0.0
  # 为何 --link 可以，因为当使用--link选项时，Docker会在目标容器的环境变量中注入一些与连接相关的值。其中一个环境变量是<别名>_PORT_<端口>_<协议>，通过该环境变量，你可以获取目标容器的IP地址和端口信息。TODO: 这里的细节后面有空研究
  # 进入容器内部可以查看到下面环境变量
  root@110148dc2aab:/# env | grep PORT
  RMQ_NAMESRV_SINGLE_PORT_10911_TCP_PORT=10911
  RMQ_NAMESRV_SINGLE_PORT_10911_TCP_PROTO=tcp
  RMQ_NAMESRV_SINGLE_PORT=tcp://172.17.0.4:9876
  RMQ_NAMESRV_SINGLE_PORT_10909_TCP_PORT=10909
  RMQ_NAMESRV_SINGLE_PORT_10909_TCP_PROTO=tcp
  RMQ_NAMESRV_SINGLE_PORT_9876_TCP_ADDR=172.17.0.4
  RMQ_NAMESRV_SINGLE_PORT_10912_TCP=tcp://172.17.0.4:10912
  RMQ_NAMESRV_SINGLE_PORT_9876_TCP=tcp://172.17.0.4:9876
  RMQ_NAMESRV_SINGLE_PORT_10912_TCP_PORT=10912
  RMQ_NAMESRV_SINGLE_PORT_10912_TCP_PROTO=tcp
  RMQ_NAMESRV_SINGLE_PORT_9876_TCP_PORT=9876
  RMQ_NAMESRV_SINGLE_PORT_10911_TCP=tcp://172.17.0.4:10911
  RMQ_NAMESRV_SINGLE_PORT_10909_TCP_ADDR=172.17.0.4
  RMQ_NAMESRV_SINGLE_PORT_9876_TCP_PROTO=tcp
  RMQ_NAMESRV_SINGLE_PORT_10909_TCP=tcp://172.17.0.4:10909
  RMQ_NAMESRV_SINGLE_PORT_10912_TCP_ADDR=172.17.0.4
  RMQ_NAMESRV_SINGLE_PORT_10911_TCP_ADDR=172.17.0.4
  ```

### 路由追踪&监控

#### SkyWalking

```shell
# docker 启动 skywalking OAP
# docker run 不支持通过容器名称调用，docker-compose可以
docker run --name oap-server-single \
	-p 12800:12800 \
	-p 11800:11800 \
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

### 降级限流熔断

#### Sentinel

+ sentinel-dashboard:1.8.6

  ```shell
  docker run --name sentinel-dashboard-single \
      -p 28082:8080 \
      -d kwseeker/sentinel-dashboard:1.8.6
  ```

### Docker Compose 整合 

### K8S 整合



## 本地伪集群环境

```shell
# 首先创建桥接网络
docker network create --driver bridge --subnet 172.190.0.0/16 local-cluster
```

### Docker Compose 整合

### K8S 整合

