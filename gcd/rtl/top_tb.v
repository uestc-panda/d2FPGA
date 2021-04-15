
module top_tb();

reg clk, rst_n;
reg [3:0] col;
reg [4:0] a;
reg [4:0] b;
wire row, res_rdy;
wire [5:0] seg_sel;
wire [7:0] seg_led;

top uut (
     .clk       (clk)
    ,.rst_n     (rst_n)
    ,.col       (col)
    ,.a         (a)
    ,.b         (b)
    ,.row       (row)
    ,.seg_led   (seg_led)
    ,.seg_sel   (seg_sel)
    ,.res_rdy   (res_rdy)
);

initial begin
    clk = 0;
    rst_n = 0;
    a = 31;
    b = 31;
    col = 4'b0;
    #21 rst_n = 1;
    #10 col = 4'b0000;
    #6 col = 4'b0;
end

always #5 begin
    clk = ~clk;
end

endmodule