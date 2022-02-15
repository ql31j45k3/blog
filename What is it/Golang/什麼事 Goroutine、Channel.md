# 什麼事 Goroutine、Channel

## 什麼事 Goroutine
    Go 語言提供的協程，故稱呼為 goroutine，是 Go 語言提供的一個並發執行的功能，
    相對於其他使用 thread 完成並發 goroutine 更輕量、開銷小、調度切換成本更低，
    可以理解成在 Go 語言層自行時做了 thread，無需依賴 OS 系統執行調度 Go 語言自行實作調度器、
    切換的成本更低原因是不需要用戶狀態切到內核狀態，所以只需要三個寄存器的成本。

### 為什麼需要 Goroutine
    並發模型有三種用戶級線程模型、內核級線程模型、兩級線程模型 (MPG)，Go 語言選擇實作 MPG 為並發模型，
    提供更好的並發效能，將多核 CPU 效能的利用率提高最高，Go 語言用 goroutine 開發網路伺服器的底層處理 API 請求與回應，
    使用 Half-Sync/Half-Async 模式實作網路輪播器，此模式集結了 同步 I/O 模型、異步 I/O 模型，
    底層用 I/O 多路復用方式高效的處理網路 I/O，為了讓使用者端避免陷入 callback 方式理解程序的行為，
    在使用者端封裝成同步的方式調用，大大降低心智，所以用同步的調用方式就實現異步的程序功能。

#### 優點
    輕量：內存只需要 2KB 空間。
    調度性能好：不需要經過內核進行調度，上下文的資料保存切換寄存器成本更低，只需要切換 PC、 SP、 DX。

## 什麼事 Channel
    負責 goroutine 之間傳遞資料是進程內的通訊方式有先進先出的特性，可以宣告無緩衝、有緩衝的類型，
    有緩衝代表可以在 channel 儲存資料的空間，適合傳遞流動的數據類型，例如計算各個公式的結果最後再進行加總，
    每個公式的答案可以獨立計算互不影響，最後在一起加總，比傳統用鎖處理更加高效，非常適合 CPU 密集型的任務。

### 為什麼需要 Channel
    在進程之間需要有方法傳遞資料，使用傳統方式將資料放在內存，並發取得資料必須用鎖解決競爭條件的狀況過於低效，
    鎖搭配隊列的數據結構更適合數據的流動與傳遞，這就是 CSP 概念不要通過共享內存來通信，而是通過通信來實現內存共享。

#### 優點
    FIFO：先進先出的特性，易於理解程序的執行狀況。
    緩衝：有緩衝的特性可以儲存一定空間的資料，讓 goroutine 利用率更高、避免阻塞的等待。

### 總結
    同步、異步指的是消息通知方式，阻塞、非組塞指的是等待消息的行為。
    goroutine、channel 是 Go 語言提供的一種並發處理資料的模式，可以更高效的使用多核 CPU 性能。
    Go 語言提供的協程，故稱呼為 goroutine，是 Go 語言提供的一個並發執行的功能。
    channel 負責 goroutine 之間傳遞資料是進程內的通訊方式有先進先出的特性。

---
- 備註
    <br/>
    CSP：不要通過共享內存來通信，而是通過通信來實現內存共享。
    <br/>
    並發（Concurrency）：同時間處理多個事情的能力 / 邏輯上具備處理多個任務的能力。
    <br/>
    並行（Parallelism）：同時間執行 / 物理上同時執行多個任務。
    <br/>
    同步：發起一個調用後，調用者等待結果的通知，才可執行後續行為。
    <br/>
    異步：發起一個調用後，無需等待結果的通知，繼續執行後續行為，通知方式可以有兩種 主動輪詢調用的結果、被調用的提供 callback 方式將結果通知回調用方。
    <br/>
    阻塞：發出調用後，在消息返回前線程會被掛起，直到有消息返回，線程才會被喚醒。
    <br/>
    非阻塞：發出調用後，直接返回，不會將線程掛起。
    <br/>
    I/O 多路復用：多個 I/O 復用一個線程，實作採用非阻塞的模式，這樣可以一個線程處理多個事情。
    <br/>
    線程：OS 系統執行的做小單位，可以在進程中切換多個線程達到多工的效果。
    <br/>
    用戶級線程模型：多個用戶線程對應一個內核線程，線程相關操作需自行實現但切換速度快，不能有效使用多核 CPU 效能。
    <br/>
    內核級線程模型：一個用戶線程對一個內核線程，線程相關操作由內核處理，有利用多核 CPU 效能，但切換成本高。
    <br/>
    兩級線程模型 (MPG)：此模型綜合以上兩個模型得優點，多個用戶線程對多個內核線程，充分利用多核 CPU ，並自行實作線程相關操作與調度，但實現複雜與難度高。
    <br/>
    Ｇ：為 Goroutine，一個輕量級的線程。
    <br/>
    Ｐ：代表處理器，可以理解由它處理獲取 G、M 完成調度所需要的資源、控制流程。
    <br/>
    Ｍ：代表一個內核線程。

- 參考
    <br/>
    [Go goroutine理解](https://zhuanlan.zhihu.com/p/60613088)
    <br/>
    [Tony Bai-Goroutine是如何工作的](https://tonybai.com/2014/11/15/how-goroutines-work/)
    <br/>
    [Tony Bai-也谈并发与并行](https://tonybai.com/2015/06/23/concurrency-and-parallelism/)
    <br/>
    [Go并发原理](https://i6448038.github.io/2017/12/04/golang-concurrency-principle/)
    <br/>
    [Golang 之协程详解](https://www.cnblogs.com/liang1101/p/7285955.html)
    <br/>
    [同步、异步、阻塞与非阻塞](https://segmentfault.com/a/1190000014644776)
    <br/>
    [通俗讲解 异步，非阻塞和 IO 复用](https://www.zybuluo.com/phper/note/595507)
    <br/>
    [深度解密Go语言之channel](https://zhuanlan.zhihu.com/p/74613114)
    <br/>
    [鸟窝-Go并发设计模式之 Half-Sync/Half-Async](https://colobu.com/2019/07/21/concurrency-design-patterns-half-sync-half-async/)
    <br/>
    [Go 语言设计与实现-6.4 Channel](https://draveness.me/golang/docs/part3-runtime/ch06-concurrency/golang-channel/)
    <br/>
    [Go 语言设计与实现-6.6 网络轮询器](https://draveness.me/golang/docs/part3-runtime/ch06-concurrency/golang-netpoller/)
    