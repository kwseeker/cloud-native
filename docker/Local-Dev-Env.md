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
  	-v /home/arvin/docker/mysql-sa-57/conf/my.cnf:/etc/mysql/my.cnf \
  	-v /home/arvin/docker/mysql-sa-57/data:/var/lib/mysql
  	-e MYSQL_ROOT_PASSWORD=123456 \
  	--network local-standalone \
  	mysql:5.7.24
  ```
  
  配置文件 my.cnf
  
  ```properties
  [mysqld]
  # 打开binlog
  log-bin=mysql-bin
  binlog-format=ROW
  server_id=1
  
  !includedir /etc/mysql/conf.d/
  !includedir /etc/mysql/mysql.conf.d/
  ```
  
  > mysql -h127.0.0.1 -uroot -P3306 --ssl-mode=DISABLED -p
  >
  > 新版本mysql客户端命令默认启用SSL协议，如果要关闭的话需要传参数`--ssl-mode=DISABLED`。
  >
  > 另外注意当`-h`选项填写为localhost时，可能会报`ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)`，原因其实是**因为这个服务端UDS Socket文件不存在，因为我本地只装了MySQL客户端，没有装mysql-server (Docker安装的)**，所以当然不会有这个文件；当主机填写为127.0.0.1时mysql会采用TCP方式连接（连接正常）, TCP的socket文件由proc虚拟文件系统管理。
  >
  > 很多相同配置 Window 上可以运行但是 Linux 异常大多都是权限问题。
  >
  > Unix Domain Socket 创建 `int fd = socket(AF_UNIX, SOCKET_STREAM, 0);`
  >
  > 关于Unix Domain Socket原理：[本机网络 IO 之 Unix Domain Socket 性能分析](https://zhuanlan.zhihu.com/p/448373622)

#### Canal

+ Canal-Server-v1.1.7

  ```shell
  docker run -d --name canal-sa \
  	-p 11111:11111 \
  	-v /home/arvin/docker/canal-sa/conf/canal.properties:/home/admin/canal-server/conf/canal.properties \
  	-v /home/arvin/docker/canal-sa/conf/apipe/instance.properties:/home/admin/canal-server/conf/apipe/instance.properties \
  	--network local-standalone \
  	canal/canal-server:v1.1.7
  ```

  配置文件：

   canal.properties：

  ```properties
  # tcp bind ip
  # 本机有多个IP（Docker虚拟IP）配置127.0.0.1发现还是会设置为查找到的第一个IP地址
  canal.ip = 192.168.2.169
  # ...
  # 当前server上部署的instance列表,instance是一个读取管道，管道名自定义
  canal.destinations = apipe
  # ...
  ```

  apipe/instance.properties：

  ```properties
  #################################################
  ## mysql serverId , v1.0.26+ will autoGen
  # canal.instance.mysql.slaveId=0
  
  # enable gtid use true/false
  canal.instance.gtidon=false
  
  # position info
  # mysql-sa-57的ip是172.180.0.2
  canal.instance.master.address=172.180.0.2:3306
  # 设置从哪个binlog文件开始读取，通过 show master status 设置最新的值
  canal.instance.master.journal.name=mysql-bin.000001
  # 设置从哪个位置开始读取，通过 show master status 设置最新的值
  canal.instance.master.position=154
  canal.instance.master.timestamp=
  canal.instance.master.gtid=
  
  # rds oss binlog
  canal.instance.rds.accesskey=
  canal.instance.rds.secretkey=
  canal.instance.rds.instanceId=
  
  # table meta tsdb info
  canal.instance.tsdb.enable=true
  #canal.instance.tsdb.url=jdbc:mysql://127.0.0.1:3306/canal_tsdb
  #canal.instance.tsdb.dbUsername=canal
  #canal.instance.tsdb.dbPassword=canal
  
  #canal.instance.standby.address =
  #canal.instance.standby.journal.name =
  #canal.instance.standby.position =
  #canal.instance.standby.timestamp =
  #canal.instance.standby.gtid=
  
  # username/password
  canal.instance.dbUsername=root
  canal.instance.dbPassword=123456
  canal.instance.connectionCharset = UTF-8
  # enable druid Decrypt database password
  canal.instance.enableDruid=false
  #canal.instance.pwdPublicKey=MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBALK4BUxdDltRRE5/zXpVEVPUgunvscYFtEip3pmLlhrWpacX7y7GCMo2/JM6LeHmiiNdH1FWgGCpUfircSwlWKUCAwEAAQ==
  
  # table regex
  # 这里匹配所有数据库表, 会被客户端连接中的配置覆盖
  canal.instance.filter.regex=.*\\..*
  # table black regex
  canal.instance.filter.black.regex=mysql\\.slave_.*
  # table field filter(format: schema1.tableName1:field1/field2,schema2.tableName2:field1/field2)
  #canal.instance.filter.field=test1.t_product:id/subject/keywords,test2.t_company:id/name/contact/ch
  # table field black filter(format: schema1.tableName1:field1/field2,schema2.tableName2:field1/field2)
  #canal.instance.filter.black.field=test1.t_product:subject/product_image,test2.t_company:id/name/contact/ch
  
  # mq config
  canal.mq.topic=example
  # dynamic topic route by schema or table regex
  #canal.mq.dynamicTopic=mytest1.user,topic2:mytest2\\..*,.*\\..*
  canal.mq.partition=0
  # hash partition config
  #canal.mq.enableDynamicQueuePartition=false
  #canal.mq.partitionsNum=3
  #canal.mq.dynamicTopicPartitionNum=test.*:4,mycanal:6
  #canal.mq.partitionHash=test.table:id^name,.*\\..*
  #################################################
  ```

  配置详解：网上很多，比如 [canal的配置详解](https://blog.51cto.com/u_15278282/3021436)。

  > 配置的坑：
  >
  > + 如果本机存在多个IP（比如创建了多个Docker虚拟网络），canal-server 和canal 客户端不能配置绑定IP地址为 `127.0.0.1`，这个IP会被认定为无效IP，然后会从IP列表选择第一个IP并绑定，很容易导致连接失败。
  >
  >   这个坑已经在好几个中间件中碰到了。
  >
  > + 实例日志一直报错：caused by com.alibaba.otter.canal.parse.exception.CanalParseException: java.io.IOException: ErrorPacket [errorNumber=1146, fieldCount=-1, message=Table 'activiti.BASE TABLE' doesn't exist, sqlState=42S02, sqlStateMarker=#]
  >
  >   但是直接使用1.1.6版本的jar包本地部署没有报错，更新使用 1.1.7版本的docker容器也正常，估计1.1.6版本的docker镜像使用的有bug的1.1.6版本做的镜像。
  >
  >   参考：[#4291](https://github.com/alibaba/canal/issues/4291)

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

### 数据库

#### Redis Cluster

创建配置文件：

```shell
for port in $(seq 1 6); \
do \
mkdir -p ./node-${port}/conf
touch ./node-${port}/conf/redis.conf
cat << EOF > ./node-${port}/conf/redis.conf
port 6379
bind 0.0.0.0
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
cluster-announce-ip 172.190.0.1${port}
cluster-announce-port 6379
cluster-announce-bus-port 16379
appendonly yes
EOF
done
```

docker-compose文件：

```yml
version: "2.1"

services:

  rc-meet:
    image: redis:latest
    command: redis-cli -h 172.190.0.11 -p 6379 --cluster create 172.190.0.11:6379 172.190.0.12:6379 172.190.0.13:6379 172.190.0.14:6379 172.190.0.15:6379 172.190.0.16:6379 --cluster-replicas 1 --cluster-yes
    depends_on:
      - rc-node-1
      - rc-node-2
      - rc-node-3
      - rc-node-4
      - rc-node-5
      - rc-node-6
    networks:
      local-cluster:
        ipv4_address: 172.190.0.10

  rc-node-1:
    container_name: rc-node-1
    image: redis:5.0.9-alpine3.11
    ports:
      - "26379:6379"
    volumes:
      - ./node-1/data:/data
      - ./node-1/conf/redis.conf:/etc/redis/redis.conf
    command: redis-server /etc/redis/redis.conf
    networks:
      local-cluster:
        ipv4_address: 172.190.0.11

  rc-node-2:
    container_name: rc-node-2
    image: redis:5.0.9-alpine3.11
    ports:
      - "26380:6379"
    volumes:
      - ./node-2/data:/data
      - ./node-2/conf/redis.conf:/etc/redis/redis.conf
    command: redis-server /etc/redis/redis.conf
    networks:
      local-cluster:
        ipv4_address: 172.190.0.12

  rc-node-3:
    container_name: rc-node-3
    image: redis:5.0.9-alpine3.11
    ports:
      - "26381:6379"
    volumes:
      - ./node-3/data:/data
      - ./node-3/conf/redis.conf:/etc/redis/redis.conf
    command: redis-server /etc/redis/redis.conf
    networks:
      local-cluster:
        ipv4_address: 172.190.0.13

  rc-node-4:
    container_name: rc-node-4
    image: redis:5.0.9-alpine3.11
    ports:
      - "26382:6379"
    volumes:
      - ./node-4/data:/data
      - ./node-4/conf/redis.conf:/etc/redis/redis.conf
    command: redis-server /etc/redis/redis.conf
    networks:
      local-cluster:
        ipv4_address: 172.190.0.14

  rc-node-5:
    container_name: rc-node-5
    image: redis:5.0.9-alpine3.11
    ports:
      - "26383:6379"
    volumes:
      - ./node-5/data:/data
      - ./node-5/conf/redis.conf:/etc/redis/redis.conf
    command: redis-server /etc/redis/redis.conf
    networks:
      local-cluster:
        ipv4_address: 172.190.0.15

  rc-node-6:
    container_name: rc-node-6
    image: redis:5.0.9-alpine3.11
    ports:
      - "26384:6379"
    volumes:
      - ./node-6/data:/data
      - ./node-6/conf/redis.conf:/etc/redis/redis.conf
    command: redis-server /etc/redis/redis.conf
    networks:
      local-cluster:
        ipv4_address: 172.190.0.16

networks:
  local-cluster:
    external: true
```

测试：

```shell
redis-cli -c -p 26379
127.0.0.1:26379> set name Arvin
-> Redirected to slot [5798] located at 172.190.0.12:6379
OK
172.190.0.12:6379> get name
"Arvin"
172.190.0.12:6379> cluster info
cluster_state:ok
cluster_slots_assigned:16384
cluster_slots_ok:16384
cluster_slots_pfail:0
cluster_slots_fail:0
cluster_known_nodes:6
cluster_size:3
cluster_current_epoch:6
cluster_my_epoch:2
cluster_stats_messages_ping_sent:1162
cluster_stats_messages_pong_sent:1167
cluster_stats_messages_meet_sent:5
cluster_stats_messages_sent:2334
cluster_stats_messages_ping_received:1167
cluster_stats_messages_pong_received:1167
cluster_stats_messages_received:2334
172.190.0.12:6379> cluster nodes
17152f3322200368feea9ab1fcac25ee9e1ab963 172.190.0.12:6379@16379 myself,master - 0 1711610322000 2 connected 5461-10922
bbf8e70f9ded847ec19a469d9c2afb8c945b5a83 172.190.0.14:6379@16379 slave 14dbd767e469c96a97b3d69896e470f4c656f798 0 1711610323530 4 connected
14dbd767e469c96a97b3d69896e470f4c656f798 172.190.0.13:6379@16379 master - 0 1711610323430 3 connected 10923-16383
d25f8138246a25419f4bf71b77cd36ff2eb7bead 172.190.0.15:6379@16379 slave 2e14362fa92078a09f7684ff8c9e9b905a45d8b2 0 1711610322427 5 connected
2e14362fa92078a09f7684ff8c9e9b905a45d8b2 172.190.0.11:6379@16379 master - 0 1711610322000 1 connected 0-5460
bc6523cac447afb6dbeade68c17081546ad0b3e4 172.190.0.16:6379@16379 slave 17152f3322200368feea9ab1fcac25ee9e1ab963 0 1711610322927 6 connected
```

### Docker Compose 整合

### K8S 整合

