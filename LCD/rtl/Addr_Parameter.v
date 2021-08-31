module Addr_Parameter(
    input                clk,
    input                rstn,
    input                en,
    output  reg  [15:0]  col_start,
    output  reg  [15:0]  row_start
);

wire [15:0] col_start_nxt = ( col_start == 16'd220 ) ? 16'd0 : col_start + 16'd20;
wire [15:0] row_start_nxt = ( col_start == 16'd220 ) ? ( row_start == 16'd300  ? 16'd0 : row_start + 16'd20 ): row_start;

always @(posedge clk , negedge rstn) begin
    if (!rstn) begin
        col_start <= 16'b0;
        row_start <= 16'b0;
    end else begin
        if (en) begin
            col_start <= col_start_nxt;
            row_start <= row_start_nxt;
        end
    end
end

endmodule