`timescale 1ns/1ps
module gcd_tb();

reg clk, rst_n, start, res_fetch;
reg [7:0] a, b;
wire [7:0] res;
wire res_rdy;

gcd gcd_test (
     .clk       (clk)
    ,.rst_n     (rst_n)
    ,.a         (a)
    ,.b         (b)
    ,.start     (start)
    ,.res_fetch (res_fetch)
    ,.res_rdy   (res_rdy)
    ,.res       (res)
);

initial begin
    clk = 0;
    rst_n = 0;
    start = 0;
    a = 60;
    b = 48;
    res_fetch = 0;
    #21 rst_n = 1;
    #21 start = 1;
    #10 start = 0;
    #155 res_fetch = 1;
    #11 res_fetch = 0;
    a = 30;
    b = 24;
    #21 start = 1;
end

always #5 begin
    clk = ~clk;
end

endmodule