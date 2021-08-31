 module Keyboard(
    input                  clk,
    input                  rstn,
    input        [3 :0]    col,
    output       [3 :0]    row,
    output       [15:0]    key_pulse

);

wire  [15:0]  key;
keyboard_scan keyboard_scan(
     .clk(clk)
    ,.rstn(rstn)
    ,.col(col)
    ,.row(row)
    ,.key(key)
);

keyboard_filter keyboard_filter(
     .clk(clk)
    ,.rstn(rstn)
    ,.key_in(key)
    ,.key_pulse(key_pulse)
);

endmodule