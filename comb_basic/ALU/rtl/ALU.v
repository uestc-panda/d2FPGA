module ALU #(
    parameter DATA_WIDTH = 4
)   (ina,inb,opcode,ALUout);
    input [DATA_WIDTH-1:0] ina;
    input [DATA_WIDTH-1:0] inb;
    input [2:0] opcode;
    output reg [DATA_WIDTH-1:0] ALUout;
    always@(*) 
        case(opcode) 
            3'b000 : ALUout = ina + inb;    //ADD
            3'b001 : ALUout = ina - inb;    //SUB
            3'b010 : ALUout = ina & inb;    //AND
            3'b011 : ALUout = ina | inb;    //OR
            3'b100 : ALUout = ~(ina | inb); //NOR
            3'b101 : ALUout = ina ^ inb;    //XOR
            default : ALUout = 0;
        endcase
endmodule

      
