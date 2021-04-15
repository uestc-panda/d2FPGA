`timescale 1ns / 1ps
module dynamic_disp_instance1_tb;
    reg clk;
    reg [3:0] ina,inb,inc;
    wire [5:0] seg_sel;
    wire [7:0] seg_led;

    TOP #(
        .DIVCLK_CNTMAX(1)
    )
    UUT(
        .clk_50M(clk),
        .ina(ina),
        .inb(inb),
        .inc(inc),
        .seg_sel(seg_sel),
        .seg_led(seg_led)
    );

    initial begin
        clk = 1'b0; ina = 4'h0; inb = 4'h0; inc = 4'h0;
        #200
        ina = 4'h1; inb = 4'h2; inc = 4'h3;
        #200
        ina = 4'h6; inb = 4'h7; inc = 4'h8;
        #200
        ina = 4'ha; inb = 4'he; inc = 4'hf;
        #200
        $stop;
    end
    
    always #10 clk = ~clk;
endmodule
