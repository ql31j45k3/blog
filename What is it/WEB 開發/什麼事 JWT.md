# 什麼事 JWT

## 什麼事 JWT
    是一組 JSON 格式編碼成的 Token，JWT 使用密碼學的技術做資料的安全性驗證，這樣就可以驗證是不是自己發佈的 JWT，
    驗證成功即代表是合法的資料取得對應的 ID，無需再進入資料庫驗證更適合 API 無狀態的特性，
    JWT 是由三個組成 標頭.內容.簽名 每個都用 . 隔開，裡面最重要的事用簽名驗證這組資料是不是有被修改過資料，
    因為簽名的邏輯是 標頭的 Base64 + 內容的 Base64 + secret 這三組資料組成做加密資料，
    這當中 secret 資料保存在服務端不會存放到客戶端，就算有惡意人士寫要偽造 JWT 資料，
    沒有 secret 資料就無法偽造成功正確的 JWT。
    
```
    Header 標頭
    下方為一個範例程式。
    {
        # 類型，目前基本使用 JWT
        'typ': 'JWT',
        # 加密的演算法，HMAC、SHA256、RSA 進行 Base64 編碼
        'alg': 'HHAC'
    }

    Payload 內容
        存放傳遞的資訊，但不適合放敏感資料，主要分三種聲明 Registered claims(註冊聲明)、Public claims(公開聲明)、Private claims(私有聲明)，
        細節欄位就先不細說，下方為一個範例程式。
    {
        'sub': '1234567890',
        'name': 'member001',
        'exp': '1450829370'
    }

    Signature 簽名
        HMACSHA256(base64UrlEncode(header) + "." + base64UrlEncode(payload), 'secret')
```

### 為什麼需要 JWT
    原本身份機制 Session 不是說已經無用處，在現在架構上後端為了讓服務無狀態並且多台運行，還是需要一個資料庫儲存 Session ID 對應的資料，
    JWT 是開始發展的另一種類型的身份機制，可以解決服務無狀態的需求與不需要存取一份資料在資料庫內。

### 總結
    JWT 是用另一種方式來作為身份驗證機制，可以解決以前身份驗證機制的根本問題，JWT 用密碼學的機制驗證資料的合法性，
    不代表 Session 就可以被取代，是網路的持續發展讓現代、未來會誕生不同的解決方案。

---
- 備註
    <br/>
    JWT 的全名是 JSON Web Token，是一種基於 JSON 的開放標準(RFC 7519)。

- 參考
    <br/>
    [[筆記] 透過 JWT 實作驗證機制](https://medium.com/%E9%BA%A5%E5%85%8B%E7%9A%84%E5%8D%8A%E8%B7%AF%E5%87%BA%E5%AE%B6%E7%AD%86%E8%A8%98/%E7%AD%86%E8%A8%98-%E9%80%8F%E9%81%8E-jwt-%E5%AF%A6%E4%BD%9C%E9%A9%97%E8%AD%89%E6%A9%9F%E5%88%B6-2e64d72594f8)
    <br/>
    [JWT(JSON Web Token) — 原理介紹](https://medium.com/%E4%BC%81%E9%B5%9D%E4%B9%9F%E6%87%82%E7%A8%8B%E5%BC%8F%E8%A8%AD%E8%A8%88/jwt-json-web-token-%E5%8E%9F%E7%90%86%E4%BB%8B%E7%B4%B9-74abfafad7ba)
    <br/>
    [JSON Web Token(JWT) 簡單介紹](https://mgleon08.github.io/blog/2018/07/16/jwt/)
    <br/>
    [以 JSON Web Token 替代傳統 Token](https://yami.io/jwt/)
    <br/>
    [是誰在敲打我窗？什麼是 JWT ？](https://5xruby.tw/posts/what-is-jwt/)
    