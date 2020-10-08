# 什麼事 HTTP、HTTP2、HTTP3 、HTTPS

## 什麼事 HTTP
    HTTP 是應用層的協定，設計協定來作為客戶端與伺服器端請求與響應的標準格式，
    HTTP 是基於 TCP 傳輸協議的，也就是面向連結的方式請球，通過 stream 二進制流方式傳輸，底層 TCP 會將二進制轉為報文段方式傳輸給伺服器方，
    TCP 端發送報文後需要伺服器回傳 ACK 確認傳送成功，如果沒收到  ACK 回傳 TCP 會重傳保證訊息傳遞成功，
    同一個包可能傳送多次，HTTP 是無感的主要是 TCP 在處理。

## 什麼事 HTTP2
    HTTP 1.1 協議在每次傳輸需要完整的 head 資訊，並且是文本的形式傳遞，
    在傳輸的實時性、並發性是不高的，HTTP2 建立在原本的 HTTP 機制上一樣使用 TCP 協議傳輸資料，
    HTTP2 針對 head 進行壓縮，並為了並發性建立了流 + 帧的邏輯，流是 HTTP2 將一個 TCP 連結切分成多個流，
    每個流都有 ID 辨識、流是雙向的、流是一個虛擬的通道實際上還是用 TCP 傳輸、流具有優先順序，
    帧是 HTTP2 將傳送訊息分割為訊息與帧，帧有分為 head、data，head 帧用來傳送 head 資訊會開啟一個流，
    data 帧用來傳輸 Body 多個 data 帧屬於同一個流。

### 為什麼需要 HTTP、HTTP2、HTTP3
    HTTP 是為了可以讓客戶端與伺服器端的請求與回應的協定並解釋文本形式，建立起網路的通訊，
        HTTP 協定只能由客戶端發送請求伺服器只能回應無法主動傳訊資訊給客戶端，HTTP 協定只能一個 TCP 一個回應，只能串行執行回應。
    HTTP2 建立了流 + 帧的邏輯，解決 HTTP 阻塞的問題，可以一個 TCP 傳輸多個回應，
        並且可以無序的傳輸資料，透過帧首部的資訊重新在 HTTP2 組裝資料，HTTP2 針對 head 進行壓縮，HTTP head 還是文本形式傳輸會佔用頻寬。
    HTTP2 運用邏輯上的流，解決了 HTTP 阻塞的問題，但是底層還是 TCP 協議，
        當 TCP 如果未收到 ACK 還是會阻塞等待接收成功才會繼續進行，這樣的話多個流還是有先後順序的依賴問題。
    HTTP3 會使用 UDP 協議傳輸才可以解決 TCP 傳輸問題。
    HTTP3 使用 Google 定義的 QUIC 協議，QUIC 協議用 UDP 實作傳輸，並自行定義連結、重傳、多路複用、流量控制技術。

## 什麼事 HTTPS
    是 HTTP 加上 TLS 協議，進行客戶端與服務端的連結，也就是 TLS 進行加密封包、HTTP 進行通訊，連結流程看什麼事 TLS 內容。

### 為什麼需要 HTTPS
    原本用 HTTP 做為請求與回應的協議已經普及到網路世界，為了防止第三人攻擊增加了安全性傳輸，
    TLS 安全協議可以很好的與應用層任合協議進行組合使用，需要的是安全版本 HTTP 也就誕生 HTTPS 的 HTTP 版本。

### 總結
    HTTP 是網路世界開始的雛形，HTTP 解決了客戶端與伺服器端的溝通協議，
    HTTP2 為了解決 HTTP 的阻塞、head 文本格式傳輸、TCP 無法多個回應共用，
    HTTP2 用了流 + 帧的邏輯解決了以上問題與提高實時性、並發性，HTTP3 為了解決 HTTP2 採用 TCP 阻塞的問題，而被發明出新的協議，
    並採用 UDP 協議為基礎，HTTPS 是提供一個安全加密的 HTTP 版本。

---
- 備註
    <br/>
    超文本傳輸協定（英語：HyperText Transfer Protocol，縮寫：HTTP）是一種用於分佈式、協作式和超媒體訊息系統的應用層協定。HTTP是全球資訊網的數據通信的基礎。
    <br/>
    超文本傳輸安全協定（英語：HyperText Transfer Protocol Secure，縮寫：HTTPS；常稱為HTTP over TLS、HTTP over SSL或HTTP Secure）是一種透過計算機網路進行安全通訊的傳輸協定。
    <br/>
    TCP 是一種連接導向的、可靠的、基於位元組流的傳輸層通信協定。
    <br/>
    報文段：每個 TCP 報文段中都有一對序號和確認號。

- 參考
    <br/>
    [維基百科-HTTP](https://zh.wikipedia.org/wiki/%E8%B6%85%E6%96%87%E6%9C%AC%E4%BC%A0%E8%BE%93%E5%8D%8F%E8%AE%AE)
    <br/>
    [維基百科-HTTPS](https://zh.wikipedia.org/wiki/%E8%B6%85%E6%96%87%E6%9C%AC%E4%BC%A0%E8%BE%93%E5%AE%89%E5%85%A8%E5%8D%8F%E8%AE%AE)
    <br/>
    [維基百科-TLS](https://zh.wikipedia.org/wiki/%E4%BC%A0%E8%BE%93%E6%8E%A7%E5%88%B6%E5%8D%8F%E8%AE%AE)
    <br/>
    [点滴积累-网络协议 — HTTP](http://zhongmingmao.me/2019/07/26/network-protocol-http/)
    <br/>
    [点滴积累-网络协议 — HTTPS](http://zhongmingmao.me/2019/08/05/network-protocol-https/)
    