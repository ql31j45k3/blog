# 什麼事 ORM、GORM

## 什麼事 ORM
    用面向對象編程的思維操作資料庫，不需要了解底層是那個資料庫，程式會自動轉成各自資料庫的 SQL 語法。

### 為什麼需要 ORM
    需求開發當中最基本的 CRUD 程式有大量重複性的 Raw SQL，差異只在撈取的欄位與表格不同，
    使用 ORM 可以提高開發速度 (CRUD 類型)、並且將 CRUD 的程式抽象成一個共用函式。

## 什麼事 GORM
    Golang 實作開發的 ORM 套件，除了有 ORM 功能，並有豐富的支援資料庫特性功能之外，
    當中的 Debug 功能，可知道實際組成的 SQL 語法，也可設定不同的 Log Level，
    針對執行 SQL 語法前後提供鉤子可執行程式邏輯，並可自行註冊函式擴充功能，社群的活耀度很高與豐富的文件。

### 為什麼需要 GORM
    選擇成熟與穩定的第三方套件與活躍度高的社區，不必重複打造一個新的輪子的時間與維護成本，
    除非已經是市面上的套件滿足不了需求的大型公司，才有會去打造新的輪子滿足需求。

#### 優點
    提高開發效率：Raw SQL 不需要工程師去寫 SQL 語句開發，可以藉由 ORM 函示快速完成。
    隱欌底層細節：用 ORM 面對函式執行，不需要知道背後是那個資料庫，ORM 換轉換成各個資料庫實際的 SQL 語句。

#### 缺點
    複雜 SQL 語句：用 ORM 寫複雜的 SQL 邏輯，還是很高的門檻不易維護。
    執行效能：底層實際程式為了完成彈性功能代價是犧牲效能。
    轉移資料庫：理想上只要連線資料庫部分，修改參數即可更換資料庫，但實際還是有可能使用某個資料庫才有的功能，
              不同資料庫的核心實作理念的差異，無法預期程式執行結果會是一致的。

### 總結
    ORM 方便處理 Raw SQL 語句，簡單的 SQL ORM 處理，複雜的 SQL 一樣寫原生，使用 ORM 的優點、與規避缺點，
    這是實際開發的運用場景的選擇狀況。

---
- 備註
    <br/>
    物件關聯對映（英語：Object Relational Mapping，簡稱ORM，或O/RM，或O/R mapping）。

- 參考
    <br/>
    [維基百科- ORM](https://zh.wikipedia.org/wiki/%E5%AF%B9%E8%B1%A1%E5%85%B3%E7%B3%BB%E6%98%A0%E5%B0%84)
    <br/>
    [阮一峰-ORM 实例教程](http://www.ruanyifeng.com/blog/2019/02/orm-tutorial.html)
    <br/>
    [BRYCE'S NOTE-ORM介紹及ORM優點、缺點](http://blog.twbryce.com/what-is-orm/)
    <br/>
    [GORM 指南](https://gorm.io/zh_CN/docs/index.html)
    