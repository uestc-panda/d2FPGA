`timescale 1ns/1ns
module binary2bcd_tb();
reg [7 : 0] a;
wire [11 : 0] b;

binary2bcd uut(
    .a(a),
    .b(b)
);

initial begin : test
    reg [7 : 0] i;
    reg [11 : 0] b_ref;
    for (i = 0; i < 255; i = i + 1) begin
        a = i;
        b_ref[3:0] = i % 10;
        b_ref[7:4] = (i/10) % 10;
        b_ref[11:8] = i/100;
        #1;
        if (b != b_ref) begin
            $display("Wrong Answer");
            $stop;
        end
        #9;
    end
    $display("Accepted");
    $stop;
end


endmodule