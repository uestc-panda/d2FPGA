module Addr_Color #(
    parameter ADDR_WIDTH = 17
)(
    input                          clk,
    input                          rstn,
    input                          en,
    output                         color_finish,
    output                         clear_finish,
    output      [ADDR_WIDTH-1:0]   addr 
);


reg [ADDR_WIDTH-1 : 0] cnt;
wire[ADDR_WIDTH-1 : 0] cnt_nxt = cnt < 17'd933 ? cnt + 1'b1 : 17'd107;

always @ (posedge clk or negedge rstn) begin
    if (~rstn) begin 
        cnt <= 17'd107;
    end else begin
        if (en) cnt <= cnt_nxt; 
    end
end
assign addr =  cnt < 17'd119  ? cnt : 
                     cnt < 17'd519 ? 17'd119 : 
                        cnt < 17'd533  ? cnt - 17'd400: 
                            cnt < 17'd933 ? 17'd132 : cnt - 17'd800 ;
assign color_finish = addr == 17'd120; 

assign clear_finish = addr == 17'd133;

endmodule