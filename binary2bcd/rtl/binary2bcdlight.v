module binary2bcdlight(clk,en,a,seg_led,seg_sel);

input clk,en;
input [7:0]a;
output wire [7:0]seg_led;
output wire [5:0]seg_sel;


wire [3:0]bcd1,bcd2,bcd3;
binary2bcd binary(
		.a(a),
		.b({bcd3[3:0],bcd2[3:0],bcd1[3:0]})
);

wire tmp_clk;
clock_division fp(
	.clk_in(clk),
	.divclk(tmp_clk)
);

wire [1:0] tmp_cnt;
counter count(
		.clk(tmp_clk),
		.cnt(tmp_cnt)
);

wire [3:0] reg_1,reg_2,reg_3;
register_4bit register_1(
        .clk(clk),
        .data_in(bcd1),
        .en(en),
        .data_out(reg_1)
    );
register_4bit register_2(
        .clk(clk),
        .data_in(bcd2),
        .en(en),
        .data_out(reg_2)
    );
register_4bit register_3(
        .clk(clk),
        .data_in(bcd3),
        .en(en),
        .data_out(reg_3)
    );

wire [3:0] data_disp;
Mux Mux(
        .sel(tmp_cnt),
        .ina(reg_1),
        .inb(reg_2),
        .inc(reg_3),
        .data_out(data_disp)
    ); 

seg_sel_decoder seg_sel_decoder(
		.bit_disp(tmp_cnt),
		.seg_sel(seg_sel)
);

seg_led_decoder  seg_led_decoder(      
		.data_disp(data_disp),
		.seg_led(seg_led)
);


endmodule