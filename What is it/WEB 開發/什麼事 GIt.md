# 什麼事 Git

## 什麼事 Git
    它是一個版本控制系統，並且是一個分散式的版本控制系統，版本控制系統指的是記錄檔案、資料夾的異動紀錄，
    方便查詢整個異動紀錄並且將檔案、資料夾還原到某個異動的時間點，分散式指的是每個電腦都是獨立的服務並可獨立運行所有功能，
    做 Git 操作只要第一次取得 Repo 資料後，後續在沒有網路的環境也可以持續作業，
    只要在某個時間點同步資料即可，不會因為沒有網路而無法進行版本控制。

### 為什麼需要 Git
    程式開發需要一個版本控制紀錄檔案、資料夾的異動，隨時可以還原到某個時間點的狀態與查詢異動紀錄的訊息，
    當中版本控制系統 Git 是普及度最高的，Git 基於分散式的架構解決傳統集中式架構的問題，
    傳統集中式必須一定要有網路才可執行版本控制。

#### 優點
    開源：普及度高、有許多使用者、社群活躍度也非常棒。
    速度快：其他版本控制系統每次紀錄檔案得異動，當要回覆某個時間點是非常耗時間，
           Git 則是記錄版本異動之外也對每個檔案做快照儲存整個目錄、檔案的樹狀結構，沒有異動的檔案則會指向之前的版本。
    分散式：每台電腦都是獨立運行，在某個時間點同步資料、沒有網路環境一樣正常執行版本控制。

---
- 備註
    <br/>

- 參考
    <br/>
    [維基百科-Git](https://zh.wikipedia.org/wiki/Git)
    <br/>
    [TechBridge-Git 與 Github 版本控制基本指令與操作入門教學](https://blog.techbridge.cc/2018/01/17/learning-programming-and-coding-with-python-git-and-github-tutorial/)
    <br/>
    [為你自己學 Git-什麼是 Git？為什麼要學習它？](https://gitbook.tw/chapters/introduction/what-is-git.html)
    <br/>
    [【工程師必懂的版本控制技術】什麼是GitHub?](https://medium.com/@makerincollege2018/%E5%B7%A5%E7%A8%8B%E5%B8%AB%E5%BF%85%E6%87%82%E7%9A%84%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6%E6%8A%80%E8%A1%93-%E4%BB%80%E9%BA%BC%E6%98%AFgithub-376421fd871d)
    