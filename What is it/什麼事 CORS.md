# 什麼事 CORS

## 什麼事 CORS
    原本 AJAX 只能夠同源政策也就是只能從自己的網域內發起請求，但因為網路的發展漸進要跟其它網站取得資料，
    所以有了 CORS 讓 AJAX 可以跨領域的向其它服務發起請求取得資料，要做到 CORS 是要雙向的配合需要瀏覽器與服務器支援，
    服務端要設定三個屬性 Access-Control-Allow-Origin、Access-Control-Allow-Credentials、Access-Control-Expose-Headers。
    
    Access-Control-Allow-Origin：
        接受值內的網域請求，如過是 * 就代表任何網域都可以發起請求。
    Access-Control-Allow-Credentials：
        表示是否可以發送 Cookie。
        默認情況 Cookie 是不包含在 CORS 內。
    Access-Control-Expose-Headers：
        除了基本可以得到 Cache-Control、Content-Language、Content-Type、Expires、Last-Modified、Pragma 屬性外，
        如果要獲得以上非六個屬性，就需要在此值內增加。

### 如何防禦 CORS
    正確的設定 Access-Control-Allow-Origin、Access-Control-Allow-Credentials、Access-Control-Expose-Headers 參數，
    不要過大的開啟權限，盡量避免使用 Access-Control-Allow-Origin：* 方式開啟，設定白名單、增加身份驗證機制等方式，確保是可信任來源的請求，
    避免惡意攻擊造成資源耗盡或取得敏感資料。

## 總結
    網路發展的趨勢原本 AJAX 同源政策已經不能滿足現今的網路世界，需要跟其他服務做串接取得數據，舉例 FB、Twitch 等第三方服務，
    為了滿足網路趨勢才出現跨領域的 AJAX 也就是 CORS 請求，再開放 CORS 的權限要設定正確之外還是要使用相關的安全措施如白名單、身份驗證機制等方式，
    確保是可信任來源的請求。

---
- 備註
    <br/>
    同源政策，Same-origin policy。
    <br/>
    CORS，全名為 Cross-Origin Resource Sharing，跨來源資源共享。

- 參考
    <br/>
    [輕鬆理解 Ajax 與跨來源請求 - TechBridge 技術共筆部落格](https://blog.techbridge.cc/2017/05/20/api-ajax-cors-and-jsonp/)
    <br/>
    [跨域资源共享 CORS 详解 - 阮一峰的网络日志](https://www.ruanyifeng.com/blog/2016/04/cors.html)
    <br/>
    [和 CORS 跟 cookie 打交道](https://medium.com/d-d-mag/%E5%92%8C-cors-%E8%B7%9F-cookie-%E6%89%93%E4%BA%A4%E9%81%93-dd420ccc7399)
    