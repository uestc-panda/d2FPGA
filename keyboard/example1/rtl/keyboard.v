module keyboard(clk_50M,key_col,key_row,key_out);
    input clk_50M;
    input [3:0] key_col;
    output key_row;
    output [3:0] key_out;
    wire [3:0] key_deb;
    key_filter key_filter(
        .clk(clk_50M),
        .rstn(1'b1),
        .key_in(key_col),
        .key_deb(key_deb)
    );
    assign key_row = 1'b0; 
    wire en = (key_deb == 4'b0000) ? 1'b0 : 1'b1;
    register_4bit register_4bit(
        .clk(clk_50M),
        .en(en),
        .data_in(key_deb),
        .data_out(key_out)
    );
endmodule