module BCD_functional_counter(
    input clk,                    //时钟信号输入
    input [3:0] mode,             //计数模式信号输入
    input [3:0] BCD_preset,       //预置数据信号输入
    output [3:0] BCD_out,         //4bitBCD码输出
    input bcin,                   //用于级联的信号输入
    output reg bcout              //用于级联的信号输出
    );
    parameter preset = 4'b0001;
    parameter clear = 4'b0010;
    parameter up = 4'b0100;
    parameter down = 4'b1000; 
    reg [3:0] cnt = 0;
    //BCD计数器功能描述
    always @ (posedge clk) 
        case(mode)
            preset : cnt <= BCD_preset;
            clear : cnt <= 0;
            up : if(bcin) begin 
                     if(cnt == 4'd9)
                         cnt <= 0;
                     else
                         cnt <= cnt + 1'b1;
                 end
            down : if(bcin) begin
                       if(cnt == 4'd0)
                           cnt <= 4'd9;
                       else
                           cnt <= cnt - 1'b1;
                   end
            default : cnt <= cnt;
        endcase
    assign BCD_out = cnt;      //BCD计数值输出
    //级联信号（借位输出/进位输出）
    always@(*) begin
        if(mode == up)
            bcout = bcin && (cnt == 4'd9);
        else if(mode == down)
            bcout = bcin && (cnt == 4'd0);
        else
            bcout = 1'b0;
    end
endmodule
