module WriteCtrl(
    input               clk,
    input               rstn,
    input               en,
    input               data_stop,
    output     reg      addr_en,
    output     reg      LCD_CS,
    output     reg      LCD_WR
);

localparam  IDLE  = 6'b000001;
localparam  WAIT  = 6'b000010;
localparam  WR_L  = 6'b000100;
localparam  WR_H  = 6'b001000;
localparam  ADDR  = 6'b010000;

reg [5:0] cur_state, nxt_state;

always @ (*) begin
    if (cur_state[0])
        nxt_state = en ? WAIT : IDLE;
    else if (cur_state[1]) 
        nxt_state = WR_L;
    else if (cur_state[2])
        nxt_state = WR_H;
    else if (cur_state[3])
        nxt_state = ADDR;
    else if (cur_state[4])
        nxt_state = data_stop ? IDLE : WAIT ;   
    else nxt_state = IDLE;
end

always @ (posedge clk or negedge rstn) begin
    if (~rstn) cur_state <= IDLE;
    else cur_state <= nxt_state;
end

always @(posedge clk or negedge rstn) begin
    if (~rstn) begin
        LCD_CS <= 1'b1;
        LCD_WR <= 1'b1;
        addr_en <= 1'b0;
    end else begin
        case (nxt_state)
            IDLE: begin 
                LCD_CS <= 1'b1;
                LCD_WR <= 1'b1;
                addr_en <= 1'b0;
            end
            WAIT: begin 
                LCD_CS <= 1'b0;
                LCD_WR <= 1'b1;
                addr_en <= 1'b0;
            end
            WR_L: begin 
                LCD_CS <= 1'b0;
                LCD_WR <= 1'b0;
                addr_en <= 1'b0;
            end
            WR_H: begin 
                LCD_CS <= 1'b0;
                LCD_WR <= 1'b1;
                addr_en <= 1'b0;
            end
            ADDR: begin 
                LCD_CS <= 1'b0;
                LCD_WR <= 1'b1;
                addr_en <= 1'b1; 
            end
            default: begin 
                LCD_CS <= 1'b1;
                LCD_WR <= 1'b1;
                addr_en<= 1'b0;
            end
        endcase
    end
end

endmodule 