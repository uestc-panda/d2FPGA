module decoder(code,en,data);
    input [2:0] code;
    input en;
    output reg [5:0] data;
    always@(code)
        if(~en) data = 6'b000000; 
        else case(code) 
            3'b001 : data = 6'b000001;
            3'b010 : data = 6'b000010;
            3'b011 : data = 6'b000100;
            3'b100 : data = 6'b001000;
            3'b101 : data = 6'b010000;
            3'b110 : data = 6'b100000;
            default : data = 6'b000000;
        endcase 
endmodule