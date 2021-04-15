`timescale 1ns / 1ps
module dynamic_disp_instance3_tb;
    reg clk;
    reg [3:0] units,tens;
    reg rst,preset;
    wire [5:0] seg_sel;
    wire [7:0] seg_led;

    TOP #(
        .DIVCLK_CNTMAX_1ms(1),
        .DIVCLK_CNTMAX_1s(2)
    )
    UUT(
        .clk_50M(clk),
        .units(units),
        .tens(tens),
        .rst(rst),
        .preset(preset),
        .seg_sel(seg_sel),
        .seg_led(seg_led)
    );

    initial begin
        clk = 1'b0; units = 4'b000; tens = 4'b0000; preset = 1'b0; rst =1'b0;
        #10
        units = 4'b0111; tens = 4'b0001; preset = 1'b1; 
        #10
        preset = 1'b0;
        #500
        units = 4'b0010; tens = 4'b0100; preset = 1'b1;
        #10
        preset = 1'b0;
        #500
        $stop;
    end
    
    always #1 clk = ~clk;
endmodule