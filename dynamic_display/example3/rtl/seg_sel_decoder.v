module seg_sel_decoder(bit_disp,seg_sel);
    input bit_disp;
    output reg [5:0] seg_sel;
    always@(bit_disp)
        case(bit_disp)
            1'b0 : seg_sel = 6'b111110;
            1'b1 : seg_sel = 6'b111101;
            default : seg_sel = 6'b111111;
        endcase
endmodule