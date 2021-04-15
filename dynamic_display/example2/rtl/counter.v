`timescale 1ns / 1ps
module counter(clk,cnt);
    input clk;
    output reg [2:0] cnt = 0;
    always@(posedge clk) begin
        if(cnt == 3'b101)
            cnt <= 3'b000;
        else 
            cnt <= cnt + 1'b1;
    end
endmodule
