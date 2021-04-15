module priority_encoder(Data,Code,GS);
    input [3:0] Data;
    output reg [1:0] Code;
    output GS;
    assign GS = Data ? 1'b1 : 1'b0;
    always@(Data) begin
        if(Data[3]) Code = 2'b11;
        else if(Data[2]) Code = 2'b10;
        else if(Data[1]) Code = 2'b01;
        else if(Data[0]) Code = 2'b00;
        else Code = 2'b00;
    end      
endmodule