# 什麼事 XSS

## 什麼事 XSS
    網站的輸入的資料變成程式得一部分，通常是輸入 <script> 的 JS 語法，這樣就可以在留言或者討論區等地方，
    執行之前輸入過的 JS 語法，造成網站運行惡意資料內的程式語法的攻擊，可以分為儲存型 XSS、反射型 XSS、DOM 型 XSS。
    
    儲存型 XSS：
        最常見的情形就是論壇或訊息的輸入框，輸入惡意的 JS 語法儲存在 DB 內，
        這樣每個使用者進入顯示訊息的地方就會執行之前惡意的程式碼受到影響。
    反射型 XSS：
        將惡意程式放入 GET 參數內，有的程式邏輯會執行取得 GET 參數後顯示訊息，這時候如果不是正常的字串，
        是放入 JS 語法的話就可以達成攻擊。
    DOM 型 XSS：
        可能是頁面上使用 .html() 或 .innerHTML() 的語法邏輯，只要在此處加入 JS 語法也會執行並達成攻擊。

### 如何防禦 XSS
    只要是在輸入/輸出的邏輯做好字元轉換，讓所有的資料都是為字元，讓惡意程式碼不被執行即可。

## 總結
    不要相信使用者的輸入資料，要將資料作過濾與字元轉換邏輯。

---
- 備註
    <br/>
    XSS（Cross-site scripting），也叫做 JavaScript Injection。

- 參考
    <br/>
    [前端三十｜29. [WEB] 網站常見的資安問題有哪些？](https://medium.com/schaoss-blog/%E5%89%8D%E7%AB%AF%E4%B8%89%E5%8D%81-29-web-%E7%B6%B2%E7%AB%99%E5%B8%B8%E8%A6%8B%E7%9A%84%E8%B3%87%E5%AE%89%E5%95%8F%E9%A1%8C%E6%9C%89%E5%93%AA%E4%BA%9B-bc47b572d94d)
    <br/>
    [[第十二週] 資訊安全 - 常見攻擊：XSS、SQL Injection](https://yakimhsu.com/project/project_w12_Info_Security-XSS_SQL.html)
    <br/>
    [Web 資訊安全（Security）簡明入門教學指南 - TechBridge 技術共筆部落格](https://blog.techbridge.cc/2016/11/05/web-security-tutorial-introduction/)
    