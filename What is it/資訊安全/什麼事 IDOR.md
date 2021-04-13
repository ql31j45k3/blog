# 什麼事 IDOR

## 什麼事 IDOR
    是指在 API 的 QueryString 參數帶入不合理的值 範例如下，
    正常帶入 userID 對應的流水號，即可取得 User 資訊，
    但如果帶入 linux 的指令如 ../etc/passwd，可取得主機上存放密碼資訊的檔案內容，
    這樣惡意者就攻擊成功取得機敏資訊。

```
    正常：https://example.com.tw?userID=123
    不正常：https://example.com.tw?userID=../../../etc/passwd
```

## 如何防禦 IDOR
    伺服器運行服務的帳號權限控管，不要開權限可讀到非程式需要讀取的目錄與檔案，
    針對 API 請求的 ID 參數值進行驗證邏輯、不要提供流水號 使用 uuid 等邏輯值，
    主要是無法人工識別需要程式進行解碼動作的參數值邏輯。

## 總結
    主機上運行服務的帳號權限控管是大多數資安上的重點，另外惡意者會用出非預期的方式使用 API，
    基本對客戶端的傳送資料都需假設資料不可相信，需要對資料型態跟值做驗證邏輯。

---
- 備註
    <br/>
    IDOR：Insecure direct object references。

- 參考
    <br/>
    [insecure direct object reference 維基百科](https://en.wikipedia.org/wiki/Insecure_direct_object_reference)
    <br/>
    [身為 Web 工程師，你一定要知道的幾個 Web 資訊安全議題](https://medium.com/starbugs/%E8%BA%AB%E7%82%BA-web-%E5%B7%A5%E7%A8%8B%E5%B8%AB-%E4%BD%A0%E4%B8%80%E5%AE%9A%E8%A6%81%E7%9F%A5%E9%81%93%E7%9A%84%E5%B9%BE%E5%80%8B-web-%E8%B3%87%E8%A8%8A%E5%AE%89%E5%85%A8%E8%AD%B0%E9%A1%8C-29b8a4af6e13)
    <br/>
    [[Day 27] 來玩WebGoat！之15：Access Control Flaws - Insecure Direct Object References 1](https://ithelp.ithome.com.tw/articles/10209447)
    