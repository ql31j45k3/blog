# 什麼事 JSONP

## 什麼事 JSONP
    JSONP 跟 AJAX 兩個是不一樣的事情，語法上會讓使用者感覺很像的東西，主要原因是 AJAX 是無法跨網域請求的，
    JSONP 是解決跨網域請求之一的手法，利用標籤 <script>、<img>、<iframe> 並不會被同源政策阻擋做跨域請求，
    src 帶入不同網域的 URL 請求，JSONP 是客戶端發起一個 GET 請求附上 callback func name，伺服器端會將數據準備好，
    回傳一個 JS 檔案在檔案內呼叫 callback func name，這樣客戶端程式只要將邏輯寫在 callback func 就可以處理接收的資料，
    由於便於客戶端使用，逐漸形成的一種非正式傳輸協議，稱為 JSONP。

## 為什麼需要 JSONP
    如果要讓伺服器支援跨網域請求，就要使用 CORS 開放伺服器端限制性的來源網域，因為使用 ＊ 方式不限制開放有資安漏洞，
    可是這是在知道來源固定的前提下的條件，今天 Google analytics 的功能，想要箱入在不同網站內的話，是無法確定來源的場景，
    而 JSONP 利用 <script> src 可以跨網域請求的特性並不用先知道來源，
    這樣各個網站要使用就方便許多，當然使用 JSONP 建議是不要帶入敏感資料的。

## 總結
    JSONP 適合伺服器端處理給無法固定來源網站請求的場景，舉例 Google analytics 的功能，
    是可以限制與固定來源的場景可以使用 CORS 解決跨網域的請求需求。

---
- 備註
    <br/>
    JSONP 的全名是 JSON with Padding。
    <br/>
    請看[「什麼事 同源政策」的文章內容](https://github.com/ql31j45k3/blog/blob/master/What%20is%20it/%E8%B3%87%E8%A8%8A%E5%AE%89%E5%85%A8/%E4%BB%80%E9%BA%BC%E4%BA%8B%20%E5%90%8C%E6%BA%90%E6%94%BF%E7%AD%96.md)。
    請看[「什麼事 CORS」的文章內容](https://github.com/ql31j45k3/blog/blob/master/What%20is%20it/%E8%B3%87%E8%A8%8A%E5%AE%89%E5%85%A8/%E4%BB%80%E9%BA%BC%E4%BA%8B%20CORS.md)。

- 參考
    <br/>
    [JSONP是什么](https://segmentfault.com/a/1190000007935557)
    <br/>
    [用 JSONP 跨域 GET 簡易示範 ＆ 說明](https://medium.com/@brianwu291/jsonp-with-simple-example-4711e2a07443)
    <br/>
    [JSONP (JSON with Padding)](https://www.fooish.com/json/jsonp.html)
    <br/>
    [Cross Domain Ajax 跨網域抓取資料(JSONP)](https://ithelp.ithome.com.tw/articles/10094915)
    <br/>
    [JSONP跨域詳解](https://www.itread01.com/content/1543930922.html)