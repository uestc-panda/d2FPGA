module Delay # (
    parameter delay_time = 249999
)(
    input      clk,
    input      rstn,
    input      en,
    output     delay_finish
);

reg  [29:0]cnt;
wire [29:0]cnt_nxt = ( cnt == delay_time ) ? 30'b0 : cnt + 1'b1;


always @(posedge clk , negedge rstn) begin
    if (!rstn) begin
        cnt <= 30'b0;
    end else begin
        if(en) cnt <= cnt_nxt;
    end
end

assign delay_finish = ( cnt == delay_time ) ? 1'b1 : 1'b0;

endmodule