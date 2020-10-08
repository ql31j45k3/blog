# 什麼事 Session、Cookie

## 什麼事 Session、Cookie
    Session 是一種網路協定，作用在客戶端與伺服器端建立關聯，建立一種身份機制。
    Cookie 是客戶端用來管理儲存 Session 資料的機制。

### 為什麼需要 Session、Cookie
    因 HTTP 請求是無狀態的，需要一種方式識別 Client 的身份，Session 就是用來區別使用者身份機制，
    服務器端認證成功後會建立 Session 對象包含屬性內容，請求回應會攜帶 Session 資料，
    在下次 HTTP 傳遞 Session 資料伺服器端即可識別使用者，客戶端會在下次 HTTP 請求當中夾帶 Session 資料。

## 總結
    HTTP 請求是無狀態的，Session 和 Cookie 機制搭配讓瀏覽器與伺服器端可以建立出身份機制的功能。

---
- 備註
    <br/>
    Session 稱為 會話控制。

- 參考
    <br/>
    [維基百科-Session](https://zh.wikipedia.org/wiki/%E4%BC%9A%E8%AF%9D_(%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A7%91%E5%AD%A6))
    <br/>
    [維基百科-Cookie](https://zh.wikipedia.org/wiki/Cookie)
    <br/>
    [白話 Session 與 Cookie：從經營雜貨店開始](https://medium.com/@hulitw/session-and-cookie-15e47ed838bc)
    <br/>
    [前端三十 - 成為更好的前端工程師系列 第 27 篇](https://ithelp.ithome.com.tw/articles/10227602?sc=rss.iron)
    <br/>
    [认识HTTP----Cookie和Session篇](https://zhuanlan.zhihu.com/p/27669892)
    