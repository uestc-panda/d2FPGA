module adder_4bit(ina,inb,sum,cout,cin);
    input [3:0] ina,inb;
    input cin;
    output [3:0] sum;
    output cout;
    assign {cout, sum} = ina + inb +cin;
endmodule