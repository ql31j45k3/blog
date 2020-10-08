# 什麼事 SQL Injection

## 什麼事 SQL Injection
    網站的輸入資料被惡意輸入 SQL 語法，造成 SQL 語法無法正確的邏輯執行，
    原本要登入帳密的部分被惡意 SQL 語法改為不需要帳密即可登入網站。
    
```
    // 原本預期執行的語法
    SELECT * FROM `user` WHERE user = 'XXX' AND password = 'XXX';

    // 被惡意程式修改後的語法
    SELECt * FROm `user` WHERE user = '1' or 1 = 1 -- AND password = '';
```

### 如何防禦 SQL Injection
    不要使用字串組 SQL 語法，使用 Prepare Statement 解析 SQL 語法，
    Prepare Statement 分析好語法後要帶入的參數會放入問號內，因為已經分析完 SQL 語法，
    在帶入問號參數替換為實際值的時候只會被當作字串放入，不會被視為 SQL 語法執行。
    
```
    SELECT * FROM `user` WHERE user = ? AND password = ?;
```

## 總結
    SQL Injection 是已經行之有年的攻擊手法，只要正確的使用 DB 提供的 Prepare Statement 功能，
    就可以阻擋 SQL Injection 攻擊。

---
- 備註

- 參考
    <br/>
    [前端三十｜29. [WEB] 網站常見的資安問題有哪些？](https://medium.com/schaoss-blog/%E5%89%8D%E7%AB%AF%E4%B8%89%E5%8D%81-29-web-%E7%B6%B2%E7%AB%99%E5%B8%B8%E8%A6%8B%E7%9A%84%E8%B3%87%E5%AE%89%E5%95%8F%E9%A1%8C%E6%9C%89%E5%93%AA%E4%BA%9B-bc47b572d94d)
    <br/>
    [[第十二週] 資訊安全 - 常見攻擊：XSS、SQL Injection](https://yakimhsu.com/project/project_w12_Info_Security-XSS_SQL.html)
    