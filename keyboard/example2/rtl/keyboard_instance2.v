module keyboard_instance2(clk_50M,col,row,seg_led,seg_sel);
    input clk_50M;
    input [3:0] col;
    output [3:0] row;
    output [7:0] seg_led;
    output [5:0] seg_sel;
    assign seg_sel = 6'b111110;
    wire [15:0] key;
    keyboard_scan keyboard_scan(
        .clk(clk_50M),
        .col(col),
        .row(row),
        .key(key)
    );
    wire [15:0] key_deb;
    key_filter key_filter(
        .clk(clk_50M),
        .rstn(1'b1),
        .key_in(key),
        .key_deb(key_deb)
    );
    wire [3:0] data_disp;
    onehot2binary onehot2binary(
        .clk(clk_50M),
        .onehot(key_deb),
        .binary(data_disp)
    );
    seg_led_decoder seg_led_decoder(
        .data_disp(data_disp),
        .seg_led(seg_led)
    );
endmodule

