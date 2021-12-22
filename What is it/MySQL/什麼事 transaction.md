# 什麼事 transaction

## 什麼事 transaction
    事務是可以將多個 SQL 變成一個看待，要麻全部成功或全部失敗，這樣在異動多張 Table 時候，就可以用事務確保所有的修改都會是一起的，
    如果沒有事務，當異動多張 Table 不能一個看待，這樣就有可能部分 Table 異動成功和部分 Table 異動失敗，這樣就很難正確的異動資料，
    而事務具備 ACID 的特性 (會在後續介紹)，簡單來說用事務可以保證多個 SQL 執行，要麻全部成功或全部失敗。

## 什麼事 mini-transaction (MTR)
    事務是保證多個 SQL 的一致性，但 SQL 會異動到多個頁的修改，所以 MTR 是保證頁的修改的一致性，
    頁就是只在操作 undo log 和 redo log 日誌，MTR 就是處理日誌的 ACID 的特性，
    簡單來說 MTR 可以保證在寫 undo log 和 redo log 要麻全部成功或全部失敗。

### 什麼事 ACID
    原子性 (Atomicity)
        只事務內的 SQL 就像是一個整體一樣無法切割，要麻全部成功或全部失敗。
    一致性 (Consistency)
        從一個正確的狀態到另一個正確的狀態，這邊指的狀態是修改前的資料和修改後的資料，
        都會符合 DB 的欄位約束 (資料型態、長度等)，不會出現破壞 DB 欄位約束的資料。
    隔離性 (Isolation)
        多個事務可並發執行，每個事務之間是間隔開來的，但各自的讀寫操作的影響範圍，
        會依照設定的隔離層級來決定 (會在後續介紹)。
    持久性 (Durability)
        事務提交過後，就是寫入到磁碟當中，這樣就不會遺失資料，對 DB 的修改就是持久化的變動。

### 什麼事隔離層級
    隔離層級就是指事務之間的可見度，如果做到完全隔離，則會降低事務的並發能力和性能，
    如果提高最大並發能力和效能，則會每個事務之間毫無間隔，這樣對資料的正確性也是一大困擾 (這邊指的是髒讀問題)，
    隔離層級就是權衡性能和可見度的選擇，總共有四個隔離層級可以設定，而每個隔離層級理論上都是解決一個問題，
    但 mysql 實作上在 RR 層級同時解決了不可重複讀和幻讀的問題，關於髒讀 (dirty read)、
    不可重複讀 (unrepeatable read)、幻讀 (phantom read) ，請看「什麼事鎖」。

    讀未提交 (Read Uncommitted RU)
        可以讀取到其它事務未提交的的紀錄，未解決髒讀、不可重複讀、幻讀的問題。
    讀已提交 (Read Committed RC)
        解決了髒讀問題，不會讀取到其它事務未提交的紀錄，但未解決不可重複讀、幻讀的問題。
    可重複讀 (Repeatable Read RR)
        解決了不可重複讀，所以在同個事務內的重複執行查詢，可以保證查詢結果是一樣的，不會因為其它事務修改資料，
        而影響查詢解果，但未解決幻讀問題。
    序列化 (Serializable)
        在此隔離層級是一個一個執行事務的，所以效能最差，但不會出現任何問題。

## 總結
    事務是 DB 一個很重要的功能，因為 DB 就是一個有狀態的服務，如何對資料的異動不遺失，如何對多筆資料的異動，保證全部成功或全部失敗，
    這些問題都是很複雜和困難的，而事務的 ACID 解決了這些問題，另外隔離層級應依照業務類型，來選擇合適的隔離層級，因每個層級代表不同的效能權衡。

---
- 備註
  <br/>

- 參考
  <br/>
  [什麼事鎖](什麼事鎖.md)
  <br/>
  [『浅入深出』MySQL 中事务的实现](https://draveness.me/mysql-transaction/)
  <br/>
  [解决死锁之路 - 学习事务与隔离级别](https://www.aneasystone.com/archives/2017/10/solving-dead-locks-one.html)
  <br/>
  [数据库恢复 —— 关于事务原子性、持久性](https://zhuanlan.zhihu.com/p/35841956)
  <br/>
  [MySQL|MySQL事物以及隔离级别](https://segmentfault.com/a/1190000038212205)
  <br/>
  [数据库弱一致性四个隔离级别（转载）](https://xnerv.wang/four-isolation-levels-of-database-weak-consistency/)
  <br/>
  [MySQL -- 事务隔离](http://zhongmingmao.me/2019/01/16/mysql-transaction-isolation/)
  <br/>
  [InnoDB -- 事务隔离级别](http://zhongmingmao.me/2017/05/21/innodb-isolation-level/)
  <br/>
  [MySQL -- RR隔离与RC隔离](http://zhongmingmao.me/2019/01/28/mysql-transaction-isolation-rr-rc/)
  <br/>
  [MySQL -- 幻读](http://zhongmingmao.me/2019/02/14/mysql-phantom/)
  <br/>
  [MySQL系列：innodb源码分析之mini transaction](https://www.php.cn/mysql-tutorials-120236.html)
  <br/>
  [innodb的mini-transaction](https://www.gushiciku.cn/pl/ap3B/zh-tw)
  <br/>
  [MySQL中MTR的概念](https://cloud.tencent.com/developer/article/1668083)
  <br/>
  [知识分享 | MySQL InnoDB 日志缓冲区（Log Buffer）讲解](https://www.modb.pro/db/61901)
  <br/>
  [InnoDB——Btree与MTR的牵扯](http://liuyangming.tech/05-2019/InnoDB-Mtr.html)
  