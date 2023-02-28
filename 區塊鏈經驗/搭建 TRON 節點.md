# 搭建 TRON 節點

- [releases](https://github.com/tronprotocol/java-tron/releases/tag/GreatVoyage-v4.7.0.1)
- [deployment](https://github.com/tronprotocol/tron-deployment)

## 搭建 testnet 節點

### 建立目錄結構

```shell
mkdir -p /blockchain/tron/testnet/FullNode
```

### 安裝

```shell
# 安裝 git
yum install git
```

```shell
# 安裝 Oracle JDK 1.8
cd /blockchain/tron

wget https://repo.huaweicloud.com/java/jdk/8u202-b08/jdk-8u202-linux-x64.tar.gz

tar -zxvf jdk-8u202-linux-x64.tar.gz
```

```shell
vi /etc/profile

export JAVA_HOME=/blockchain/tro/jdk1.8.0_202
export PATH=$PATH:${JAVA_HOME}/bin

source /etc/profile

java -version
```

### 下載執行二進制和設定檔

```shell
cd /blockchain/tron

git clone https://github.com/tronprotocol/tron-deployment

cp tron-deployment/test_net_config.conf /blockchain/tron/testnet/FullNode
```

```shell
cd /blockchain/tron/testnet/FullNode

wget https://github.com/tronprotocol/java-tron/releases/download/GreatVoyage-v4.7.0.1/FullNode.jar
```

### 啟動節點

```shell
cd /blockchain/tron/testnet/FullNode

vim start.sh
```

```shell
#!/bin/bash
echo "Starting private TRON testnet"
nohup java -Xmx24g -XX:+HeapDumpOnOutOfMemoryError -jar FullNode.jar  -c /blockchain/tron/testnet/FullNode/test_net_config.conf  >> start.log 2>&1 &
```

```shell
chmod +x start.sh
./start.sh
```

### 停止節點

```shell
ps aux | grep FullNode
kill {jobs id}
```

### 查看節點區塊

```shell
curl -X GET  http://127.0.0.1:8091/walletsolidity/getnowblock
```
