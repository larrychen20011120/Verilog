# 宣告多個 bits 變數
* [num:0] 宣告出(num + 1)個位元的變數
* {x, y, ...} 將多個變數串接成更多位元

```verilog
// a 是三位元輸入變數
input [2:0] a; 
```

# 條件判斷
* dataflow descroption 用三元運算子 (? : )
* behavior description 用 if-else 和 case 來判斷
* 多個 bits 做 case 判斷時，可以用 **n'b** 後接n個 0/1

```verilog
always@(x or y) begin 
    
    case ({x, y})
    
        2'b00: begin
            s = 0;
            c = 0;
        end
        
        2'b01: begin
            s = 1;
            c = 0;
        end
        
    
        2'b10: begin
            s = 1;
            c = 0;
        end
        
    default: begin
        s = 1;
        c = 1;
    end
        
end
```


