module TOP(clk_50M,units,tens,rst,preset,seg_sel,seg_led);
    input clk_50M;
    input [3:0] units,tens;
    input rst;
    input preset;
    output [5:0] seg_sel;
    output [7:0] seg_led;

    //50M/1K = 5K
    parameter DIVCLK_CNTMAX_1ms = 24999;
    wire clk_1ms;
    //50M/1 = 50M
    parameter DIVCLK_CNTMAX_1s = 24999999;
    wire clk_1s;

    //例化时钟分频模块,得到周期为1ms的时钟
    clock_division #(
        .DIVCLK_CNTMAX(DIVCLK_CNTMAX_1ms)
    )
    my_clock_0(
        .clk_in(clk_50M),
        .divclk(clk_1ms)
    );

    //例化时钟分频模块，得到周期为1s的时钟
    clock_division #(
        .DIVCLK_CNTMAX(DIVCLK_CNTMAX_1s)
    )
    my_clock_1(
        .clk_in(clk_50M),
        .divclk(clk_1s)
    );

    //例化BCD码向下计数器模块，并进行级联
    wire bin;
    wire bout_0;
    wire bout_1;
    wire [3:0] units_disp;
    wire [3:0] tens_disp;
    assign bin = units_disp || tens_disp;
    BCD_downcounter downcounter_0(
        .clk(clk_1s),
        .rst(rst),
        .bin(bin),
        .preset(preset),
        .BCD_i(units),
        .BCD_o(units_disp),
        .bout(bout_0)
    );
    BCD_downcounter downcounter_1(
        .clk(clk_1s),
        .rst(rst),
        .bin(bout_0),
        .preset(preset),
        .BCD_i(tens),
        .BCD_o(tens_disp),
        .bout(bout_1)
    );

    //例化计数器模块
    wire bit_disp;
    counter counter(
        .clk(clk_1ms),
        .cnt(bit_disp)
    );

    //例化多路复用器模块
    wire [3:0] data_disp;
    Mux Mux(
        .sel(bit_disp),
        .ina(units_disp),
        .inb(tens_disp),
        .data_out(data_disp)
    );

    //例化数码管位选译码模块
    seg_sel_decoder seg_sel_decoder(
        .bit_disp(bit_disp),
        .seg_sel(seg_sel)
    );
    //例化数码管段码译码模块
    seg_led_decoder seg_led_decoder(
        .data_disp(data_disp),
        .seg_led(seg_led)
    );

endmodule