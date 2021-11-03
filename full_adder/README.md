# 線上verilog IDE
https://www.jdoodle.com/execute-verilog-online/

# 三種方式來描述電路
## Structure Description
* 透過呼叫 module 來完成
* 使用多個相同 module 時，需要給定每個 module 的名稱
* 中間運算結果可以存入 **wire** 變數中
## Data Flow Description
* 使用 continuous assignment，當右式變動時，左式的值會跟著隨時變化
* 輸出不可包含輸入 EX: **assign** a = a + 1
* 一個訊號只能被 assign 一次
* 中間運算結果可以存入 **wire** 變數中
## Behavior Description
* 又稱作 procedural assignment，會依照條件觸發
* 當 **always** block 的 sensitivity list 裡的訊號發生變化，就會執行 block 的程式
* 設計combination circuit 時，可以用 "*" 取代 sensitivity list的內容
* 中間運算結果可以存入 **reg** 變數中
