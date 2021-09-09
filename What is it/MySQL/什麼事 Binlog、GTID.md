# 什麼事 Binlog、GTID

## 什麼事 Binlog
    binlog 是 mysql server 層維護的日誌，binlog 有幾個特性，binlog 為邏輯日誌紀錄某個語句的原始邏輯、是一直累積增長的日誌、不支持崩潰恢復使用 (master 庫)，
    而是支持恢復 slave 庫，依照上述的特性可適用於幾個場景使用，邏輯日誌是可讓不同引擎層都能理解的和日誌是由 mysql server 層維護所以可讓不同引擎層使用，
    可作為同步資料給 slave 庫使用，binlog 是一直累積寫入資料的可用於增量備份場景，當誤刪除資料時可用於數據恢復。

### 為什麼需要 Binlog
    需要解決同步資料給 slave 庫與重新建立 slave 庫的場景，因有 slave 庫可用來做 HA 並增加高可用性、可擴展性，
    因 binlog 儲存了 SQL 執行語句的邏輯，當有 binlog 時可重新建立新的 slave 庫並不需要從零開始同步資料。

## Binlog 格式，什麼事 Row 模式
    紀錄 SQL 異動資料的每行數據被修改後的數據資料，同步給 slave 用異動後的數據進行修改。
    優點：紀錄方式是每行異動數據的詳細訊息，是最能夠保證數據正確性，不會因為使用 trigger 或 function 等，
         出現資料不正確的狀況 (master slave 資料不一樣)。
    缺點：因紀錄是每行數據異動資料，當異動多少筆就產生多少數據資料到 binlog，
         會產生較大的 binlog 日誌量，如執行 update 語法等於異動的每行數據都會寫進 binlog。

## Binlog 格式，什麼事 Statement 模式
    紀錄執行 SQL 語法的上下文內容與 SQL 語法，同步到 slave 端執行跟 master 一樣的上下文內容與 SQL 語法。
    優點：因不是紀錄每行紀錄的變化，如 update 語法是紀錄 SQL 語法而不是每行異動紀錄，不會產生大量 binlog 日誌量、用更少的 I/O ，提升性能。
    缺點：因執行的 SQL 語句在 master 和 slave 產生的結果並不能保證會是一樣的，如 SQL 語句使用 NOW() 此時 slave 前一個 SQL 語法執行太久，
         等前一個執行完後在執行 NOW()，執行後可能跟 master 相差幾秒鐘，當使用 trigger 或 function 等特性時候，可能會發生數據不一致問題。

## Binlog 格式，什麼事 Mixed 模式
    Mixed 就是將 Row 和 Statement 混合使用的模式，看上述內容這兩種模式優點與缺點兩個剛好相反，為了有兩種模式的優點就出現 Mixed 模式，
    Mixed 會依照 SQL 語句判斷使用 Row 或 Statement，在異動資料如 update、delete 語句一樣使用 Row，
    如果是 alter table 表結構修改就會使用 Statement 避免使用 Row 產生所有表的異動資料。

## 什麼事 GTID
    GTID 全名為 global transaction identifier 全域性事務標籤，GTID 代表事務在全域唯一性的 ID，全域是指整個架構 master-slave 內唯一的，
    等於跨多個 slave 可識別的 GTID，保證一個 GTID 在一個 DB 上只執行一次，但為了實現 GTID 功能在 slave 需要開啟 binlog 紀錄執行過的 GTID，
    slave 會使用本地的 binlog 驗證 GTID 是否執行過。

### 為什麼需要 GTID
    在傳統複製是使用 binlog pos (Position 位置)，每台 master or slave binlog pos 代表只是一個順序寫入的資料位置，
    無法輕易識別在 master pos 700 跟 slave pos 350 是執行同一筆資料，並且後續不同時間點新加入的 slave pos 都不會是一樣的，
    需要有一個方式可跨多台 DB 識別出 master 跟 slave 是否資料同步是一致的，這樣在 master 當機其它台 slave 要接管為 master，
    可馬上用 GTID 識別資料是否同步到最新，並其它 slave 重新跟新的 master 時更容易實現。

## 總結
    mysql 是基於 binlog 實現同步複製功能，並在同步數據中提供了三種模式選擇，在後續為了可更容易識別同步複製的資料進度與處理故障轉移場景，
    新增 GTID 識別同步複製資料的進度，binlog 可說是 mysql 同步資料的中心點並延伸可使用到備份、增量備份、數據恢復等場景。

---
- 備註
  <br/>
  GTID： 全域性事務標籤 (global transaction identifier)。

- 參考
  <br/>
  [MySQL -- redolog + binlog](http://zhongmingmao.me/2019/01/15/mysql-redolog-binlog/)
  <br/>
  [腾讯工程师带你深入解析 MySQL binlog](https://zhuanlan.zhihu.com/p/33504555)
  <br/>
  [MySQL binlog三种模式](https://www.jianshu.com/p/0b944ac6f690)
  <br/>
  [MySQL主從複製-GTID原理](https://www.itread01.com/content/1545820323.html)
  <br/>
  [深入MySQL复制(二)：基于GTID复制](https://www.cnblogs.com/f-ck-need-u/p/9164823.html)
  <br/>
  [mysql 基於GTID複製](https://codertw.com/%E7%A8%8B%E5%BC%8F%E8%AA%9E%E8%A8%80/186614/)
