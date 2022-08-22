# 搭建 ETH 節點

- [ETH releases](https://geth.ethereum.org/downloads/)

## 搭建 ETH goerli testnet 節點

### 建立目錄結構

```shell
mkdir -p /blockchain/eth/testnet
cd /blockchain/eth/testnet

mkdir -p node
```

### 下載執行二進制

```shell
cd /blockchain/eth
```

```shell
wget https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.10.20-8f2416a8.tar.gz
tar xvfz geth-linux-amd64-1.10.20-8f2416a8.tar.gz
```

```shell
cp ./geth-linux-amd64-1.10.20-8f2416a8/geth ./testnet
```

### 啟動節點

```shell
cd /blockchain/eth/testnet
```

```shell
vim start.sh
```

```shell
#!/bin/bash
echo "ETH testnet goerli"
screen -dmS ETH_testnet ./geth \
            --goerli \
            --datadir ./node \
            --syncmode full \
            --gcmode archive \
            --cache 1024 \
            --http \
            --http.addr 0.0.0.0 \
            --http.port 8545
```

```shell
chmod +x start.sh
./start.sh
```
