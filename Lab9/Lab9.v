`define TimeExpire 2'd2
module cli_div(clk,rst,div_clk);

input clk, rst;
output div_clk;

reg div_clk;
reg [1:0]count;

always@(posedge clk or negedge rst)
begin
 if(!rst)
 begin
    count <= 2'd0;
    div_clk <= 1'b0;
 end
 else
 begin
    if(count == `TimeExpire)
    begin
        count <= 2'd0;
        div_clk <= !div_clk;
    end
    else
    begin
        count <= count + 2'd1;
    end 
 end
end

endmodule



module Lab11(clk, reset, h_sync, v_sync, r, g, b);

input clk, reset;
output reg[3:0] r, g, b;
output reg h_sync, v_sync;

wire clk_div;
reg [9:0] h_count, v_count;

cli_div c(.clk(clk),.rst(reset),.div_clk(clk_div));

always@(posedge clk or negedge reset)
begin
 if(!reset) 
 begin
    r <= 4'd0;
    g <= 4'd0;
    b <= 4'd0;
    h_sync <= 1'b1;
    v_sync <= 1'b1;
    h_count <= 10'd1;
    v_count <= 10'd1;
 end
 else 
 begin
    
    if (h_count == 800)
    begin
        h_count <= 10'd1;
        v_count <= v_count + 10'd1;
        h_sync <= 1'b0;
    end
    else
    begin
        h_count <= h_count + 10'd1;
        h_sync <= 1'b1;
    end
    
    if (v_count == 526)
    begin
        h_count <= 10'd1;
        v_count <= 10'd1;
        v_sync <= 1'b0;
    end
    else
    begin
        v_sync <= 1'b1;
    end
    
    

 end
end


endmodule
