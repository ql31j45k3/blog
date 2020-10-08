# 什麼事 CSS keylogger

## 什麼事 CSS keylogger
    利用 CSS Selector 的特性可以載入不同的網址，就能夠將網頁上輸入密碼時同步一個一個字元的方式傳送到其它服務端，
    但有些限制 不能保證值的順序、重複字元不會送出請求，前端 React 框架其中就有讓 input 跟 value 輸入值同步的特性。

### 如何防禦 CSS keylogger
    客戶端防禦可以安裝 Chrome Extension 掃描網站內容，服務端的防禦使用 Content-Security-Policy HTTP Header，
    讓瀏覽器只能載入同個網域下的資源。

## 總結
    CSS keylogger 目前還是有些缺陷無法很精準的取得資料正確性，但在未來發展可能會成為攻擊手法，
    同時也很有趣是 CSS 也可以成為攻擊手法之一的可能性。

---
- 備註

- 參考
    <br/>
    [CSS keylogger：攻擊與防禦 - Huli](https://blog.huli.tw/2018/03/12/css-keylogger/)
    