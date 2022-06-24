# 串接 Polygon 經驗

知識點
- Polygon 是 etc 的側鏈或是抽象在 eth 鏈上的，所以用 bor 來使用 eth 智能合約和 evm，並是在 eth RPC API 基礎上開發的，
  RPC API 跟 ett 是相容性的，很快就可以上手，有增加新的 type 交易模式的 func。
  如查詢錢包餘額、生成錢包公私鑰和地址、查詢最新區塊高度、查詢區塊資料 by區塊高度、
  取得建議 gasPrice、預估 gas 費用是否足夠、查詢交易資料、查詢交易收據資料、發送 LegacyTx 交易 都是相容的。

- Polygon 搭建節點，除了自己鏈 heimdall 還需要藉由 bor 跟 ett 串鏈跟提供 RPC API 功能。

- 1 Matic 等於 1 加 18個 0的 wei。

- 有支援 legacy (type 0) 交易模式和新支援的 EIP1559 (type 2) 交易模式，
  兩者差別是 gas 計算方式不同，新支援提供 baseFee 和 priorityFee 的 gas 計算方案，
  原本公式是 gas * gasPrice ，EIP1559 分為 baseFee、priorityFee，baseFee 是依照區塊要付的最低費用，
  priorityFee 是激勵礦工小費的費用， 要用 EIP1559 交易 只要移除 gasPrice 改為添加 maxPriorityFeePerGas (GasTipCap) 欄位就可以了，
  如果要在 EIP1559 使用 eth gas 計算，是移除 gasPrice 改為添加 maxFeePerGas (GasFeeCap) 就是一樣的 etc gas 計算模型，
  SuggestGasTipCap func 取得 maxPriorityFeePerGas 建議費用。

- 智能合約的代幣交易，在 LegacyTx 的 toAddr 是帶入 代幣中心的智能合約地址，
  在 input data 使用智能合約的代幣交易方法， transfer(address,uint256) address 帶入要轉入的 toAddr 和 代幣金額 uint256，
  這邊的 toAddr 是充值的地址，這樣交易流程就是，發起交易到 代幣中心的智能合約，代幣合約 內建已有相關合約程式，
  代幣合約會執行 input data 的合約方法，這樣就在代幣合約的底下，做 A 帳號轉帳到 B 帳號的代幣交易了

- 智能合約的代幣交易，交易金額都是統一轉為 wei 單位，而在智能合約的代幣，因每個代幣的精準數不同，
  需要注意轉換的精準數需要跟代幣的設定參數一樣，如不一致則會實際轉換出非常高的交易金額，因精準數過多。

- 查詢代幣交易紀錄，是去智能合約地址下查詢，用 lib 提供的 FilterQuery 帶入區塊高度起迄、合約地址陣列條件來查詢，
  會返回合約 logs，在用 Transfer(address,address,uint256) 的 hash 作為過濾條件，從合約 logs 過濾出 Transfer 的紀錄資料，
  這樣就可以找到合約底下的轉帳交易紀錄。

- 代幣餘額查詢，首先需要建立出 智能合約 sol 轉成 go 程式，這樣才可以讓 go 呼叫合約內的功能，當用 token.sol 轉成 token.go 後，
  提供了餘額查找 func，首先會用 NewTokenCaller(address, caller, contractAbi) 建立出智能合約的 tokenCaller，
  在用 tokenCaller 提供的 BalanceOf func 就可以查找某個地址的代幣帳戶餘額。

- 如何找到智能合約 ABI，在區塊瀏覽器內查找合約的地址，在下方會有一個 Contract 頁籤，在底下 Code 頁籤會有 Solidity 和 ABI，
  但如果實作方式是用 Proxy ，則需要從 Read Contract 頁籤，內有一個 implementation 找到實作合約內容的地址，
  再從裡面的 Contract 頁籤下的 Code 頁籤，找到實作的 Solidity 和 ABI。

程式範例可參考
- [用Go来做以太坊开发](https://goethereumbook.org/zh/)
