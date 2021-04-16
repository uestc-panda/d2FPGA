`timescale 1ns/1ps
module WaterLight_tb();

reg clk;
reg rst_n;
reg [1:0] sw;
wire [3:0] led;

WaterLight uut (
   .clk_i      (clk)
  ,.rst_n      (rst_n)
  ,.sw         (sw)
  ,.led        (led)
);

initial begin
  clk = 1'b0;
  rst_n = 1'b0;
  sw = 2'b0;
  #21
  rst_n = 1'b1;
  #179
  sw = 2'b01;
  #200
  sw = 2'b10;
end

always #10 begin
  clk = ~clk;
end

endmodule