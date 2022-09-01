# 搭建 NEO (N3) 節點

- [NEO releases](https://github.com/neo-project/neo-node/releases)
- [NEO 快照數據](https://sync.ngd.network/)

## 搭建 NEO (N3) testnet 節點

### 建立目錄結構

```shell
mkdir -p /blockchain/neo/testnet
cd /blockchain/neo/testnet
```

### 下載執行二進制

```shell
cd /blockchain/neo
```

```shell
wget https://github.com/neo-project/neo-node/releases/download/v3.4.0/neo-cli-linux-x64.zip
unzip neo-cli-linux-x64.zip
```

```shell
mv neo-cli testnet/
```

### 下載快照數據

```shell
cd /blockchain/neo/testnet
```

```shell
screen -S neo-full wget https://packet.azureedge.net/neochain/n3testnet/full/0-646482/3280AA26512310922A60DE646194C323/chain.0.acc.zip
mv chain.0.acc.zip neo-cli/
```

### 設定檔和安裝插件

```shell
# Linux Centos 7 上安裝 leveldb
sudo yum -y install leveldb-devel
```

```shell
# Linux Centos 7 上安裝 dotnet
sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
sudo yum install dotnet-sdk-6.0
```

```shell
cd /blockchain/neo/testnet/neo-cli
```

```shell
# config 使用 config.testnet.json 版本
cp config.testnet.json config.json
```

```shell
# 手動啟動 neo 節點，執行安裝命令
dotnet neo-cli.dll

# 在 neo 啟動命令介面執行
    install RpcServer
    install TokensTracker
    install ApplicationLogs
    
# 退出 neo 節點
    exit
```

```shell
cd /blockchain/neo/testnet/neo-cli/Plugins/RpcServer

vim config.json

# 修改一下參數
    Network: 894710606
    BindAddress: "0.0.0.0"
    Port: 20332
```

```shell
cd /blockchain/neo/testnet/neo-cli/Plugins/TokensTracker

vim config.json

# 修改一下參數
    Network: 894710606
```

```shell
cd /blockchain/neo/testnet/neo-cli/Plugins/ApplicationLogs

vim config.json

# 修改一下參數
    Network: 894710606
```

```shell
# 需回到 neo-cli 目錄
cd /blockchain/neo/testnet/neo-cli

# 手動啟動節點，驗證安裝插件
dotnet neo-cli.dll

# 在 neo 啟動命令介面執行
    plugins
    
# 退出 neo 節點
    exit
```

### 啟動節點

```shell
cd /blockchain/neo/testnet/neo-cli
```

```shell
# 一定要在 neo-cli 執行 dotnet，這樣安裝插件跟 DB 資料才會在此目錄產生
vim state.sh

#!/bin/bash
echo "Starting private NEO testnet"
screen -dmS NEO_testnet dotnet neo-cli.dll
```

```shell
chmod +x start.sh
./start.sh
```
