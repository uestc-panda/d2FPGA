`timescale 1ns / 1ps
module priority_encoder_tb;
    reg [3:0] Data;
    wire [1:0] Code;
    wire GS;
    priority_encoder uut(
        .Data(Data),
        .Code(Code),
        .GS(GS)
    );
    initial Data = 0;
    always #20 Data = Data + 1;
endmodule