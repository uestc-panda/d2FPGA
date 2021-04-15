module display_decoder(bit_disp,data_disp,seg_sel,seg_led);
    input [2:0] bit_disp;
    input [3:0] data_disp;
    output reg [5:0] seg_sel;
    output reg [7:0] seg_led;

    //seg_sel decoder
    always@(bit_disp)
        case(bit_disp)
            3'b000 : seg_sel = 6'b111110;
            3'b001 : seg_sel = 6'b111101;
            3'b010 : seg_sel = 6'b111011;
            3'b011 : seg_sel = 6'b110111;
            3'b100 : seg_sel = 6'b101111;
            3'b101 : seg_sel = 6'b011111;
            default : seg_sel = 6'b111111;
        endcase
            
    //seg_led decoder
    always@(data_disp)
        case(data_disp)
            4'h0 : seg_led = 8'h3f;
            4'h1 : seg_led = 8'h06;
            4'h2 : seg_led = 8'h5b;
            4'h3 : seg_led = 8'h4f;
            4'h4 : seg_led = 8'h66;
            4'h5 : seg_led = 8'h6d;
            4'h6 : seg_led = 8'h7d;
            4'h7 : seg_led = 8'h07;
            4'h8 : seg_led = 8'h7f;
            4'h9 : seg_led = 8'h6f;
            4'ha : seg_led = 8'h77;
            4'hb : seg_led = 8'h7c;
            4'hc : seg_led = 8'h39;
            4'hd : seg_led = 8'h5e;
            4'he : seg_led = 8'h79;
            4'hf : seg_led = 8'h71;
            default :seg_led = 8'h00;
        endcase

endmodule 