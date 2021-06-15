# 什麼事 interface、reflection

## 什麼事 interface
    是一種抽象類型，定義好一組方法名字、帶入參數與回傳值的規範，在 Go 中 interface 是非侵入式的，
    不需要在語法上顯示的宣告實作了什麼 interface，在編譯期間會效驗是否有符合 interface 的所有方法，
    如果有代表此 struct 實作出這一個 interface。

    interface 是抽象類型，隔離了具體實作類型，等於在使用端與實作端多了一個中間層，
    解偶使用端與實作端的耦合，這樣實作端切換不同實作類型也不影響使用端。

### 為什麼需要 interface
    interface 可以隔離使用端與實作端的耦合，這樣程式可有彈性的方式執行，
    將會變動的邏輯抽象出一組方法，使用端就不會因為實作端的變動被影響需要修改。

    如購物車結帳：程式會定義好 interface，在使用端會依照業務邏輯執行不同的計算公式，
    使用 interface 將計算公式抽象出方法，實作邏輯會依照不同商品類型、折扣條件等邏輯，拆分多個實作類型，
    使用端用 interface 的方法操作完成結帳的計算結果，並不需要知道具體實作細節，也不會被影響。

### interface VS interface{}
    interface 是一組方法的定義規範，interface{} 是一個型態可以接受任意的值，
    interface 與 interface{} 都有紀錄 Go 類型的元信息、類型對應的數值，
    interface 多了紀錄方法的資訊，才可效驗是否實作 interface 所有方法。

## 什麼事 reflection
    reflection 是指程式在執行期間可動態的變更行為或狀態的能力，
    更具體一點是指程式用 reflection 可以得到類型訊息、值訊息，
    並可以在運行過程中呼叫類型的方法、重新賦值、依照類型建立新的變數等功能。

### 為什麼需要 reflection
    Go 是編譯語言在一開始就要決定好類型並在編譯時會做檢查，但有些場景需要的是很彈性與通用的功能，
    需要延遲到執行期間決定類型並依照不同類型做不同的處理。

    如 DB 取得資料後將值放回 struct 內，在取得資料上的抽象一樣是 CRUD，使用端會帶入查詢條件，
    並需要將查訓結果帶入使用端需要的 struct 內，在邏輯上是可以通用的，但依照不同使用端 struct，
    在編譯期間是要決定就需要有幾個 struct 幾個 func，但實際邏輯是一致的，在這場景就會選擇 reflection
    達到可以接受任意類型參數並用 reflection 做動態的賦值。

### 什麼事反射三定律
    官方 Go Blog The Laws of Reflection 歸納出的反射三定律
    - Reflection goes from interface value to reflection object.
    - Reflection goes from reflection object to interface value.
    - To modify a reflection object, the value must be settable.

    1. 反射從接口值可以得到反射對象
        func TypeOf(i interface{}) Type
        func ValueOf(i interface{}) Value
    依照 reflect 包提供的 TypeOf、ValueOf func，可以從 interface{} 帶入任意的變數型態，
    並取得反射的對象 reflect.Type or reflect.Value。

    2. 反射從反射對象得到值
    reflect.Value 包含了類型訊息、值訊息 。
        用 func (v Value) Type() Type 取得類型
        用 func (v Value) Interface() (i interface{}) 可以取得值

    3. 要修改反射對象，該值必須可設置
        用 func (v Value) CanSet() bool
    可以確認值是否可以修改，Go 允許修改大寫對外的參數。

## 總結
    反射是讓編譯語言可以推遲到執行期間確認傳入類型，並可動態呼叫方法、賦值等功能，
    但反射的缺點是可讀性下降、效能下降、失去編譯語言的檢驗能力，在執行期間可能發生 panic，
    反射是一個極端的功能，在選擇反射前可考慮帶入場景的優點與缺點在做出抉擇。

---
- 備註
    <br/>
    元信息： 在這指 Go 中類型的最基礎資料，如佔用內存大小、kind 基礎類型等資料。

- 參考
    <br/>
    [The Laws of Reflection](https://blog.golang.org/laws-of-reflection)
    <br/>
    [Go 编程：图解反射](https://toutiao.io/posts/4optwe/preview)
    <br/>
    [Go高级实践：反射3定律](https://lessisbetter.site/2019/02/24/go-law-of-reflect/)
    <br/>
    [go"泛型编程"](http://legendtkl.com/2015/11/25/go-generic-programming/)
    <br/>
    [谈一谈Go的interface和reflect](http://legendtkl.com/2015/11/28/go-interface-reflect/)
    <br/>
    [深入理解 Go Interface](http://legendtkl.com/2017/06/12/understanding-golang-interface/)
    <br/>
    [Go Interface 源码剖析](http://legendtkl.com/2017/07/01/golang-interface-implement/)
    <br/>
    [深入研究 Go interface 底层实现](https://halfrost.com/go_interface/)
    <br/>
    [Go reflection 三定律与最佳实践](https://halfrost.com/go_reflection/)
    <br/>
    [Go 语言设计与实现 4.2 接口](https://draveness.me/golang/docs/part2-foundation/ch04-basic/golang-interface/)
    <br/>
    [Go 语言设计与实现 4.3 反射](https://draveness.me/golang/docs/part2-foundation/ch04-basic/golang-reflect/)
    <br/>
    [深度解密Go语言之关于interface的 10 个问题](https://qcrao.com/2019/04/25/dive-into-go-interface/)
    <br/>
    [深度解密Go语言之反射](https://qcrao.com/2019/05/07/dive-into-go-reflection/)
    