module register_4bit(clk,en,data_in,data_out);
    input clk;
    input en;
    input [3:0] data_in;
    output reg [3:0] data_out;
    always@(posedge clk) 
        if(en)
            data_out <= data_in;
endmodule
