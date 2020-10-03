# 什麼事 gRPC

## 什麼事 RPC
    遠端程序呼叫是一種電腦通訊協定，該協定允許一台主機上運行的程序呼叫另一台主機的子程序，
    客戶端無需做額外發起連線、解碼等操作，就像是呼叫本地程式函式一樣，RPC 架構需要四個元件 Client、Client Stub、Server、Server Stub。

### RPC 流程
    Client 呼叫 Client Stub，將參數存入 stack 中
    Client Stub 將參數序列化為 e.g. XML、JSON、二進位
    Client 作業系統傳訊資料道 Server (舉例 通過 HTTP 傳輸)
    Server 作業系統接收到 Client 資料並傳送到 Server Stub
    Server Stub 反序列化得到資料
    Server Stub 依照資料呼叫 Server 程序執行

    Server 執行完畢，把結果回傳給 Server Stub
    Server Stub 將結果序列化為 e.g. XML、JSON、二進位
    Server 作業系統傳送資料回 Client (舉例 通過 HTTP 傳輸)
    Client 作業系統接收 Server 回傳結果，傳送到 Client Stub
    Client Stub 反序列化得到資料
    Client 收到呼叫程序後的執行結果

## 什麼事 gRPC
    Google 開源的 RPC，該系統基於 HTTP/2 協定傳輸，使用 Protobuf 作為序列化資料結構並且是一個介面描敘語言，
    可用 Protobuf 作為描敘函示等方法，可轉成不同語言作為跨語言的溝通方式。

### 為什麼需要 gRPC
    因為開發 RESTful API 提供給 Client 呼叫需開發 SDK，並且 API 相容性有破壞性修改 API Router 會修改，
    這時雙方端都須更新程式，使用 gRPC 技術針對相容性部分，只要符合約定不刪除舊的欄位就會向下相容，
    可用 Protobuf 自動產生 Client、Server 程式。

#### 優點
    跨平台：使用 RPC 協定可以擁有遠端呼叫程序的特性。
    跨語言：用 Protobuf 中介語言可產生不同語言程式。
    高性能：底層傳輸使用 HTTP/2 協議更好的效能、 Protobuf 有更好的壓縮性能。
    相容性：符合 Protobuf 約定不刪除欄位，即可同時支援舊版本與新版本。

#### 缺點
    生態成熟度：缺乏相關調試或周邊工具、針對 WEB 場景不足。

### 總結
    gRPC 可自動產生 SDK，支援多種語言。
    gRPC 底層 HTTP/2 協定傳輸擁有 全雙工通訊、同一 TCP 連結多路復用、流（Stream）特性。
    符合 Protobuf 約定不刪除欄位，即可同時支援舊版本與新版本。

---
- 備註
    <br/>
    gRPC 全名 google Remote Prodecure calls (遠端程序呼叫)。
    <br/>
    行程間通訊（IPC，Inter-Process Communication，至少兩個行程或執行緒間傳送資料或訊號的通訊方法。
    <br/>
    序列化 （serialization）是指將資料結構或物件狀態轉換成可取用格式，以留待後續在相同或另一台計算機環境中，能恢復原先狀態的過程。
    <br/>
    介面描述語言（Interface description language，縮寫IDL）IDL通過一種中立的方式來描述接口，使得在不同平台上運行的對象和用不同語言編寫的程序可以相互通信交流。
    <br/>
    Client Stub 及 Server Stub，就必須依賴 proto 檔來產生。

- 參考
    <br/>
    [維基百科-IPC](https://zh.wikipedia.org/wiki/%E8%A1%8C%E7%A8%8B%E9%96%93%E9%80%9A%E8%A8%8A)
    <br/>
    [維基百科-RPC](https://zh.wikipedia.org/wiki/%E9%81%A0%E7%A8%8B%E9%81%8E%E7%A8%8B%E8%AA%BF%E7%94%A8)
    <br/>
    [維基百科-GRPC](https://zh.wikipedia.org/wiki/GRPC)
    <br/>
    [維基百科-Protocol Buffers](https://zh.wikipedia.org/wiki/Protocol_Buffers)
    <br/>
    [維基百科-序列化](https://zh.wikipedia.org/wiki/%E5%BA%8F%E5%88%97%E5%8C%96)
    <br/>
    [維基百科-HTTP/2](https://zh.wikipedia.org/wiki/HTTP/2)
    <br/>
    [Microsoft Docs](https://docs.microsoft.com/zh-tw/dotnet/architecture/cloud-native/grpc)
    <br/>
    [軟體主廚的程式料理廚房-[料理佳餚] 除了 Web API 之外的新選擇 - gRPC 服務](https://dotblogs.com.tw/supershowwei/2019/10/07/090708)
    <br/>
    [Jiajun的编程随想-为什么要使用gRPC？](https://jiajunhuang.com/articles/2019_12_27-why_grpc.md.html)
    <br/>
    [Jiajun的编程随想-为什么gRPC难以推广](https://jiajunhuang.com/articles/2019_09_29-why_grpc_is_not_popular.md.html)

- 範例
<br/>
```
    syntax = “proto3”
    package order
    
    service orderDetail {
        rpc GetOrderDetail(orderRequest) returns (orderResponse);
    }
    
    message orderRequest {
        Int32 id = 1;
        String name = 2;
    }
    
    message orderResponse {
        Bool isSuccess = 1;
    |
```