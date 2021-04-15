module top(
    input           clk,
    input           rst_n,
    input  [3:0]    col,
    input  [4:0]    a,
    input  [4:0]    b,
    output          row,
    output [7:0]    seg_led,
    output [5:0]    seg_sel,
    output          res_rdy,
    output          led7
);

assign led7 = 1'b0;

wire clk_1ms;
wire [3:0] key_pulse;
wire [7:0]  res;
wire [11:0] res_disp;

assign row = 1'b0;

keyboard keyboard_inst (
     .clk          (clk)
    ,.rst_n        (rst_n)
    ,.col          (col)
    ,.key_pulse    (key_pulse)
);

clk_div clk_div_inst  (
     .clk_in    (clk)
    ,.rst_n     (1'b1)
    ,.clk_out   (clk_1ms)
);

gcd gcd_inst    (
     .clk       (clk)
    ,.rst_n     (rst_n)
    ,.a         ({3'b0, a})
    ,.b         ({3'b0, b})
    ,.start     (key_pulse[3])
    ,.res_fetch (key_pulse[2])
    ,.res_rdy   (res_rdy)
    ,.res       (res)
);

binary2bcd binary2bcd_inst (
     .clk       (clk)
    ,.rst_n     (rst_n)
    ,.en        (res_rdy)
    ,.a         (res)
    ,.b         (res_disp)
);

wire [7:0] seg_led0, seg_led1, seg_led2;

seg_led_decoder seg_led_decoder_inst0 (
     .data_disp (res_disp[3:0])
    ,.seg_led   (seg_led0)
);

seg_led_decoder seg_led_decoder_inst1 (
     .data_disp (res_disp[7:4])
    ,.seg_led   (seg_led1)
);

seg_led_decoder seg_led_decoder_inst2 (
     .data_disp (res_disp[11:8])
    ,.seg_led   (seg_led2)
);

reg  [1:0] cnt;
wire [1:0] cnt_nxt = (cnt == 2'b10) ? 2'b00 : cnt + 1'b1;
always @ (posedge clk_1ms or negedge rst_n) begin
    if (~rst_n) 
        cnt <= 2'b00;
    else 
        cnt <= cnt_nxt;
end

assign seg_led = (cnt == 2'b00) ? seg_led0 : (
                 (cnt == 2'b01) ? seg_led1 : (
                 (cnt == 2'b10) ? seg_led2 : 6'b111111));

seg_sel_decoder seg_sel_decoder_inst (
     .bit_disp      (cnt)
    ,.seg_sel       (seg_sel)
);

endmodule