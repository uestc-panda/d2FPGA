module onehot2binary(clk,onehot,binary);
    input clk;
    input [15:0] onehot;
    output reg [3:0] binary;
    always@(posedge clk) 
        case(onehot) 
            16'h0001 : binary <= 4'b0000;
            16'h0002 : binary <= 4'b0001;
            16'h0004 : binary <= 4'b0010;
            16'h0008 : binary <= 4'b0011;
            16'h0010 : binary <= 4'b0100;
            16'h0020 : binary <= 4'b0101;
            16'h0040 : binary <= 4'b0110;
            16'h0080 : binary <= 4'b0111;
            16'h0100 : binary <= 4'b1000;
            16'h0200 : binary <= 4'b1001;
            16'h0400 : binary <= 4'b1010;
            16'h0800 : binary <= 4'b1011;
            16'h1000 : binary <= 4'b1100;
            16'h2000 : binary <= 4'b1101;
            16'h4000 : binary <= 4'b1110;
            16'h8000 : binary <= 4'b1111;
        endcase
endmodule