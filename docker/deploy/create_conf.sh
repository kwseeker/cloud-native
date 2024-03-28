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
