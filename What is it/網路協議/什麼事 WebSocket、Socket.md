# 什麼事 WebSocket、Socket

## 什麼事 WebSocket
    是一種網路協議 模擬 Socket 協議，建立在 TCP 連結上做的全雙工通訊，可以一次交握瀏覽器和伺服器就完成通信，
    它是一個長連結 允許伺服器端主動傳送資料，位於在 OSI 模型的應用層，WebSocket 是屬於伺服器推送技術一種。

### 為什麼需要 WebSocket
    因為瀏覽器想即時得到最新的資料，只有用 HTTP 不同的輪詢可以獲取，這當中有很多次請求是無效的操作，
    用 WebSocker 伺服器端異動資料，可以主動通送資料道溜覽器端達成即時傳送訊息，效益更好。
    
### 為什麼 WebSocket 可以主動推送，HTTP 不行
    因為 HTTP 本身協議上的限制，伺服器無法主動向 Client 傳送 (HTTP 只能由客戶端發起通信)，
    HTTP 本身協議是客戶端對伺服器端請求與應答機制，WebSocket 用 HTTP 握手階段使用，
    之後傳輸資料都透過 TCP 傳輸層處理。

#### 優點
    長連結：因為建立連結是有狀態的，後續傳輸資料可減少狀態資訊，封包更小 傳送更訊息 (狀態資訊舉例身份認證)。
    擴充：可以支援擴充，用戶端可以擴充協定。
    實時性：全雙工的特性具有更強的即時通訊能力。
    較少的控制開銷：建立的連線是有狀態的，在後續的 header 資料較於 HTTP 更少的資料，因為不需要每次給完整的 header 資訊。

### 什麼事 Socket
    方便使用 TCP or UDP 傳輸層協議而抽象出一層介面，隱藏底層的細節為兩個節點的溝通機制概念。

### 為什麼需要 Socket
    Socket 是作業系統提供的行程間的通訊機制，讓兩台主機藉由 Socket 連線並傳送資料。

### 總結
    WebSocket 建立在 TCP 上傳送資料，是一種全雙工通訊，可伺服器主動傳送資料給瀏覽器，解決 HTTP 做不到的場景。
    WebSocket 交握使用 HTTP 完成，因 HTTP 是網際網路最普及的基礎設施，但 WebSocket 不限於用 HTTP 交握符合協議，任何端口都可進行交握。
    WebSocket 是應用層協議，Socket 是一組介面介於應用層與傳輸層之間，隱藏底層的細節為兩個節點的溝通機制概念。

---
- 備註
    <br/>
    Socket （英語：Network socket；又譯網路插座、網路介面、網路插槽）。
    <br/>
    交握/握手：為了進行連結 瀏覽器一方請求連線，伺服器一方回應請求過程。
    <br/>
    應用層：應用程式的溝通協定，也可以理解為不同應用程式如何協同工作。
    <br/>
    傳輸層：定義點到點如何傳輸。
    
- 參考
    <br/>
    [維基百科 WebSocker](https://zh.wikipedia.org/wiki/WebSocket/)
    <br/>
    [維基百科 OSI 模型](https://zh.wikipedia.org/wiki/OSI%E6%A8%A1%E5%9E%8B)
    <br/>
    [維基百科 HTTP 協定](https://zh.wikipedia.org/wiki/%E8%B6%85%E6%96%87%E6%9C%AC%E4%BC%A0%E8%BE%93%E5%8D%8F%E8%AE%AE)
    <br/>
    [維基百科 Socket](https://zh.wikipedia.org/wiki/%E7%B6%B2%E8%B7%AF%E6%8F%92%E5%BA%A7)
    <br/>
    [教學｜用傳紙條輕鬆入門 WebSocket](https://medium.com/dezchuang/rookie-to-learn-websocket-cfc7b172daa3)
    <br/>
    [程式前沿-WebSocket介紹，與Socket的區別](https://codertw.com/%E7%A8%8B%E5%BC%8F%E8%AA%9E%E8%A8%80/603007/)
    <br/>
    [阮一峰的网络日志-WebSocket 教程](http://www.ruanyifeng.com/blog/2017/05/websocket.html)
    <br/>
    [全双工通信的WebSocket - 冰霜之地](https://halfrost.com/websocket/)
    <br/>
    [Socket 的哩哩扣扣– 拿鐵派的馬克Blog](https://mark-lin.com/posts/20170910/)
    