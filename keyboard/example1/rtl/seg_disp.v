module seg_disp(clk_50M,BCD_disp,seg_sel,seg_led);
    input clk_50M;
    input [7:0] BCD_disp;
    output [5:0] seg_sel;
    output [7:0] seg_led;
    //例化时钟分频模块,得到周期为1ms的时钟
    wire clk_1ms;
    clock_division #(
        .DIVCLK_CNTMAX(24_999)
    )
    my_clock_0(
        .clk_in(clk_50M),
        .divclk(clk_1ms)
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
        .ina(BCD_disp[3:0]),
        .inb(BCD_disp[7:4]),
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