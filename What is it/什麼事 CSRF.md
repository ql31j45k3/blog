# 什麼事 CSRF

## 什麼事 CSRF
    是一種利用 Session & Cookie 認證機制的攻擊，一般在網站上登入後會將 Session 相關資訊寫入瀏覽器的 Cookie，
    在下次做 HTTP 請求時瀏覽器會自動將 Cookie 帶入，HTTP 是無狀態藉由瀏覽器的 Cookie 儲存 Session 資訊，
    在每次 HTTP 請求服務端才可認證身份，但今天在這個機制下瀏覽器會自動將 Cookie 資訊帶入 HTTP 請求，
    服務端是確認 Session 資訊是不是正確的，這邊會有一個無法驗證的問題，問題是這次請求是使用者發起的還是有惡意的行為偷偷發起請求。
    
    今天在其它網站用圖片或網站其它 DOM 元素進入網站後會執行資運的載入，此時圖片因為被載入會執行一個網路請求，
    如果這時候使用者瀏覽器 Cookie 儲存的 Session 還在有效期內，就可以讓使用者不知情的情況下假冒使用者發起一個請求造成攻擊成功。
    ```
        <img src="http://domain" />
    ```

### 如何防禦 CSRF
    確認是本身網域發起的請求，而不是跨網域的發起的請求，「擋掉跨網域來的請求」。
    
    Check Referer：
        檢查 HTTP Header 的 Referer 的值，可以知道是那個網域發起的，但可能有瀏覽器被使用者關閉此功能或不支援的情況，
        在程式檢查邏輯是判斷 Referer 的值是不是包含某個值，這樣遇到前綴部分一樣再加上其它英文名字註冊的網域一樣會無法阻擋，
        此解法並不是很完善的解法。
    CSRF Token：
        由伺服器端隨機送出一組 CSRF Token，再發起請求時候加上這組 CSRF Token，這代表的是只有本身網域才可獲得 Token，
        其他人無法仿造出來，就可以識別是攻擊者發起或使用者發起請求，實際程式做法上的差異可以延伸出 Double Submit Cookie、Double Submit Cookie 等方法。
    SameSite Cookie：
        瀏覽器提供的功能，可以控制 Cookie 判斷不是同個 site 底下發出的請求，就不自動帶入 Cookie。
    
## 總結
    CSRF 是利用跨領域的請求加上使用者剛好是登入中的狀態，讓使用者在不知情的狀況下達成的攻擊，
    防禦的主要概念是如何阻擋跨領域的請求，只要加上本身網域才知道的資訊，跨領域無法得到得資訊，就能識別出攻擊者與使用者，
    目前最通用的解法是加上 CSRF Token 並在服務端驗證 Token 是不是伺服器端產生的，
    並且要正確設置好 CSRF Token，如果一樣儲存在 Cookie 讓瀏覽器自動帶入或破解出 Token 產生邏輯一樣會阻擋失敗。

---
- 備註
    <br/>
    CSRF 全名是 Cross-site request forgery。

- 參考
    <br/>
    [前端三十｜29. [WEB] 網站常見的資安問題有哪些？](https://medium.com/schaoss-blog/%E5%89%8D%E7%AB%AF%E4%B8%89%E5%8D%81-29-web-%E7%B6%B2%E7%AB%99%E5%B8%B8%E8%A6%8B%E7%9A%84%E8%B3%87%E5%AE%89%E5%95%8F%E9%A1%8C%E6%9C%89%E5%93%AA%E4%BA%9B-bc47b572d94d)
    <br/>
    [讓我們來談談 CSRF - Huli](https://blog.huli.tw/2017/03/12/csrf-introduction/)
    <br/>
    [CSRF攻击原理及防御](https://zhuanlan.zhihu.com/p/34862370)
    