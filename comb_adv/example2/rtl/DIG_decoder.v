module DIG_decoder(ctrl,sel);
    input [1:0] ctrl;
    output reg [5:0] sel;
    always@(ctrl) 
        case(ctrl)
            2'b00 : sel = 6'b111000;
            2'b01 : sel = 6'b000111;
            2'b10 : sel = 6'b000000;
            default : sel = 6'b111111;
        endcase
endmodule