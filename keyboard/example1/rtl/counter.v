module counter(clk,cnt);
    input clk;
    output reg cnt = 1'b0;
    always@(posedge clk) begin
        if(cnt == 1'b1)
            cnt <= 1'b0;
        else 
            cnt <= cnt + 1'b1;
    end
endmodule