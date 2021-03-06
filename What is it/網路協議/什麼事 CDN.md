# 什麼事 CDN

## 什麼事 CDN
    CDN 的功能可以提供來源端伺服器的資料，資料包含音樂、圖片、檔案、API 的回傳內容等，
    當 CDN 得到資料後會儲存一份在本地並設置超時時間，以利有重複請求查詢時可馬上提供資料。
    
    舉例 就像是總部與據點的關係，如果每次都需要去總部處理事情，當然會有人是要較遠的距離去總部，
    這樣非常的費時和費力這時候有據點在附近，可以去據點處理事情就跟去總部一樣的效果，
    CDN 等於是據點、來源伺服器等於總部。

## 為什麼需要 CDN
    如果沒有 CDN 服務，當來源伺服器建立在台灣，客戶端從較為遠的國家發起請求需較長的時間取得資料，
    有了 CDN 服務可以從較近的 CDN 查詢資料，當然第一次時間一樣較為久，但在下次一樣的請求時，
    CDN 可以馬上用本地資料回應請求，這樣可提升客戶端請求得到回應的速度，
    同時 CDN 多個後可以分散來源伺服器端的請求量，因為每個 CDN 是得到資料後再設置超時時間，
    這樣每個 CDN 超時時間不會同時間發生，實際會在來源伺服器端執行的請求就會減少。

## 總結
    CDN 會快取資料在本地加速客戶端得到請求的時間，提升查詢的速度同時會造成資料有兩份以上就有不一致的問題，
    這時只有等待 CDN 超時客戶端才會得到新的資料，或者執行清除快取的功能 CDN 才會重新取得資料，
    所以設置 CDN 快取時間多久是一個需要思考的重點，當太短則會頻繁的向來源伺服器請求，
    太長則會客戶端資料會過時太久，設置一個合理的超時時間需在效能與即時性取得一個平衡點。

---
- 備註
    <br/>
    內容傳遞網路（英語：Content Delivery Network或Content Distribution Network，縮寫：CDN）。
    <br/>

- 參考
    <br/>
    [維基百科 - 內容傳遞網路](https://zh.wikipedia.org/wiki/%E5%85%A7%E5%AE%B9%E5%82%B3%E9%81%9E%E7%B6%B2%E8%B7%AF)
    <br/>
    [CDN學習筆記一（CDN是什麼？）](https://www.itread01.com/content/1544783402.html)
    <br/>
    [30-21 之網路傳輸的加速 - CDN 與 HTTP 緩存](https://ithelp.ithome.com.tw/articles/10225276)
