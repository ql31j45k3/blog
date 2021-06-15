# 什麼事 method receiver

## 什麼事 method receiver
    是指方法的接收者 何謂接收者，在 Go 中宣告方法有在 package 底下，另一個是在 struct 結構底下，
    接收者指的就是 struct 結構底下的方法宣告中可以呼叫到 struct 本身，在 Go 中稱為接收者。
    
    在 func 與 方法名之間的括弧內就是接收者的宣告位置，在這當中有分為 *Person 與 Person，
    一個稱呼為 pointer receiver (*Person) 另一個稱呼為 value receiver (Person)。

    type Person struct {
      name string
    }
    
    func (p *Person) GetName() string {
      return p.name
    }

    func (p Person) String() string {
      return "Hi" + p.name
    }

## 什麼事 value receiver
    struct 的 method receiver 宣告為 (p Person)，
    代表每次執行時是複製一個值的副本並不會修改到原始值，當需要只有讀的場景很適合用 value receiver。

## 什麼事 pointer receiver
    struct 的 method receiver 宣告為 (p *Person)，代表會修改到同一份資料也就是會修改到原始值。

### method receiver 隱式函數
    type Person2 struct {
      name string
    }
    
    func (p Person2) GetName() string {
      return p.name
    }
    
    func (p *Person2) SetName(name string) {
      p.name = name
    }

    func main() {
	  var p Person2

	  (*Person2).SetName(&p, "myName")
	  fmt.Println(Person2.GetName(p)) // myName

      // (Person2).SetName(p, "myName")
      // invalid method expression Person2.SetName (needs pointer receiver: (*Person2).SetName)
      
      fmt.Println((*Person2).GetName(&p)) // myName

      p2 := &Person2{}
	  p2.SetName("Person2")
	  fmt.Println(p2.GetName()) // Person2

      p3 := Person2{}
	  // p3.SetName("Person3") 編譯器會改為下方呼叫方式
      (*Person2).SetName(&p3, "Person3")
	  fmt.Println(p3.GetName()) // Person3
    }

    Person2 struct 編譯時期會產生隱式聲明的對應函數，可在 main 呼叫到對應函數。
    但上述只有針對原本的 (p Person2) GetName() 聲明出對應的 (*Person2).GetName(p *Person2) 方法，
    就是值類型屬性的方法會自動宣告隱式的 point 屬性方法，這樣可支援 point 初始化變數呼叫對應的方法。

    func Person2.GetName(p Person2) string {
      return p.name
    }

    func (*Person2).GetName(p *Person2) string {
      return p.name
    }

    func (*Person2).SetName(p *Person2, name string) {
      p.name = name
    }

### Interface 與 method receiver
    當要賦值給 Interface 時，struct 實作有 value receiver or pointer receiver 再加上 struct 初始化有分值初始化、point初始化，
    這樣組合上就會有四種：
      值初始化 + value receiver、值初始化 + pointer receiver、
      point 初始化 + value receiver、point 初始化 + pointer receiver、
    在這當中只有 值初始化 + pointer receiver 會編譯失敗。

    type Person2 struct {
	  name string
    }
    
    func (p *Person2) SetName(name string) {
      p.name = name
    }
    
    type Person2Interface interface {
      SetName(name string)
    }
    
    func test(pi Person2Interface) {
      pi.SetName("hi")
    }

    func main() {
      // pp := Person2{}
	  // test(pp)
	  // Cannot use 'pp' (type Person2) as the type Person2Interface Type does not implement 'Person2Interface' as the 'SetName' method has a pointer receiver

      pp := &Person2{}
	  test(pp) // OK

      pp2 := Person2{}
	  test(&pp2) // OK
    }

    原因是 Person2 的 SetName 是一個 pointer receiver，當呼叫函數時是值的副本，也就是無法從副本推演回原始值，
    自然就無法對 (p *Person2) SetName 方法達到成功的修改同一筆資料的特性，因此會在編譯期間做檢查，避免發生此錯誤場景。

## go 傳遞參數是值傳遞還是引用傳遞
    何謂值傳遞：
      賦予變數都是複製一個副本給另一個變數，舉例在傳遞 int 時是傳遞一個 int value 的副本，
      傳遞指針時是傳遞一個記憶體位的值 func test(i *int) or func test2(m map) 同等於 func test2(m *hmap)。
    
    何謂引用傳遞：
      賦予變數時是將記憶體位置共享給另一個變數
      舉例在 C++ 語言中下方的 new 並沒有分配一個記憶體位置，而是將 new 指向 basic 的記憶體位置，
      同一個記憶體位置被分享同時指向 basic and new，打印出記憶體位置 basic 和 new 會是一樣的。
        int basic = 1;
        int &new = basic;
    
    Go 中只有值傳遞而要達到同樣引用傳遞效果方法，是傳遞 value 為一份記憶體位置，不是將變數直接指向同一份記憶體位置共享，
    而是變數內儲存的 value 是一個記憶體位置，這個記憶體指向是最源頭儲存實際資料的地方。

    舉例下方 basic 儲存 1 這個 value，new 儲存 basic 記憶體位置，basic 和 new 都會分配一個記憶體空間，
    打印出記憶體位置 basic 和 new 會是不一樣的，指向 new 的 value 是一個記憶體位置，用這個記憶體位置可以找到 basic 並修改它的值。
      basic := 1
      new := &basic

    在程式當中 map、slice、channel 這幾個關鍵字 make 宣告出來時候就實際上是一個引用類型了。
    舉例其中一個 map 宣告出來後實際上就是一個引用類型 *hmap。

## 總結
    在 Go 中只有值傳遞差別是值是引用類型或數值，只要知道是值傳遞就可以理解運行中程式原本預期會改到同一份資料，
    實際上改到的是值副本的資料，如 for i, v := range slice 在這當中的 v 也是值副本，修改 v 不會修改到原始值。

---
- 備註
  <br/>

- 參考
  <br/>
  [Go語言101-方法](https://gfw.go101.org/article/method.html)
  <br/>
  [Go語言101-指針](https://gfw.go101.org/article/pointer.html)
  <br/>
  [好未来Golang源码系列四：Interface实现原理分析](https://wemp.app/posts/e99d5445-66ec-4b65-843e-9d9129c78420)
  <br/>
  [[Go] 為什麼 Pointer Receiver 不能使用 Value Type 賦值給 Interface Value](https://mileslin.github.io/2020/08/Golang/%E7%82%BA%E4%BB%80%E9%BA%BC-Pointer-Receiver-%E4%B8%8D%E8%83%BD%E4%BD%BF%E7%94%A8-Value-Type-%E8%B3%A6%E5%80%BC%E7%B5%A6-Interface-Value/)
  <br/>
  [深入理解Go语言中的方法](https://www.s0nnet.com/archives/methods-and-interfaces-in-go)
  <br/>
  [深入理解Go语言中的方法再议go语言的value receiver和pointer receiver](https://www.jianshu.com/p/d1a9bbd0ae36)
  <br/>
  [Go语言参数传递是传值还是传引用](https://www.flysnow.org/2018/02/24/golang-function-parameters-passed-by-value.html)
  <br/>
  [Go语言参数传递是传值还是传引用用汇编带你看Golang里到底有没有值类型、引用类型](https://segmentfault.com/a/1190000039737446)
  <br/>
  [在Go中没有引用传值](https://www.cnblogs.com/Jun10ng/p/12723409.html)
