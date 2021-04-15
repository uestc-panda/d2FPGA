`timescale 1ns / 1ps
module counter(clk,cnt);
    input clk;
    output reg [1:0] cnt = 0;
    always@(posedge clk) begin
        if(cnt == 2'b10)
            cnt <= 2'b00;
        else 
            cnt <= cnt + 1'b1;
    end
endmodule

    
