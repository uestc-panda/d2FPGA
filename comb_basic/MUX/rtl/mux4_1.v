`timescale 1ns / 1ps
module mux4(data_in,sel,data_out);
    input [3:0] data_in;
    input [1:0] sel;
    output data_out;
    assign data_out = sel[1]?(sel[0]?data_in[3]:data_in[2]):(sel[0]?data_in[1]:data_in[0]);
endmodule