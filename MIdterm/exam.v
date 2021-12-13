`define TimeExpire 32'd12500000
module cli_div(clk,rst,div_clk);
input clk,rst;
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
 if(count==`TimeExpire)
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

module exam(clk, reset, in , out);
input clk, reset, in;
reg [3:0] count;
reg [2:0]state, next_state;
wire clk_div;
output [6:0] out;
parameter s0=2'd0, s1=2'd1, s2=2'd2,s3=2'd3;
cli_div c(.clk(clk),.rst(reset),.div_clk(clk_div));
seven useven(.count(count),.out(out));

always@(posedge clk_div or negedge reset)
begin
 if(!reset) 
 begin
  state = s0;
 end
 else 
 begin
  state = next_state;
 end
end

always@(state) begin

case(state)
 
 s0:begin
    if (in == 0) begin
        next_state = s3;
    end
    else begin
        next_state = s2;
    end
 end
 
 s1:begin
    if (in == 0) begin
        next_state = s0;
    end
    else begin
        next_state = s3;
    end
 end
 
 s2:begin
    if (in == 0) begin
        next_state = s1;
    end
    else begin
        next_state = s1;
    end
 end
 
 s3:begin
    if (in == 0) begin
        next_state = s2;
    end
    else begin
        next_state = s0;
    end
 end
 
 endcase

end

always@(state or reset)
begin
    if (reset == 0) begin
        count = 32'd8;
    end
	 else begin	
	 
		case(state)
    s0:begin
        if (in == 0) begin
            count=32'd0;
        end
        else begin
            count = 32'd4;
        end
    end
    s1:begin
        if (in == 0) begin
            count=32'd1;
        end
        else begin
            count = 32'd5;
        end
    end
    s2:begin
        if (in == 0) begin
            count=32'd2;
        end
        else begin
            count = 32'd6;
        end
    end
    s3:begin
        if (in == 0) begin
            count=32'd3;
        end
        else begin
            count = 32'd7;
        end
    end
 endcase
	 end

end
endmodule
