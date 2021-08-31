module Color_Ctrl(
    input          clk,
    input          rstn,
    input          en,
    input          color_finish,
    input          delay_finish,
    input          clear_finish,
    output   reg   color_addr_rstn,
    output   reg   color_addr_change,
    output   reg   delay_en,
    output   reg   delay_rstn,
    output   reg   write_en
);

localparam IDLE           = 8'b00000001;
localparam ADDR_CHANGE    = 8'b00000010;
localparam COLOR_WRITE_EN = 8'b00000100;
localparam COLOR_WRITE    = 8'b00001000;
localparam DELAY          = 8'b00010000;
localparam COLOR_CLEAR_EN = 8'b00100000;
localparam COLOR_CLEAR    = 8'b01000000;

reg [7:0] cur_state,nxt_state;

always @(*) begin
    case (cur_state)
        IDLE:begin
            if(en) nxt_state = COLOR_WRITE_EN;
            else nxt_state = IDLE;
        end
        ADDR_CHANGE:begin 
            nxt_state = COLOR_WRITE_EN;
        end
        COLOR_WRITE_EN:begin
            nxt_state = COLOR_WRITE;
        end
        COLOR_WRITE: begin
            if (color_finish) nxt_state = DELAY;
            else nxt_state = COLOR_WRITE;
        end
        DELAY:begin
            if (delay_finish) nxt_state = COLOR_CLEAR_EN;
            else nxt_state = DELAY;
        end
        COLOR_CLEAR_EN:begin
            nxt_state = COLOR_CLEAR;
        end
        COLOR_CLEAR:begin
            if(clear_finish) nxt_state = ADDR_CHANGE;
            else nxt_state = COLOR_CLEAR;
        end
        default: nxt_state = IDLE;
    endcase
end

always @(posedge clk, negedge rstn) begin
    if(!rstn) cur_state <= IDLE;
    else cur_state <= nxt_state;
end

always @(negedge clk , negedge rstn) begin
    if (!rstn) begin
        color_addr_rstn   <= 1'b0;
        color_addr_change <= 1'b0;
        delay_en          <= 1'b0;
        delay_rstn        <= 1'b0;
        write_en          <= 1'b0;
    end else begin
        case (nxt_state)
            IDLE:begin
                color_addr_rstn   <= 1'b0;
                color_addr_change <= 1'b0;
                delay_en          <= 1'b0;
                delay_rstn        <= 1'b0;
                write_en          <= 1'b0;
            end
            ADDR_CHANGE:begin
                color_addr_rstn   <= 1'b1;
                color_addr_change <= 1'b1;
                delay_en          <= 1'b0;
                delay_rstn        <= 1'b0;
                write_en          <= 1'b0;
            end  
            COLOR_WRITE_EN:begin
                color_addr_rstn   <= 1'b0;
                color_addr_change <= 1'b0;
                delay_en          <= 1'b0;
                delay_rstn        <= 1'b0;
                write_en          <= 1'b1;
            end            
            COLOR_WRITE:begin
                color_addr_rstn   <= 1'b1;
                color_addr_change <= 1'b0;
                delay_en          <= 1'b0;
                delay_rstn        <= 1'b0;
                write_en          <= 1'b0;
            end
            DELAY:begin
                color_addr_rstn   <= 1'b1;
                color_addr_change <= 1'b0;
                delay_en          <= 1'b1;
                delay_rstn        <= 1'b1;
                write_en          <= 1'b0;               
            end
            COLOR_CLEAR_EN:begin
                color_addr_rstn   <= 1'b1;
                color_addr_change <= 1'b0;
                delay_en          <= 1'b0;
                delay_rstn        <= 1'b1;
                write_en          <= 1'b1;
            end
            COLOR_CLEAR:begin
                color_addr_rstn   <= 1'b1;
                color_addr_change <= 1'b0;
                delay_en          <= 1'b0;
                delay_rstn        <= 1'b0;
                write_en          <= 1'b0;
            end 
            default:begin
                color_addr_rstn   <= 1'b0;
                color_addr_change <= 1'b0;
                delay_en          <= 1'b0;
                delay_rstn        <= 1'b0;
                write_en          <= 1'b0;
            end
        endcase
    end
end

endmodule