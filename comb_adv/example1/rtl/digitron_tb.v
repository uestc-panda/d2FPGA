`timescale 1ns / 1ps
module digitron_tb;
    reg [3:0] data_disp;
    reg [2:0] ctrl;
    wire [7:0] seg;
    wire [5:0] sel;
    TOP uut(
        .data_disp(data_disp),
        .ctrl(ctrl),
        .seg(seg),
        .sel(sel)
    );
    initial begin
        data_disp = 4'b0000;
        ctrl = 3'b000;
    end
    always #20 begin
        data_disp = data_disp + 1;
        ctrl = ctrl + 1;
    end
endmodule