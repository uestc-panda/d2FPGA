`timescale 1ns / 1ps
module Mux(sel,ina,inb,data_out);
    input sel;
    input [3:0] ina;
    input [3:0] inb;
    output reg [3:0] data_out;
    always@(*)
        case(sel) 
            1'b0 : data_out = ina;
            1'b1 : data_out = inb;
        endcase
endmodule

