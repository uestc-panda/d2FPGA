module Mux(
    input [2:0] sel,
    input [3:0] ina,
    input [3:0] inb,
    input [3:0] inc,
    input [3:0] ind,
    input [3:0] ine,
    input [3:0] inf,
    output reg [3:0] data_out
);
    always@(*)
        case(sel) 
            3'b000 : data_out = ina;
            3'b001 : data_out = inb;
            3'b010 : data_out = inc;
            3'b011 : data_out = ind;
            3'b100 : data_out = ine;
            3'b101 : data_out = inf;
            default : data_out = 0;
        endcase
endmodule