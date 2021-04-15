`timescale 1ns / 1ps
module mux4_tb;
    reg [3:0] data_in;
    reg [1:0] sel;
    wire data_out;
    mux4 uut(
        .data_in(data_in),
        .sel(sel),
        .data_out(data_out)
    );
    initial begin
        data_in = 4'b0000;
        sel = 2'b00; 
    end 
    always #20 {data_in,sel} = {data_in,sel} + 1;
endmodule