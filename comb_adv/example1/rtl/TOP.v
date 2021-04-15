module TOP(data_disp,ctrl,seg,sel);
    input [3:0] data_disp;
    input [2:0] ctrl;
    output [7:0] seg;
    output [5:0] sel;

    DIG_decoder DIG_decoder(
        .ctrl(ctrl),
        .sel(sel)
    );

    seg_decoder seg_decoder(
        .data_disp(data_disp),
        .seg(seg)
    );

endmodule