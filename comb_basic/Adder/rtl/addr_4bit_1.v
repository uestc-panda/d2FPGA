module adder_4bit(ina,inb,sum,cout,cin);
    input [3:0] ina, inb;
    input cin;
    output reg [3:0] sum;
    output reg cout;
    always@(*)
        {cout,sum} = ina + inb + cin;
endmodule