module DIG_decoder(ctrl,sel);
    input [2:0] ctrl;
    output reg [5:0] sel; 
    //数码管位码译码，位码低有效
    always @ (ctrl)
        case (ctrl)
            3'd1 : sel = 6'b111110;
            3'd2 : sel = 6'b111101;
            3'd3 : sel = 6'b111011;
            3'd4 : sel = 6'b110111;
            3'd5 : sel = 6'b101111;
            3'd6 : sel = 6'b011111;
            default : sel = 6'b111111;
        endcase
endmodule