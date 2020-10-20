# 什麼事 JSON Hijacking

## 什麼事 JSON Hijacking
    JS Array 原生語法被覆寫，駭客就可以偷取 API 資料，JS Array 語法被覆寫會發生什麼情況？
    先說明同源政策是什麼，同源政策對連結、重新導向、表單請求是寬鬆政策允許跨來源存取，針對 JS 限制比較高，
    但今天只要是陣列 [] 開頭的內容是可以馬上被執行的 JS，這樣情況可以繞過同源政策的防範，另外在 CSRF 也說明用 Cookie 是不足保護使用者，
    駭客早期利用 __defineSetter__ 複寫 Primitive Type 的 JS 物件，現在已被瀏覽器修復此問題。

### 如何防禦 JSON Hijacking
    跟 CSRF 雷同，透過 JS 執行取得資料，但不確定是使用者行為還是攻擊者執行的，加上 CSRF Token 辨別來源，
    API 回傳不要直接使用 JSON 陣列 []，改回傳 JOSN 物件 {} 就不會馬上執行而繞過同源政策，
    FB 的解法是在回傳最前面增加 for loop 無窮迴圈讓攻擊者無法得到 API 請求的資料。 

## 總結
    JSON Hijacking 目前比較少聽到的原因是瀏覽器修復 Bug 後相對駭客沒在使用的手法，
    但在未來 JS 新增語法後不能保證不會發生一樣的事情，在安全性上還是要增加保護措施的動作。

---
- 備註
    <br/>
    同源政策 Same Origin Policy。

- 參考
    <br/>
    [前端三十｜29. [WEB] 網站常見的資安問題有哪些？](https://medium.com/schaoss-blog/%E5%89%8D%E7%AB%AF%E4%B8%89%E5%8D%81-29-web-%E7%B6%B2%E7%AB%99%E5%B8%B8%E8%A6%8B%E7%9A%84%E8%B3%87%E5%AE%89%E5%95%8F%E9%A1%8C%E6%9C%89%E5%93%AA%E4%BA%9B-bc47b572d94d)
    <br/>
    [為何 Facebook API 要回傳無窮迴圈？ 談捲土重來的 JSON Hijacking](https://medium.com/@jaydenlin/%E7%82%BA%E4%BD%95-facebook-api-%E8%A6%81%E5%9B%9E%E5%82%B3%E7%84%A1%E7%AA%AE%E8%BF%B4%E5%9C%88-%E8%AB%87%E6%8D%B2%E5%9C%9F%E9%87%8D%E4%BE%86%E7%9A%84-json-hijacking-bc220617ceba)
        