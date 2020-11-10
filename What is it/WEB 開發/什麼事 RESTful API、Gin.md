# 什麼事 RESTful API、Gin

## 什麼事 REST
    它是一種軟體架構風格，目的是讓不同軟體服務之間更好互相傳遞資源，
    它把網站上所有事物 (一張圖片、一種服務 等) 視為資源，每一個 URI 代表一種資源，
    資源是一個名詞設計不應該有動詞在 URI 上，動詞使用 HTTP Method 展示此次獲取資源的行為，
    只看 HTTP Request 就理解如何操作伺服器的 API。

## 什麼事 RESTful
    RESTful 只是 REST 的形容詞，兩種代表意思是一樣。

## 什麼事 RESTful API
    符合 REST 風格撰寫的 API 稱為 RESTful API。

### 為什麼需要 RESTful API
    在傳統 API 設計是利用 URI 上的取名代表不同行為，會出現同義詞但用不同英文表達，
    HTTP Method 只有使用 Get、Post，未善加利用原本 HTTP 的優點之外，Get 不一定代表是取資料，
    必須要用 URI 才可理解資源的行為。

## 什麼事 Gin
    Golang 開發的 WEB 框架並注重效能，支援註冊 RESTful API 的路由器，內部包含開發 WEB 服務需要的各個模組。

### 為什麼需要 Gin
    選擇成熟的第三方套件、並社區活耀度也非常高、文件也相當完善，Golang 原生建立一個 WEB 服務使用官方的套件即可相當容易建立。

#### REST 風格
    1. 每一個 URI 代表一種資源，
    2. 客戶端與伺服器之間的傳輸資源某種格式 (表現層)，例如 XML、JSON。
    3. 客戶端透過 HTTP Method 對伺服器資源進行操作。

### HTTP Method
    Get（Safe & Idempotent）：取得伺服器一筆或多筆資源。
    Post：伺服器新增一筆資源。
    Put（Idempotent）：修改伺服器資源。
    Patch：修改伺服器資源一筆或部分欄位。
    Delete（Idempotent）：伺服器刪除資源。
    Head（Safe & Idempotent）：只可取得伺服器 HTTP Status and Head 資料，不可傳送 Body 資料。
    Options：取得伺服器訊息表頭相關，知道伺服器是否支援那些功能。

#### 優點
    REST 善用 HTTP 原本既有的功能，URI 有統一的前綴更容易理解與操作，Get 操作資料符合 Cache 特性。

### 總結
    REST 是一種軟體架構風格，把網站上都視為一種資源，每一個 URI 代表一種資源，設計出容易理解如何操作資源的風格。
    RESTful 只是 REST 的形容詞，兩種代表意思是一樣。
    符合 REST 風格撰寫的 API 稱為 RESTful API。

---
- 備註
    <br/>
    REST，全名 Representational State Transfer (表現層狀態轉移)。
    <br/>
    統一資源識別碼（英語：Uniform Resource Identifier，縮寫：URI）在電腦術語中是一個用於標識某一網際網路資源名稱的字串。
    <br/>
    URI的最常見的形式是統一資源定位符（URL）。
    <br/>
    idempotent 是代表執行多少次，結果還是會一樣。

- 參考
    <br/>
    [維基百科-統一資源標誌符](https://zh.wikipedia.org/wiki/%E7%BB%9F%E4%B8%80%E8%B5%84%E6%BA%90%E6%A0%87%E5%BF%97%E7%AC%A6)
    <br/>
    [API 是什麼? RESTful API 又是什麼?](https://medium.com/itsems-frontend/api-%E6%98%AF%E4%BB%80%E9%BA%BC-restful-api-%E5%8F%88%E6%98%AF%E4%BB%80%E9%BA%BC-a001a85ab638)
    <br/>
    [小菜鳥傑夫-何謂RESTful API？](https://dotblogs.com.tw/jeffyang/2018/04/21/233001)
    <br/>
    [阮一峰的网络日志-理解RESTful架构](http://www.ruanyifeng.com/blog/2011/09/restful.html)
    <br/>
    [阮一峰的网络日志-RESTful API 设计指南](http://www.ruanyifeng.com/blog/2014/05/restful_api.html)
    <br/>
    [什麼是 REST? RESTful?](https://medium.com/@cindyliu923/%E4%BB%80%E9%BA%BC%E6%98%AF-rest-restful-7667b3054371)
    <br/>
    [[不是工程師] 休息(REST)式架構? 寧靜式(RESTful)的Web API是現在的潮流？](https://progressbar.tw/posts/53)
    <br/>
    [NotFalse 技術客-HTTP 請求方法 — HEAD、PUT、DELETE](https://notfalse.net/45/http-head-put-delete)
    <br/>
    [簡明RESTful API設計要點](https://tw.twincl.com/programming/*641y)
    <br/>
    [程式前沿-基於Golang的開發框架Gin實戰](https://codertw.com/%E7%A8%8B%E5%BC%8F%E8%AA%9E%E8%A8%80/733546/)
    <br/>
    [Github Gin](https://github.com/gin-gonic/gin)

- 範例
    <br/>
    GET https://api.example.com/v1/product 取得全部商品資料
    <br/>
    GET https://api.example.com/v1/product/ID 取得指定的商品一筆資料
    <br/>
    POST https://api.example.com/v1/product 新增一個商品
    <br/>
    PUT https://api.example.com/v1/product/ID 修改指定的商品全部資料
    <br/>
    PATCH https://api.example.com/v1/product/ID 修改指定的商品單筆或部分欄位資料
    <br/>
    DELETE https://api.example.com/v1/product/ID 刪除指定商品資料
    