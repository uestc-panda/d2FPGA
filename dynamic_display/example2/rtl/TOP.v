module TOP(clk_50M,en,bit_sel,data_in,seg_sel,seg_led);
    input clk_50M;
    input en;
    input [2:0] bit_sel;
    input [3:0] data_in;
    output [5:0] seg_sel;
    output [7:0] seg_led;
    parameter DIVCLK_CNTMAX = 24999; //50M/1K = 5K
    wire clk_1K;
    //例化时钟分频模块
    clock_division #(
        .DIVCLK_CNTMAX(DIVCLK_CNTMAX)
    )
    my_clock(
        .clk_in(clk_50M),
        .divclk(clk_1K)
    );
    //例化计数器模块
    wire [2:0] bit_disp;
    counter counter(
        .clk(clk_1K),
        .cnt(bit_disp)
    );
    //译码器模块
    wire [5:0] reg_en;
    decoder decoder(
        .code(bit_sel),
        .en(en),
        .data(reg_en)
    );
    //例化六个寄存器
    wire [3:0] reg_0,reg_1,reg_2,reg_3,reg_4,reg_5;
    register_4bit register_0(
        .clk(clk_50M),
        .data_in(data_in),
        .en(reg_en[0]),
        .data_out(reg_0)
    );
    register_4bit register_1(
        .clk(clk_50M),
        .data_in(data_in),
        .en(reg_en[1]),
        .data_out(reg_1)
    );
    register_4bit register_2(
        .clk(clk_50M),
        .data_in(data_in),
        .en(reg_en[2]),
        .data_out(reg_2)
    );
    register_4bit register_3(
        .clk(clk_50M),
        .data_in(data_in),
        .en(reg_en[3]),
        .data_out(reg_3)
    );
    register_4bit register_4(
        .clk(clk_50M),
        .data_in(data_in),
        .en(reg_en[4]),
        .data_out(reg_4)
    );
    register_4bit register_5(
        .clk(clk_50M),
        .data_in(data_in),
        .en(reg_en[5]),
        .data_out(reg_5)
    );
    //例化多路复用器模块
    wire [3:0] data_disp;
    Mux Mux(
        .sel(bit_disp),
        .ina(reg_0),
        .inb(reg_1),
        .inc(reg_2),
        .ind(reg_3),
        .ine(reg_4),
        .inf(reg_5),
        .data_out(data_disp)
    ); 
    //例化数码管位选译码模块
    seg_sel_decoder seg_sel_decoder(
        .bit_disp(bit_disp),
        .seg_sel(seg_sel)
    );
    //例化数码管段码译码模块
    seg_led_decoder seg_led_decoder(
        .data_disp(data_disp),
        .seg_led(seg_led)
    );
endmodule
