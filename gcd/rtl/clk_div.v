module clk_div # (
    parameter   DIV    = 50000    
)(
    input       clk_in,
    input       rst_n,
    output reg  clk_out
);

reg  [20 : 0] cnt;
wire [20 : 0] cnt_nxt = (cnt == DIV-1) ? 21'b0 : cnt + 1'b1;

always @ (posedge clk_in or negedge rst_n) begin
    if (~rst_n) cnt <= 21'b0;
    else cnt <= cnt_nxt;
end

always @ (posedge clk_in or negedge rst_n) begin
    if (~rst_n) clk_out <= 1'b0;
    else if (cnt == DIV-1) clk_out <= ~clk_out;
end

endmodule