# 搭建 ETH 節點

- [ETH releases](https://geth.ethereum.org/downloads/)
- [prysm releases](https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh)
- [prysm genesis.ssz](https://github.com/eth-clients/eth2-networks/raw/master/shared/prater/genesis.ssz)

## 搭建 ETH goerli testnet 節點

### 建立目錄結構

```shell
mkdir -p /blockchain/eth/testnet
cd /blockchain/eth/testnet

mkdir -p node
mkdir -p node_prysm
```

### 下載執行二進制

```shell
cd /blockchain/eth
```

```shell
wget https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.11.2-73b01f40.tar.gz
tar xvfz geth-linux-amd64-1.11.2-73b01f40.tar.gz
```

```shell
cp ./geth-linux-amd64-1.11.2-73b01f40.tar.gz/geth ./testnet
```

```shell
cd /blockchain/eth/testnet

wget https://github.com/eth-clients/eth2-networks/raw/master/shared/prater/genesis.ssz

curl https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh --output prysm.sh && chmod +x prysm.sh
```

### 啟動節點

```shell
cd /blockchain/eth/testnet
```

```shell
# 生成 JWT 認證
./prysm.sh beacon-chain generate-auth-secret
```

```shell
# 啟動 信標節點
vim start_prysm.sh
```

```shell
#!/bin/bash
echo "prysm testnet prater"
screen -dmS prysm ./prysm.sh beacon-chain \
           --execution-endpoint=http://localhost:8551 \
           --jwt-secret=./jwt.hex \
           --genesis-state=./genesis.ssz \
           --suggested-fee-recipient=0x01234567722E6b0000012BFEBf6177F1D2e9758D9 \
           --datadir ./node_prysm \
           --prater
```

```shell
chmod +x start_prysm.sh
./start_prysm.sh
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
            --http.port 8545 \
            --http.api eth,net,engine,admin \
            --authrpc.jwtsecret ./jwt.hex \
            --authrpc.addr localhost \
            --authrpc.port 8551 \
            --authrpc.vhosts localhost \
            --allow-insecure-unlock
```

```shell
chmod +x start.sh
./start.sh
```

### 查看同步

```shell
# 信標節點
curl http://localhost:3500/eth/v1alpha1/node/syncing
```

```shell
# geth
curl -H "Content-Type: application/json" -X POST --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' http://localhost:8545

./geth attach http://127.0.0.1:8545
eth.syncing
eth.blockNumber
```
