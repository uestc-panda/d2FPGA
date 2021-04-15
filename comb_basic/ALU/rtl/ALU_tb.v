`timescale 1ns / 1ps
module ALU_tb;
    reg [3:0] ina;
    reg [3:0] inb;
    reg [2:0] opcode;
    wire [3:0] ALUout;
    ALU UUT(
        .ina(ina),
        .inb(inb),
        .opcode(opcode),
        .ALUout(ALUout)
    );
    initial begin
        ina = 4'b1001; inb = 4'b0001; opcode = 3'b000;
        #100
        ina = 4'b0111; inb = 4'b0101;
        #100
        $stop;
    end
    always #10 opcode = opcode + 1;
endmodule 