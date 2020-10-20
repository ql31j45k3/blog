# 什麼事 Heap、Stack

## 什麼事 Heap
    heap 存放全局變數或跨多個函數使用的共享資料並要注意線程安全的問題，heap 存放資料的生命週期不會由函數執行完畢回收，
    生命週期並沒有特定規律，為了避免一直增加造成 memory leak 狀況，GC 會在背景執行掃描資料是否已經沒在被使用進行垃圾的回收。

## 什麼事 Stack
    stack 存放是函數內的宣告的變數只有函數自己使用並且是線程安全的由 OS 層設計上保證的，
    stack 存放資料的生命週期當函數執行完畢時就收回。

### 為什麼需要 Heap、Stack
    資料特性當中有的是短暫使用、有的是永久保存或需要共享資料一段時間，並且每次呼叫函數要每個都是不同份資料不然會導致邏輯錯誤，
    基於資料的特性與實際上內存也有硬體上的上限限制，設計出一個適合放全局資料和共享資料、一個適合當下函數內邏輯處理暫存的資料，
    Go 語言為了讓開發人員降低開發上的心智，設計出逃逸分析的功能由編譯期間分析程式判斷資料該放入 heap 或 stack，
    不需讓開發人員思考我使用的語法會把資料放入 heap 或 stack，將專注力在開發邏輯上。

### 總結
    heap 和 stack 是基於資料生命週期、使用場景的不同而有各自職責，Go 有逃逸分析的功能決定資料該放入 heap 或 stack，
    heap 雖然可以跨越多個函數使用的資料要注意線程安全、memory leak 等問題，而為了避免 memory leak 通常會有 GC 去解決，
    但線程安全部分就需要開發人員自行注意，Go 語言提供工具可以進行檢測程式線程安全的狀況。

---
- 備註
    <br/>
    heap：台灣稱為堆積，大陸稱為堆。
    <br/>
    stack：台灣稱為堆疊，大陸稱為棧。
    
- 參考
    <br/>
    [三種記憶體區間: global、stack、heap](http://wp.mlab.tw/?p=312)
    <br/>
    [[探索 5 分鐘] stack 與 heap 的底層概念](https://nwpie.blogspot.com/2017/05/5-stack-heap.html)
    <br/>
    [記憶體 - stack 與 heap](https://ithelp.ithome.com.tw/articles/10218781)
    <br/>
    [【golang】变量的stack/heap分配与逃逸分析不解之情](https://www.jianshu.com/p/8a80d50d2f9c)
    <br/>
    [【golang】变量的stack与heap分配](https://studygolang.com/articles/28010)
    