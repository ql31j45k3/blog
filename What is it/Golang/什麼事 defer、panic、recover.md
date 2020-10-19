# 什麼事 defer、panic、recover

## 什麼事 defer
    是 Go 提供的一個關鍵字，可以在函數結束時執行的功能，擅長處理關閉資源場景這樣就不用在函數內多個回傳前重複做一樣的事情，
    defer 有幾個特性：函數結束時執行、預計算執行參數、多個 defer 後進先出，
    要注意到實際上回傳是兩個步驟，所以 defer 是在塞好回傳參數後再執行邏輯，最後才執行結束函數，
    如果要影響回傳參數的話，一種是回傳參數是有名字的、回傳參數是 point 類型的。

### 為什麼需要 defer
    一般函數會有多個回傳點，另外通常回傳前需要做些關閉資源動作，有了 defer 就可以統一處理避免忘記關閉資源，
    撰寫程式的清晰度也會上升，因為在取得資源下一行就可以撰寫關閉資源邏輯，defer 除了上述場景外在 Go 當中扮演另一個重要角色，
    發生 panic 事件時候可以執行異常處理的捕捉語法 recover，讓異常流程終止轉為正常的執行流程避免服務崩潰，
    但 defer 不代表絕對可以攔截著所有異常，底層針對一些場景觸發的異常是無法捕捉後改為不崩潰的場景，
    如 map 並發讀寫。

## 什麼事 panic
    Go 提供終止服務的一個關鍵字，可以讓程式有序執行 defer 在呼叫 os.Exit 函數關閉程式，
    在程式端或底層發生重要的場景，並且不應該繼續執行下去才使用 panic ，服務最重要參數或 channel 關閉兩次。

### 為什麼需要 panic
    錯誤場景內會區分成參數或是邏輯錯誤，但也會有更重要的場景只要遇到服務就不應該正常執行下去的邏輯，
    panic 就是 Go 語言異常關閉服務流程的功能。

## 什麼事 recover
    有終止服務的功能，就會有阻止的相反功能 recover 就是讓 panic 原本會崩潰服務改為正常繼續執行的部分，
    recover 底層會修改狀態為代表 panic 以處理過，讓 panic 改走回正常流程繼續讓服務運行。

### 為什麼需要 recover
    panic 是觸發異常讓服務終止，但實際上服務該怎麼處理權責給程式開發人員決定，提供一個機制可以阻止 panic 不讓服務停止，
    但可以取得 panic 原因讓開發人員後續做處理，異常是一個比錯誤還要嚴重的場景，所以語言提供另一個關鍵字處理異常的流程。

### 總結
    panic 發生時會獲取當前的 goroutine 並把所有 defer 執行，如果執行當中在 defer 內有 recover，
    就將當前的 panic 改為以處理過，回覆正常流程依序執行完 defer 後服務繼續執行，如果沒有 recover 就終止服務，
    會將最後 panic 訊息與依序呼叫的函數關係打印出來。
    
    panic、recover 是一個成對的關鍵字，發生 panic 有 recover 可以阻止它，實際流程上 panic 發生時唯一會執行的只剩下
    defer 保證函數結束時才執行的程式，所以 recover 只有在 defer 內才有效果， defer 就扮演一個協調的角色，
    我是最後執行的部分，如果當中有 recover 事件 panic 你就不要讓服務終止吧，讓我執行完後服務繼續維持。

---
- 備註

- 參考
    <br/>
    [Go 语言设计与实现 - 5.3 defer](https://draveness.me/golang/docs/part2-foundation/ch05-keyword/golang-defer/)
    <br/>
    [Go 语言设计与实现 - 5.4 panic 和 recover](https://draveness.me/golang/docs/part2-foundation/ch05-keyword/golang-panic-recover/)
    <br/>
    [跟煎鱼学 Go - 6.2 defer](https://eddycjy.gitbook.io/golang/di-6-ke-chang-yong-guan-jian-zi/defer)
    <br/>
    [跟煎鱼学 Go - 6.1 panic and recover](https://eddycjy.gitbook.io/golang/di-6-ke-chang-yong-guan-jian-zi/panic-and-recover)
    