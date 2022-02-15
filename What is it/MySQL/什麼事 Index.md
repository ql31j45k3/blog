# 什麼事 index

## 什麼事 index
    索引是提升 DB 查找資料的速度，如果沒有索引，當 DB 找資料時候，就需要每一筆一筆資料查找，這種方式非常費時的，
    藉由索引把資料做排序和分類後，當 DB 要查找資料時候，就可以利用索引得知資料在那個區塊，這種方式大大提升查找速度。

### 什麼事 B tree
    是一個 m叉搜索樹，m 代表有多少個子樹，像二叉搜索樹，就代表固定為兩個子樹搜索，
    因為資料庫的效能瓶頸點會是在磁盤 I/O 上，用 m叉搜索樹可以大大降低樹的高度，一個樹的高度代表一次 I/O，
    結構上葉子節點和非葉子節點都可以儲存數據，並用中序遍歷可以查找所有資料。
    
    m叉搜索樹可有效利用局部性原理，通常軟體使用的數據都會集中在同一個區塊的，而如何做到讀取同一個區塊資料就稱為磁盤預讀，
    磁碟讀取的設計是按頁讀取的，因為同一個區塊的其他資料，在未來有很高的機率是會讀取的，用按頁讀取資料，可以避免未來的 I/O 讀取。

### 什麼事 B+ tree
    是建立在 B tree 結構上，在優化查找資料的場景，因為查找通常都會是範圍查找的，並希望更加利用磁碟讀取的量，
    所以改為只有葉子節點才儲存數據，這樣非葉子節點只儲存 key ，可以在一頁內儲存更多索引，並在葉子節點增加鏈表，
    可以直接在葉子節點查找所有數據，會比用中序遍歷更有效率，B+ tree 做的所有優化，
    是為了讓 SQL 用索引查找更加有效率，包含範圍和排序的查詢。

### 為什麼 index 選擇用 B+ tree
    因為 B+ tree 的結構特性，最大利用局部性原理和磁盤預讀的功能，非常適合用來讀取磁碟資料，
    很矮的樹的高度，就可以儲存大量數據，一個高度代表一次 I/O，如果樹的高度為三，那只要三次 I/O 就可以讀取到資料。

### index 的優缺點
    優點是可以加速查詢的速度，缺點是新增、修改、刪除都需要維護 index 的排序，
    在這邊 trade off 的代價，就是用缺點的部分去換來優點的部分。

### B+ tree 索引和 Hash 索引區別
    Hash 索引的在新增、修改、刪除和單一 key 查找的確很快速為 O(1)，但 Hash 索引在範圍查詢是需要全表查詢的，
    所以 Hash 索引不適合做範圍和排序的查詢，只適合做單一 key 的查詢，而在 B+ tree 查找都會是 O(log(n))，非常適合做範圍和排序的查詢。

## 如何優化 SQL
    優化 SQL 的方向就是讓執行計畫，更有效率的使用 index，所以整個主軸就是了解 SQL 的執行計畫內容，
    搭配有什麼特性可以幫助 index 加速的功能，這樣就可以優化 index 執行計畫，讓 SQL 走更佳的路線取得資料。

    有以下功能可以幫助 index 加速，如覆蓋索引、最左匹配規則、ICP 等，這些是其中一些方法，但不只這些方法可以幫助 index 加速。

### 什麼事 覆蓋索引
```
CREATE TABLE person (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL,
    `age` int,
    PRIMARY KEY ( `id` ),
    INDEX idx_name (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

example 1：
    SELECT * FROM person WHERE `id` = 1;
example 2：
    SELECT name FROM person WHERE `name` = 'name';
```

    mysql 的索引是只有主鍵索引才會有儲存數據，所以二級索引儲存的是主鍵的值，從二級索引回去主鍵索引查到資料稱為回表，
    像 example 1 的查詢方式，勢必要去主鍵索引取得所有欄位的資料回來，用 example 2 的查詢方式，只要在二級索引內查詢，
    就可以滿足查詢的需求，而不需要回表查找其它欄位資料，這稱為覆蓋索引，而使用覆蓋索引可以有效的減少 I/O，因為不需要回表查詢資料。

### 什麼事最左匹配規則
```
CREATE TABLE person (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL,
    `age` int,
    `address` VARCHAR(40) NOT NULL,
    PRIMARY KEY ( `id` ),
    INDEX idx_name_age_address (`name`, `age`, `address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

example 1：
    SELECT * FROM person WHERE `name` = 'name' AND `age` = 18 AND `address` = 'address';
example 2：
    SELECT * FROM person WHERE `name` = 'name' AND `age` > 18 AND `address` = 'address';
```

    複合索引，是將多欄位組合再一起的索引，索引是有順序性的，所以當複合索引要完全使用到，是要符合索引欄位順序的，
    像是 example 1 的查詢條件就使用複合索引的三個欄位，這樣就可以完整使用到索引，但像是 example 2 的查詢條件，
    在 `age` > 18 就會讓索引中斷掉，只能使用到索引的兩個欄位，因為複合索引是依照欄位順序建立的，
    當遇到查詢語法有 >、<、between 等語法就會無法使用到下一個欄位，而最左匹配規則就是指再用複合索引時候，
    要依照索引最左邊欄位開始依順序匹配的規則。

### 什麼事 index Condition Pushdown
    此功能是優化 where 篩選過程，當關閉 ICP 情況下，由儲存引擎查詢出資料後，傳輸給 server 依照 wher 條件過濾出符合的資料，
    當開啟 ICP 後，就可以在儲存引擎查出資料後，用索引過濾可以過濾的 where 條件，這樣就可以提早過濾掉部分資料，
    但 ICP 只能用於二級索引，ICP 只能過濾掉跟索引相關的 where 條件，其它 where 條件一樣需要再 server 過濾掉。

## 總結
    索引是每個 DB 都會有的功能，雖然每個 DB 用的索引的細節處理方案不同，但大致上的流程與優化想法是可以借鏡參考的，
    因為優化 SQL 核心都是把 index 用更有效率的執行計畫執行，只要知道 DB 有那些機制可以讓 index 更有效率執行，
    並了解執行計畫的內容訊息，相信當有一種 DB 的 優化 SQL 經驗，就可以很快上手其它 DB 的 SQL 優化。

---
- 備註
  <br/>
  ICP: index Condition Pushdown。

- 參考
  <br/>
  [MySQL 索引性能分析概要](https://draveness.me/sql-index-performance/)
  <br/>
  [MySQL 索引设计概要](https://draveness.me/sql-index-intro/)
  <br/>
  [數據庫索引，到底是什麼做的？](https://codertw.com/%E7%A8%8B%E5%BC%8F%E8%AA%9E%E8%A8%80/721742/)
  <br/>
  [1分钟了解MyISAM与InnoDB的索引差异](https://database.51cto.com/art/201808/582172.htm)
  <br/>
  [MySQL索引背后的数据结构及算法原理](https://cloud.tencent.com/developer/article/1141500)
  <br/>
  [乾貨篇：深入剖析 MySQL 索引和 SQL 調優實戰](https://www.gushiciku.cn/pl/gQ6a/zh-hk)
  <br/>
  [MySQL索引原理及SQL优化](https://www.cnblogs.com/iceblow/p/11528565.html)
  <br/>
  [MySQL索引最左匹配原则及优化原理](https://cloud.tencent.com/developer/article/1790648)
  <br/>
  [MySQL索引原理及慢查询优化](https://cloud.tencent.com/developer/article/1613071)
  <br/>
  [MySQL索引与Index Condition Pushdown](http://blog.codinglabs.org/articles/index-condition-pushdown.html)
  <br/>
  [mysql索引最左匹配原则的理解](https://www.jianshu.com/p/46641d098a17)
  <br/>
  [我以為自己足夠了解MySQL索引，直到遇見阿里面試官](https://www.gushiciku.cn/pl/2S4N/zh-tw)
  <br/>
  [Mysql探索(一):B-Tree索引](https://segmentfault.com/a/1190000015821650)
  <br/>
  [MySQL的SQL性能优化总结](https://i6448038.github.io/2019/02/16/mysql-performance-optimize/)
  <br/>
  [浅谈MySQL的B树索引与索引优化](https://monkeysayhi.github.io/2018/03/06/%E6%B5%85%E8%B0%88MySQL%E7%9A%84B%E6%A0%91%E7%B4%A2%E5%BC%95%E4%B8%8E%E7%B4%A2%E5%BC%95%E4%BC%98%E5%8C%96/)
  <br/>
  [10分钟让你明白MySQL是如何利用索引的](https://cloud.tencent.com/developer/article/1032280)
  <br/>
  [【MySQL实战45讲】索引部分整理](http://www.noobyard.com/article/p-eulffdvi-oe.html)
  <br/>
  [官方文档解释MySQL最左匹配(最左前缀)原则](https://juejin.cn/post/6844903966690508814)
  <br/>
  [MySQL索引总结](https://zhuanlan.zhihu.com/p/29118331)
  <br/>
  [用了那麼久的Mysql，連覆蓋索引盡然不知道，面試知識建議收藏](https://kknews.cc/code/emk25ky.html)
