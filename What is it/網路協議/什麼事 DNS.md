# 什麼事 DNS

## 什麼事 DNS
    DNS 是一個管理域名對應到 IP 的系統，域名就像公司名稱是一個網站對外的稱呼，IP 就像是公司地址實際網站的主機位址，
    例如 輸入域名 「www.google.com」 透過 DNS 得到 IP 「74.125.19.147」，
    使用瀏覽器 (Google Chrome) 輸入域名 DNS 回傳 IP 給瀏覽器，瀏覽器連到 IP 取得網站內容顯示給使用者，
    這就是上網背後的處理流程。

## 為什麼需要 DNS
    IP 是一組數字的集合代表主機的位址，並不適合使用者記憶，用一組名稱更易於記憶，主機位址是有可能異動的就像公司會換新的地址一樣，
    一旦換新的主機 IP 也會隨者更換這樣使用者就無法找到網站，如果有一個角色 (DNS) 負責管理 網站名稱與主機 IP 的關係，
    這樣不管主機如何更換都不在讓使用者找不到網站，這就是需要 DNS 的原因。
    
## DNS 如何運作
    DNS 是一個去中心化的分布式系統並使用樹狀結構的設計
    - 第一層為 Local DNS
      為 ISP (Internet Service Provider) 如中華電信，功能主要負責查找 IP 過程中的代理角色，
      使用者只要對代理角色發出查詢請求，域名背後的複雜架構對於使用者是不透明的，
      使用者與 Local DNS 之間的查詢為遞迴解析，解析成功後會將查詢儲存為快取紀錄，以利下次快速查找資料。
    - 第二層為 Root DNS (.)
      作為作源頭的 DNS，並沒有紀錄 域名與 IP 關係，是作為提供 Local DNS 發送查詢請求時，
      分析域名為那個 TLD DNS 管理的範圍，這個查詢過程為送代解析。
    - 第三層為 TLD DNS (.com、.net、.org)
      此 DNS 也無紀錄域名與 IP 關係，但此角色管理實際有儲存 域名與 IP 關係的 DNS 清單，
      當 Local DNS 過來查詢時會提供實際管理域名的 DNS 位置。
    - 第四層為 Authoritative DNS (XXX.com)
      負責維護域名與 IP 關係，並且需讓域名在此 DNS 管理範圍內具有唯一性。
    
    例如 查找域名 「www.google.com」
    使用者(1) -> Local DNS(2) <-> Root DNS (3)
                Local DNS(4) <-> TLD DNS (5)
                Local DNS(6) <-> Authoritative DNS (7)
    使用者(9) <- Local DNS(8)
    
    (1) 發送 google.com 查找請求
    (2) 確認本地快取紀錄，如無此紀錄向 Root DNS 查找
    (3) 分析域名為那個 TLD DNS 管理，google.com，回傳 TLD DNS 位置
    (4) 得到 TLD DNS 位置，發起新的請求給 TLD DNS
    (5) TLD DNS 分析域名為那個 Authoritative DNS 管理 google.com 位置，回傳 Authoritative DNS 位置
    (6) 得到 Authoritative DNS 位置，發起新的請求給 Authoritative DNS
    (7) 解析 google.com 取得 IP 值，回傳 google.com 的 IP 結果
    (8) 得到 google.com 的 IP，將這次查找紀錄到快取內，回傳給使用者 IP 位置
    (9) 使用者得到 IP 位置
    
## 為什麼用 DNS 解析過程中有遞迴解析與送代解析
    遞迴解析是會重複發起查詢請求等於代替使用者對 DNS 發起新的查詢請求，直到查找到結果為止。
    送代解析是提供客戶端更接近知道實際儲存 IP 位置的 DNS 位置，客戶端會在對下一個 DNS 發送請求得到下一個 DNS 位置。
    
    用遞迴解析是 Local DNS 代替使用者重新發送域名查找的請求，對使用者隱蔽 DNS 分布式的架構，
    用送代解析是Root DNS、TLD DNS 作為提供下一個 DNS 位置，負責管理 DNS 層級關係，
    直到查找到 Authoritative DNS 才有實際儲存 IP 位置內容。

## 為什麼區域傳輸用 TCP 協議、域名解析用 UDP 協議
    區域傳輸過程是 DNS 服務之間數據同步，需傳送大量資料與可靠性，在此場景適合使用 TCP 協議。

    域名解析過程是需向多台 DNS 服務查詢與資料量傳輸小，如果用 TCP 協議還需每台 DNS 服務建立三次握手連接流程，
    在此場景適合 UDP 協議廣播發送與不需建立連接即可傳送數據。

## 總結
    DNS 是一個分佈式去中心化設計架構，並在架構設計中設計樹狀結構與各角色的職責，
    在整個流程當中以為只有使用 UDP 協議，實際上主要是用 UDP 協議做 IP 查找，
    在 DNS 區域傳輸則使用 TCP 協議傳送資料，實際上 DNS 是同時佔用 UDP 和 TCP 53 Port。

---
- 備註
    <br/>
    DNS 全名為 Domain Name System。
    <br/>
    網際網路名稱與數字位址分配機構（Internet Corporation for Assigned Names and Numbers），
    簡稱ICANN目的是接管包括管理域名和IP位址的分配等與網際網路相關的任務。
    <br/>

- 參考
    <br/>
    [詳解 DNS 與 CoreDNS 的實現原理 - 面向信仰編程](https://draveness.me/dns-coredns/)
    <br/>
    [為什麼 DNS 使用 UDP 協議 - 面向信仰編程](https://draveness.me/whys-the-design-dns-udp-tcp/)
    <br/>
    [DNS區域轉移](https://en.wikipedia.org/wiki/DNS_zone_transfer)
    <br/>
    [域名系統（DNS）101—網址的小旅行](https://medium.com/%E5%BE%8C%E7%AB%AF%E6%96%B0%E6%89%8B%E6%9D%91/%E5%9F%9F%E5%90%8D%E7%B3%BB%E7%B5%B1-dns-101-7c9fc6a1b8e6)
    <br/>
    [老生常談-從輸入url到頁面展示到底發生了什麼](https://www.itread01.com/lpihkx.html)
    <br/>
    [維基百科 - 網際網路名稱與數字位址分配機構](https://zh.wikipedia.org/wiki/%E4%BA%92%E8%81%94%E7%BD%91%E5%90%8D%E7%A7%B0%E4%B8%8E%E6%95%B0%E5%AD%97%E5%9C%B0%E5%9D%80%E5%88%86%E9%85%8D%E6%9C%BA%E6%9E%84)
    <br/>
    [計算機網絡 | 圖解 DNS & HTTPDNS 原理](https://juejin.cn/post/6884183177926033416)
    <br/>
    [DNS 除錯教學系列文章(1) – DNS 入門](https://haway.30cm.gg/dns-1-basic/)
    <br/>
    [DNS 除錯教學系列文章(2) – DNS 架構](https://haway.30cm.gg/dns-2-dns/)
