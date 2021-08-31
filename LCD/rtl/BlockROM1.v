module BlockROM1 # (
    parameter ADDR_WIDTH = 17,
    parameter DATA_WIDTH = 1
)(
    input                         clk,
    input  [ADDR_WIDTH-1 : 0]     addr,
    output reg [DATA_WIDTH-1 : 0] data
);

(* ramstyle = "AUTO" *) reg [DATA_WIDTH-1 : 0] mem[(2**ADDR_WIDTH-1) : 0];

initial begin
    $readmemh("C:/Users/73474/Desktop/FPGA/LCD/LCD_instance/rtl/sign.txt", mem);
end

always @ (posedge clk) begin
    data <= mem[addr];
end

endmodule