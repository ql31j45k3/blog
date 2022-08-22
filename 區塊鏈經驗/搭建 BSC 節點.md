# 搭建 BSC 節點

- [BSC releases](https://github.com/binance-chain/bsc/releases)
- [BSC snapshots](https://github.com/bnb-chain/bsc-snapshots)

## 搭建 BSC mainnet 節點

### 建立目錄結構

```shell
mkdir -p /blockchain/bsc/mainnet
cd /blockchain/bsc/mainnet

mkdir -p node/geth
```

### 下載執行二進制和設定檔

```shell
cd /blockchain/bsc
```

```shell
wget https://github.com/bnb-chain/bsc/releases/download/v1.1.12/geth_linux
chmod +x geth_linux
```

```shell
cp ./geth_linux ./mainnet
```

```shell
cd /blockchain/bsc/mainnet
```

```shell
wget https://github.com/bnb-chain/bsc/releases/download/v1.1.12/mainnet.zip
unzip mainnet.zip
```

```shell
cd mainnet
vim config.toml

HTTPHost = "0.0.0.0"
HTTPPort = 8576
```

### 下載快照資料

```shell
cd /blockchain/bsc/mainnet
mkdir snapshot

cd snapshot
```

```shell
## 大約半天

screen -S bsc-snapshots wget -O geth.tar.lz4 "https://download.bsc-snapshot.workers.dev/geth-20220820.tar.lz4"
```

```shell
## 執行解壓縮工作，大約一小時

screen -S unTar tar -I lz4 -xvf geth.tar.lz4
```

```shell
## 搬移快照資料，到節點目錄

mv server/data-seed/geth/chaindata ../node/geth/chaindata
mv server/data-seed/geth/triecache ../node/geth/triecache
```

### 啟動節點

```shell
cd /blockchain/bsc/mainnet
```

```shell
vim start.sh
```

```shell
#!/bin/bash
echo "BSC mainnet"
screen -dmS BSC_mainnet ./geth_linux \
            --config ./mainnet/config.toml \
            --datadir ./node \
            --syncmode full \
            --gcmode archive \
            --cache 1024 \
            --diffsync \
            --rpc.allow-unprotected-txs \
            --txlookuplimit 0
```

```shell
chmod +x start.sh
./start.sh
```

## 搭建 BSC testnet 節點

### 建立目錄結構

```shell
mkdir -p /blockchain/bsc/testnet
cd /blockchain/bsc/testnet

mkdir -p node
```

### 下載執行二進制和設定檔

```shell
cd /blockchain/bsc
```

```shell
wget https://github.com/bnb-chain/bsc/releases/download/v1.1.12/geth_linux
chmod +x geth_linux
```

```shell
cp ./geth_linux ./testnet
```

```shell
cd /blockchain/bsc/testnet
```

```shell
wget https://github.com/bnb-chain/bsc/releases/download/v1.1.12/testnet.zip
unzip testnet.zip
```

```shell
cd testnet
vim config.toml

HTTPHost = "0.0.0.0"
HTTPPort = 7576
```

### 寫入創世狀態

```shell
cd /blockchain/bsc/testnet
```

```shell
./geth_linux --datadir node init ./testnet/genesis.json
```

### 啟動節點

```shell
cd /blockchain/bsc/testnet
```

```shell
vim start.sh
```

```shell
#!/bin/bash
echo "BSC testnet"
screen -dmS BSC_testnet ./geth_linux \
            --config ./testnet/config.toml \
            --datadir ./node \
            --syncmode full \
            --gcmode archive \
            --cache 1024 \
            --diffsync \
            --rpc.allow-unprotected-txs \
            --txlookuplimit 0
```

```shell
chmod +x start.sh
./start.sh
```
