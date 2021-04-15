`timescale 1ns / 1ps
module adder_4bit_tb;
    reg [3:0] ina,inb;
    reg cin;
    wire [3:0] sum;
    wire cout;
    adder_4bit uut(
        .ina(ina),
        .inb(inb),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    initial begin
        ina = 4'b0000; inb = 4'b0000; cin = 1'b0;
        #10
        ina = 4'b0011; inb = 4'b0100; cin = 1'b0;
        #10
        ina = 4'b1001; inb = 4'b1100; cin = 1'b0;
        #10
        ina = 4'b1010; inb = 4'b0001; cin = 1'b1;
        #10
        ina = 4'b0111; inb = 4'b1000; cin = 1'b1;
        #10
        $stop;
    end
endmodule