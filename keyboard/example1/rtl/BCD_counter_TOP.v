module BCD_counter_TOP(clk_50M,mode,BCD_preset,BCD_out);
    input clk_50M;
    input [3:0] mode;
    input [7:0] BCD_preset;
    output [7:0] BCD_out;
    //例化时钟分频模块
    wire clk_1s;
    clock_division #(
        .DIVCLK_CNTMAX(24_999_999)
    )
    my_clock_0(
        .clk_in(clk_50M),
        .divclk(clk_1s)
    );
    //例化BCD功能计数器并级联
    wire [3:0] BCD_units_preset = BCD_preset[3:0];
    wire [3:0] BCD_units_out;
    wire bcout_0;
    BCD_functional_counter BCD_units(
        .clk(clk_1s),
        .mode(mode),
        .BCD_preset(BCD_units_preset),
        .BCD_out(BCD_units_out),
        .bcin(1'b1),
        .bcout(bcout_0)
    );
    wire [3:0] BCD_tens_preset = BCD_preset[7:4];
    wire [3:0] BCD_tens_out;
    BCD_functional_counter BCD_tens(
        .clk(clk_1s),
        .mode(mode),
        .BCD_preset(BCD_tens_preset),
        .BCD_out(BCD_tens_out),
        .bcin(bcout_0),
        .bcout()
    );
    assign BCD_out = {BCD_tens_out,BCD_units_out};
endmodule