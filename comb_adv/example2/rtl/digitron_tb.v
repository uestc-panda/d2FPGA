`timescale 1ns / 1ps
module digitron_tb;
    reg [3:0] ina;
    reg [3:0] inb;
    wire [7:0] seg;
    wire [5:0] sel;
    TOP uut(
        .ina(ina),
        .inb(inb),
        .seg(seg),
        .sel(sel)
    );
    initial begin
        ina = 4'h0; inb = 4'h0; //ina = inb
        #20
        ina = 4'h5; inb = 4'h2; //ina > inb
        #20
        ina = 4'h7; inb = 4'h9; //ina < inb
        #20
        ina = 4'h6; inb = 4'h6; //ina = inb
        #20
        ina = 4'he; inb = 4'ha; //ina > inb
        #20
        ina = 4'hb; inb = 4'hf; //ina < inb
        #20
        $stop;
    end
endmodule