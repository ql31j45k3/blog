# 搭建 XMR 節點

- [XMR releases](https://github.com/monero-project/monero/releases)

## 搭建 XMR testnet 節點

### 建立目錄結構

```shell
mkdir -p /blockchain/xmr/testnet/monerod
cd /blockchain/xmr/testnet/monerod

mkdir -p data
```

### 下載執行二進制和設定檔

```shell
cd /blockchain/xmr
```

```shell
wget https://downloads.getmonero.org/cli/monero-linux-x64-v0.17.3.2.tar.bz2
tar jxvf monero-linux-x64-v0.17.3.2.tar.bz2
```

```shell
cp ./monero-x86_64-linux-gnu-v0.17.3.2/monerod ./testnet/monerod
```

```shell
cd /blockchain/xmr/testnet/monerod
vim monerod.conf

log-file=./monerod.log
log-level=0
rpc-bind-ip=0.0.0.0
rpc-bind-port=28081
data-dir=./data
```

### 啟動節點

```shell
cd /blockchain/xmr/testnet/monerod
```

```shell
vim start.sh
```

```shell
#!/bin/bash
echo "XMR testnet"
screen -dmS XMR_testnet ./monerod \
            --testnet \
            --config-file ./monerod.conf \
            --non-interactive \
            --confirm-external-bind
```

```shell
chmod +x start.sh
./start.sh
```

## 搭建 XMR testnet wallet 節點

### 建立目錄結構

```shell
mkdir -p /blockchain/xmr/testnet/wallet
cd /blockchain/xmr/testnet/wallet

mkdir -p wallet_list
```

### 下載執行二進制和設定檔

```shell
cd /blockchain/xmr
```

```shell
wget https://downloads.getmonero.org/cli/monero-linux-x64-v0.17.3.2.tar.bz2
tar jxvf monero-linux-x64-v0.17.3.2.tar.bz2
```

```shell
cp ./monero-x86_64-linux-gnu-v0.17.3.2/monero-wallet-rpc ./testnet/wallet
```

```shell
cd /blockchain/xmr/testnet/wallet
vim monero_wallet_rpc.conf

log-file=./monero_wallet_rpc.log
log-level=0
rpc-bind-ip=0.0.0.0
rpc-bind-port=28088
daemon-address=127.0.0.1:28081
wallet-dir=./wallet_list/
```

### 啟動 wallet 節點

```shell
cd /blockchain/xmr/testnet/wallet
```

```shell
vim start.sh
```

```shell
#!/bin/bash
echo "XMR wallet testnet"
screen -dmS XMR_wallet_testnet ./monero-wallet-rpc \
            --testnet \
            --config-file ./monero_wallet_rpc.conf \
            --non-interactive \
            --confirm-external-bind \
            --trusted-daemon \
            --disable-rpc-login
```

```shell
chmod +x start.sh
./start.sh
```
