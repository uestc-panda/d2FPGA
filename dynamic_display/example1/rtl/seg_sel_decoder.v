module seg_sel_decoder(bit_disp,seg_sel);
    input [1:0] bit_disp;
    output reg [5:0] seg_sel;
    always@(bit_disp)
        case(bit_disp)
            2'b00 : seg_sel = 6'b111110;
            2'b01 : seg_sel = 6'b111101;
            2'b10 : seg_sel = 6'b111011;
            default : seg_sel = 6'b111111;
        endcase
endmodule