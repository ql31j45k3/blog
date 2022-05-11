# 串接 BSC 經驗

知識點
- 1 BNB 等於 1 加 18個 0的 wei。

- 如何判斷 BNB 幣交易和智能合約，可用 codeAt func 判斷地址是否為智能合約。
  <br/> IsContractAddress 可用來判斷是否為智能合約地址。

- 如何計算實際 交易手續費，gas Used 乘 gasPrice，預估手續費是 gas 乘gasPrice，gas 值是 gas 燃燒最大上限用。
  BNB 幣交易 gas 上限值是 21,000 就夠用，智能合約則 gas 則超過 21,000。

- 用取平均值 gas ，計算出預估手續費，可先扣出手續費，將錢包餘額轉出後歸零。
  <br/> SuggestGasPrice func 可取得鏈上平均值 gasPrice。

- 並發交易，錢包餘額 0.2 ，同時送出兩筆各 0.15 會超出總額，送出 func 只能驗證單筆金額是否超出 錢包餘額，無法計算多筆是否超出總餘額，因為區塊鏈交易需要廣播，需一段時間才會同步交易完成與扣除錢包餘額。
  <br/> EstimateGas func 可用來預估 gas 是否足夠交易和錢包餘額是否足夠當筆交易成本 (成本 = 轉帳金額 + gas)。

- 交易 Nonce (同個 address)，Nonce 可用來對正在處理的交易，再用同筆交易 Nonce 可用來取消或在修改 gas 上限，故 Nonce 是不可重複的，
  並區塊鍊取 Nonce func，只可取得下筆 Nonce 值，一次執行兩次取 Nonce func 結果值一樣 (只能取得交易成功後的下筆 Nonce 值)，
  故程式再做多筆發起交易 (同個 address)，需自行做 Nonce + 1 邏輯，避免重複 Nonce。
  <br/> PendingNonceAt func 只可取得鏈上交易成功後的遞增 Nonce。

- ETH 交易結構是 Transaction 和 Receipt，交易資料可取得投入得 gas、gasPrice 資料，
  實際 gasUsed 需要從 Receipt 取得，在 ETH txHash 是唯一的，並在發起交易時由 fromAddr 的私鑰簽名產生的，
  所以可用 txHash 作為查詢 Receipt 的條件。
  <br/> TransactionReceipt 可取得交易收據資料。

程式範例可參考
- [用Go来做以太坊开发](https://goethereumbook.org/zh/)
