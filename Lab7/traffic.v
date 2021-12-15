`define TimeExpire_1HZ 32'd25000000
`define TimeExpire_10000HZ 32'd2500

module cli_div(clk, rst, timeEx, div_clk);
input clk, rst;
input [31:0] timeEx;
output div_clk;

reg div_clk;
reg [31:0]count;

always@(posedge clk or negedge rst)
begin
 if(!rst)
 begin
 count<=32'd0;
 div_clk<=1'b0;
 end
 else
 begin
 if(count==timeEx)
 begin
 count<=32'd0;
 div_clk<=!div_clk;
 end
 else
 begin
 count<=count+32'd1;
 end 
 end
end

endmodule

module seven(count,out);
input [3:0] count;
output reg[6:0] out;
always@(count)
begin
case(count)
 4'd0 : out =  7'b0000001 ;
 4'd1 : out =  7'b1001111 ;
 4'd2 : out =  7'b0010010 ;
 4'd3 : out =  7'b0000110 ;
 4'd4 : out =  7'b1001100 ;
 4'd5 : out =  7'b0100100 ;
 4'd6 : out =  7'b0100000 ;
 4'd7 : out =  7'b0001111 ;
 4'd8 : out =  7'b0000000 ;
 4'd9 : out =  7'b0000100 ;
 4'd10 : out = 7'b0001000 ;
 4'd11 : out = 7'b1100000 ;
 4'd12 : out = 7'b0110001 ;
 4'd13 : out = 7'b1000010 ;
 4'd14 : out = 7'b0110000 ;
 4'd15 : out = 7'b0111000 ;
endcase
end
endmodule

module Lab7(clk, reset, dot_row, dot_col, out);
input clk,reset;
output reg[7:0] dot_row, dot_col;
output [6:0] out;
reg [2:0] row_count;
reg [1:0] state;
reg [3:0] count;
wire clk_div_1, clk_div_2;
parameter g=2'd0, y=2'd1, r=2'd2;

cli_div one(.clk(clk),.rst(reset),.timeEx(`TimeExpire_1HZ),.div_clk(clk_div_1));
cli_div tenthousand(.clk(clk),.rst(reset),.timeEx(`TimeExpire_10000HZ),.div_clk(clk_div_2));
seven useven(.count(count),.out(out));

always@(posedge clk_div_1 or negedge reset)
begin
 if(!reset) 
 begin
  count = 4'd15;
  state = g;
 end
 else 
 begin
  count <= count - 4'd1;
 end
end

always@(count) begin

if (count == 0) begin
case(state)
 
 g:begin
    state = y;
    count <= 4'd5;
 end
 
 y:begin
    state = r;
    count <= 4'd10;
 end
 
 r:begin
    state = g;
    count <= 4'd15;
 end
 endcase
end
else begin
    state <= state;
end
end

always@(posedge clk_div_2 or negedge reset)
begin
 if(!reset) begin
  dot_row <= 8'b0;
  dot_col <= 8'b0;
  row_count <= 0;
 end
 else begin
  row_count <= row_count + 1;
  
 case(row_count)
 3'd0: dot_row <= 8'b01111111;
 3'd1: dot_row <= 8'b10111111;
 3'd2: dot_row <= 8'b11011111;
 3'd3: dot_row <= 8'b11101111;
 3'd4: dot_row <= 8'b11110111;
 3'd5: dot_row <= 8'b11111011;
 3'd6: dot_row <= 8'b11111101;
 3'd7: dot_row <= 8'b11111110;
 endcase
 
 case(state)
 
 g:begin
    case(row_count)
    3'd0: dot_col <= 8'b00001100;
    3'd1: dot_col <= 8'b00001100;
    3'd2: dot_col <= 8'b00011001;
    3'd3: dot_col <= 8'b01111110;
    3'd4: dot_col <= 8'b10011000;
    3'd5: dot_col <= 8'b00011000;
    3'd6: dot_col <= 8'b00101000;
    3'd7: dot_col <= 8'b01001000;
    endcase;
 end
 
 y:begin
    case(row_count)
    3'd0: dot_col <= 8'b00000000;
    3'd1: dot_col <= 8'b00100100;
    3'd2: dot_col <= 8'b00111100;
    3'd3: dot_col <= 8'b10111101;
    3'd4: dot_col <= 8'b11111111;
    3'd5: dot_col <= 8'b00111100;
    3'd6: dot_col <= 8'b00111100;
    3'd7: dot_col <= 8'b00000000;
    endcase
 end
 
 r:begin
    case(row_count)
    3'd0: dot_col <= 8'b00011000;
    3'd1: dot_col <= 8'b00011000;
    3'd2: dot_col <= 8'b00111100;
    3'd3: dot_col <= 8'b00111100;
    3'd4: dot_col <= 8'b01011010;
    3'd5: dot_col <= 8'b00011000;
    3'd6: dot_col <= 8'b00011000;
    3'd7: dot_col <= 8'b00100100;
    endcase
 end
 endcase
 
 end
end

endmodule
