# mac 安裝 mongoDB

# mac homebrew 安裝
    因 mongoDB 不在開源，所以 homebrew 也不在支援 mongoDB 的安裝。

# 官網下載安裝
    1. 去官方網站下載社區版的 mac monogoDB 版本，我下載版本為 5.0.2 (mongodb-macos-x86_64-5.0.2.tgz)。
    2. 將 mongodb-macos-x86_64-5.0.2.tgz 改名為 mongodb。
    3. mongodb mv 到 /usr/local，因搬移到的目錄為系統重要目錄，需使用 sudo 指令。
    4. 在 /usr/local/mongodb 建立 /data/db 和 /log 資料夾，因為新版本 mac 安全性考量不可放在預設路徑根目錄 /data/db
       ，需要用參數方式調整存放 db 和 log 的路徑。
    5. 設定 mongodb 環境變數，打開 open ~/.bash_profile 文件，輸入 "export PATH=$PATH:/usr/local/mongodb/bin" 設定 mongodb 執行檔，
       執行 source ~/.bash_profile 讓環境設定檔執行生效。
    6. 執行 sudo mongod --dbpath /usr/local/mongodb/data/db --logpath /usr/local/mongodb/log/mongod.log --logappend 在背景執行
    7. 在開啟另一個命令窗口執行 mongo 可登入 mongodb 執行介面，可用下方命令關閉 mongodb。
       # 進入 admin db
       use admin;
       # 關閉 mongodb
       db.shutdownServer();
       # 退出 mongodb 執行介面
       exit；

- 參考
  <br/>
  [mac下的mongoDB的安装和启动](https://juejin.cn/post/6844903958826188808)
  <br/>
  [mongoDB 官網](https://www.mongodb.com/try/download/community)