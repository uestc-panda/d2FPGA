`timescale 1ns / 1ps
module BCD_downcounter(
    input clk,              //时钟输入
    input rst,              //异步复位输入
    input bin,              //借位输入
    input preset,           //同步预置数输入
    input [3:0] BCD_i,      //BCD码计数输入
    output [3:0] BCD_o,     //BCD码计数输出
    output bout             //借位输出
);
    reg [3:0] cnt;
    always@(posedge clk or posedge rst) begin
        if(rst)
            cnt <= 0;
        else if(preset)
            cnt <= BCD_i;
        else if(bin) begin
            if(cnt == 4'd0)
                cnt <= 4'd9;
            else
                cnt <= cnt - 1'b1;
        end
    end

    assign BCD_o = cnt;
    assign bout = bin && (cnt == 4'd0); //向下计数至0时同步输出bout信号

endmodule

