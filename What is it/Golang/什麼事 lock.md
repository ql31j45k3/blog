# 什麼事 lock

## 什麼事 lock
    lock 就像一把鎖一樣，有上鎖與解鎖的功能可控制上鎖與解鎖之間的臨界區(程式區塊)，
    在兩個以上的執行緒只有上鎖成功的執行緒才可對臨界區內的程序做讀寫的操作，並達到同步得效果。

### 為什麼需要 lock
    沒有用鎖去保證臨界區內同時間只有一個執行緒做讀寫操作的話，就會發生 race condition 狀況，
    無法保證每次執行的程序結果會是ㄧ樣的，也無法保證程序是正確的執行完畢，
    所以需要用鎖去同步臨界區內只有一個執行緒可執行。

### 鎖的粒度
    粒度代表的是上鎖與解鎖的程式區塊範圍，上鎖與解鎖需要 CPU 執行與上下文切換成本，
    當鎖的粒度過大容易發生鎖的競爭與鎖的等待時間，這代表退回到單執行緒的執行，無法發揮多執行緒的功能，
    通常鎖粒度過大是最為保險，但很可能兩個執行緒實際上要操作的資料是不同的，只是因為鎖的關係而無法同時執行，
    當鎖的粒度過小會增加上鎖與解鎖的頻率，產生更多次的CPU 執行與上下文切換。

### 何時該用 channel，何時該用 lock
    需要先辨別數據的特性用途，數據是會傳遞給下一個功能使用？ 還是數據是一種狀態？
      當數據是傳遞給另一個 goroutine 使用、可能同步或異步方式得到數據，這樣就適合使用 channel 方式解決。 
    e.g. 同步第三方資料: 一個 goroutine 負責跟第三方取得 API 資料並寫入 channel，
         一個 goroutine 監聽 channel 有新資料就寫回 DB，兩個 goroutine 像流水線一樣各自運行，
         數據在過程中是傳遞方式給下一個 goroutine 使用。
      當數據是一種狀態，每次只允行一個 goroutine 修改資料，這樣就適合使用 lock 方式解決，
    e.g. 緩存或是數據的狀態從 審核中 改為 已完成審核，這樣數據的特性是只要有一個 goroutine 修改資料，
         並修改完後就其它 goroutine 只是讀取資料的動作。

## 什麼事 Mutex
    被稱為互斥鎖只有上鎖與解決功能，不管是對資料做讀或寫操作，每次只允行一個 goroutine 進行臨界區內的操作，
    而其它呼叫上鎖的 goroutine 會阻塞住被等待解鎖通知後再進行下一輪鎖的競爭，在被阻塞住的 goroutine 被喚醒做鎖競爭時
    新的 goroutine 有優勢因為本身就已在 CPU 上運行相對容易搶到鎖，這樣很可能會讓某一個 goroutine 一直搶不到鎖，這種情況被稱為飢餓。

    正常模式下的 Mutex 會依照鎖的排隊機制 FIFO 方式喚醒的 goroutine 與新的 goroutine 做鎖的競爭，
    當被喚醒的 goroutine 超過 1ms 未獲取到鎖時 Mutex 會轉為飢餓模式。
    在飢餓模式下 新的 goroutine 不做鎖的競爭直接轉入鎖的排隊機制等待，優先讓給排隊機制的隊頭 goroutine 獲取鎖，
    當被喚醒的 小於 1ms 未獲取到鎖的 goroutine 消耗完畢就轉為正常模式。

## 什麼事 RWMutex
    被稱為讀寫鎖有分為寫的上鎖與解決和讀的上鎖與解決功能，因為並不是每個進入臨界區內的操作都是修改資料，
    當只有修改資料時候才需要保證只有一個 goroutine 做操作避免 race condition 狀況，
    當只有讀資料的操作室可以允許多個 goroutine 同時間處理的，所以當資料發生寫的操作時候才會發生阻塞，
    只有讀操作不會發生阻塞。

## 什麼事 Once
    適合在多個 goroutine 執行下控制 func 執行一次的場景，
    底層結構式 Mutex 和 done，在執行 Once.Do 方法後 done 會從狀態 0 改為 1，之後執行 Do 都不會生效只有第一次執行時生效，
    但這邊有個狀況 Once.Do 接收的 func 內部如果發生 panic 或錯誤，done一樣會修改為 1，並且無法再次執行 Once.Do。

## 什麼事 atomic
    原子操作是是對一個值的互斥操作並像是原子一樣不可分割執行，底層使用 CAS 方式先比較要操作的值與參數 old 是否一樣，
    當一樣就代表值尚未被修改並允許用 new 值替換掉原本 old 值。
    CAS 被稱為樂觀鎖，原因是它並不會照成阻塞而是非阻塞的方式進行，因為比較值與修改值是一個原子操作，所以再多執行緒執行是安全的，
    atomic 是確保對一個值的並發安全，而 lock 是確保一個臨界區內的並發安全。

## 總結
    lock 是確保資料在多執行緒下執行是安全的一種手段，所謂的安全就是不會發生 race condition 狀況，
    而使用 lock 會變慢因為畢竟會造成其它未取得鎖的執行緒阻塞，而需考量鎖的粒度範圍達到解決並發安全與有效的使用鎖，
    在 Go 中提供了 Mutex、RWMutex、Once、atomic 等等數據結構，可適合不同場景下的並發安全方案。

---
- 備註
  <br/>
  競爭條件（race condition），它旨在描述一個系統或者進程的輸出依賴於不受控制的事件出現順序或者出現時機。
  <br/>
  比較並交換(compare and swap, CAS)，是原子操作的一種，可用於在多執行緒編程中實現不被打斷的數據交換操作，
    從而避免多執行緒同時改寫某一數據時由於執行順序不確定性以及中斷的不可預知性產生的數據不一致問題。
  <br/>
  樂觀鎖: 認為在數據更新同時間內並沒有其它執行緒會影響數據，並不會先組塞其它執行緒執行，而是使用某些特性在並發執行下，
    確保同時間只有一個執行緒修改資料成功，其它執行緒非阻塞但修改資料會失敗。
  
- 參考
  <br/>
  [什麼事 Goroutine、Channel](https://github.com/ql31j45k3/blog/blob/master/What%20is%20it/Golang/%E4%BB%80%E9%BA%BC%E4%BA%8B%20Goroutine%E3%80%81Channel.md)
  <br/>
  [維基百科-競爭危害](https://zh.wikipedia.org/wiki/%E7%AB%B6%E7%88%AD%E5%8D%B1%E5%AE%B3)
  <br/>
  [維基百科-比較並交換](https://zh.wikipedia.org/wiki/%E6%AF%94%E8%BE%83%E5%B9%B6%E4%BA%A4%E6%8D%A2)
  <br/>
  [Go: 关于锁（mutex）的一些使用注意事项](https://mozillazg.com/2019/04/notes-about-go-lock-mutex.html)
  <br/>
  [当我们谈论锁，我们谈什么](https://zhuanlan.zhihu.com/p/66258762)
  <br/>
  [锁粒度](https://blog.csdn.net/qq_25408423/article/details/84340432)
  <br/>
  [图解Go里面的互斥锁mutex了解编程语言核心实现源码](https://www.shuzhiduo.com/A/pRdB73ADzn/)
  <br/>
  [Go语言的原子操作和互斥锁的区别](https://segmentfault.com/a/1190000022907527)
  <br/>
  [Go并发编程里的数据竞争以及解决之道](https://mp.weixin.qq.com/s/PamOn3HGz3VHpIyGb5ZNaw)
  <br/>
  [Go精妙的互斥锁设计](https://zhuanlan.zhihu.com/p/343563412)
  <br/>
  [Golang并发：再也不愁选channel还是选锁](https://lessisbetter.site/2019/01/14/golang-channel-and-mutex/)
  <br/>
  [Golang sync包的使用](https://www.itread01.com/content/1544586482.html)
  <br/>
  [Go 语言同步原语的基石](https://jishuin.proginn.com/p/763bfbd369ce)
  <br/>
  [你真的了解 sync.Once 吗](https://zhuanlan.zhihu.com/p/270212660)
  <br/>
  [Go sync 包的使用](https://zhengyinyong.com/post/go-sync-package/)
  <br/>
  [Go语言sync包的应用详解](https://segmentfault.com/a/1190000022545889)
