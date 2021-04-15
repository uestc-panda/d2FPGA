module keyboard_instance1(clk,key_col,BCD_preset,key_row,seg_sel,seg_led);
    input clk;
    input [3:0] key_col;
    input [7:0] BCD_preset;
    output key_row;
    output [5:0] seg_sel;
    output [7:0] seg_led;

    //例化键盘模块
    wire [3:0] key_out;
    keyboard keyboard(
        .clk_50M(clk),
        .key_col(key_col),
        .key_row(key_row),
        .key_out(key_out)
    );
    
    //例化BCD功能计数器模块
    wire [7:0] BCD_out;
    BCD_counter_TOP BCD_counter(
        .clk_50M(clk),
        .mode(key_out),
        .BCD_preset(BCD_preset),
        .BCD_out(BCD_out)
    );
    
    //例化数码管显示模块
    seg_disp seg_disp(
        .clk_50M(clk),
        .BCD_disp(BCD_out),
        .seg_sel(seg_sel),
        .seg_led(seg_led)
    );
endmodule