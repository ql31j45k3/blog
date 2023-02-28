# 搭建 BCH 節點

## 搭建 testnet 節點

### 建立目錄結構

```shell
mkdir -p /blockchain/bch/testnet/node
cd /blockchain/bch
```

### 安裝

```shell
# 解决 "/lib64/libc.so.6: version `GLIBC_2.18' not found

curl -O http://ftp.gnu.org/gnu/glibc/glibc-2.18.tar.gz
tar zxf glibc-2.18.tar.gz 
cd glibc-2.18/
mkdir build
cd build/
../configure --prefix=/usr
make -j2
make install
```

### 下載執行二進制和設定檔

```shell
wget https://github.com/bitcoin-cash-node/bitcoin-cash-node/releases/download/v26.0.0/bitcoin-cash-node-26.0.0-x86_64-linux-gnu.tar.gz
tar -zxvf bitcoin-cash-node-26.0.0-x86_64-linux-gnu.tar.gz
```

```shell
# 需改名，因跟 BTC 同名字

sudo cp /blockchain/bch/bitcoin-cash-node-26.0.0/bin/bitcoind /usr/bin/bch
sudo cp /blockchain/bch/bitcoin-cash-node-26.0.0/bin/bitcoin-cli /usr/bin/bch-cli
```

```shell
# 查看版號

bch -version
bch-cli -version
```

```shell
cd /blockchain/bch/testnet

wget https://docs.bitcoincashnode.org/share/examples/bitcoin.conf
```

```shell
vim bitcoin.conf

[test]
server=1
rest=1
rpcbind=0.0.0.0:18332
rpcallowip=0.0.0.0/0
rpcuser=user
rpcpassword=123456
```

### 啟動節點

```shell
cd /blockchain/bch/testnet

vim start.sh
```

```shell
#!/bin/bash
echo "Starting BCH testnet"
screen -dmS BCH_testnet bch \
           -testnet \
           -conf=/blockchain/bch/testnet/bitcoin.conf \
           -datadir=/blockchain/bch/testnet/node
```

```shell
chmod +x start.sh
./start.sh
```

### 停止節點

```shell
cd /blockchain/bch/testnet

vim stop.sh
```

```shell
#!/bin/bash
bch-cli -rpcport=18332 -rpcuser={rpcuser} -rpcpassword={rpcpassword} stop
```

```shell
chmod +x stop.sh
./stop.sh
```

```shell
# 強制刪除方案

ps -aux | grep bch
kill {jobs id}
```

### 查看節點區塊

```shell
bch-cli -rpcport=18332 -rpcuser={rpcuser} -rpcpassword={rpcpassword} getblockchaininfo

curl --user rd_user --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockchaininfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:18332/
```
