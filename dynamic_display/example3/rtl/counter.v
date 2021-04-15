module counter(clk,cnt);
    input clk;
    output reg cnt = 1'b0;
    always@(posedge clk) begin
        if(bit_disp == 1'b1)
            bit_disp <= 1'b0;
        else 
            bit_disp <= bit_disp + 1'b1;
    end
endmodule