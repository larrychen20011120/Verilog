
# 三種方式來描述電路

## Structure Description
* 透過呼叫 module 來完成
* 使用多個相同 module 時，需要給定每個 module 的名稱
* 中間運算結果可以存入 **wire** 變數中
* or, xor, and, ... built-in modules

```verilog
module HA(a, b, sum, carry);

    input a, b;
    output sum, carry;
    
    // and閘 : and(out, in_1, in_2)
    and(carry, a, b);
    
    // xor閘 : xor(out, in_1, in_2)
    xor(sum, a, b);
    
endmodule
```

## Data Flow Description
* 使用 continuous assignment，當右式變動時，左式的值會跟著隨時變化
* 輸出不可包含輸入 EX: **assign** a = a + 1
* 一個訊號只能被 assign 一次
* 中間運算結果可以存入 **wire** 變數中

```verilog
module HA(a, b, sum, carry);

    input a, b;
    output sum, carry;
    
    // assign carry 
    assign carry = a & b;
    
    // assign sum
    assign sum = a ^ b;
    
endmodule
```

## Behavior Description
* 又稱作 procedural assignment，會依照條件觸發
* 當 **always** block 的 sensitivity list 裡的訊號發生變化，就會執行 block 的程式
* 設計combination circuit 時，可以用 "*" 取代 sensitivity list的內容
* 中間運算或是輸出結果必須存入 **reg** 變數中
* 組合 output 和 reg 一起宣告 : **output reg**

```verilog
module HA(a, b, sum, carry);

    input a, b;
    output sum, carry;
    
    // 也一開始就宣告為 output reg
    reg sum, carry;
    
    // 也可以用 * 取代 a or b
    always@(a or b) begin
        sum = a ^ b;
        carry = a & b;
    end
    
endmodule
```

# Full_adder
* 由**兩個 half_adder**組成
* 輸入兩個數及 carry_in，輸出 sum & carry_out
![image](https://user-images.githubusercontent.com/38965858/140275566-aeaec34f-3abc-47a3-965a-ed4852d977a7.png)

* truth table

| x      | y      | carry_in | sum    | carry_out |
| :----: | :----: | :----:   | :----: | :----:    |
|   0    |  0     |    0     |    0   |    0      |
|   1    |  0     |    0     |    1   |    0      |
|   1    |  0     |    0     |    1   |    0      |
|   1    |  1     |    0     |    0   |    1      |
|   0    |  0     |    1     |    1   |    0      |
|   1    |  0     |    1     |    0   |    1      |
|   0    |  1     |    1     |    0   |    1      |
|   1    |  1     |    1     |    1   |    1      |
