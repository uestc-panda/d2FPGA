module LCD_instance(
    input                 clk,
    input                 rstn,
    input       [3:0]     col,
    output      [3:0]     row,
    output                LCD_CS,
    output                LCD_RST,
    output                LCD_RS,
    output                LCD_WR,
    output                LCD_RD,
    output  reg  [15:0]   LCD_DATA,
    output                LCD_BLK
);

localparam  ADDR_WIDTH = 17;

assign LCD_RST    = rstn;
assign LCD_RD     = 1'b1;
assign LCD_BLK    = 1'b1;

/*****************************************/
//Keyboard
/*****************************************/

wire [15:0] key_pulse;
Keyboard Keyboard(
        .clk(clk)
       ,.rstn(rstn)
       ,.col(col)
       ,.row(row)
       ,.key_pulse(key_pulse)
);


/*****************************************/
//Ctrl
/*****************************************/

wire Initial_finish;
wire ini_addr_en;
wire LCD_CS_1;
wire LCD_WR_1;
WriteCtrl INI_WriteCtrl(
     .clk               (clk)
    ,.rstn              (rstn)
    ,.en                (key_pulse[0])
    ,.data_stop         (Initial_finish)
    ,.addr_en           (ini_addr_en)
    ,.LCD_CS            (LCD_CS_1)
    ,.LCD_WR            (LCD_WR_1)
);

wire color_finish;
wire delay_finish;
wire clear_finish;
wire color_addr_rstn;
wire color_addr_change;
wire delay_en;
wire delay_rstn;
wire write_en;

Color_Ctrl Color_Ctrl(
     .clk               (clk)
    ,.rstn              (rstn)
    ,.en                (key_pulse[1]&&Initial_finish)
    ,.color_finish      (color_finish)
    ,.delay_finish      (delay_finish)
    ,.clear_finish      (clear_finish)
    ,.color_addr_rstn   (color_addr_rstn)
    ,.color_addr_change (color_addr_change)
    ,.delay_en          (delay_en)
    ,.delay_rstn        (delay_rstn)
    ,.write_en          (write_en)
);


wire color_addr_en;
wire LCD_CS_2;
wire LCD_WR_2;

WriteCtrl Color_WriteCtrl(
     .clk               (clk)
    ,.rstn              (rstn)
    ,.en                (write_en)
    ,.data_stop         (color_finish||clear_finish)
    ,.addr_en           (color_addr_en)
    ,.LCD_CS            (LCD_CS_2)
    ,.LCD_WR            (LCD_WR_2)
);

assign LCD_CS = Initial_finish ? LCD_CS_2 : LCD_CS_1;
assign LCD_WR = Initial_finish ? LCD_WR_2 : LCD_WR_1;

/*****************************************/
//addr
/*****************************************/

wire [ADDR_WIDTH-1:0] ini_addr;
Addr_Ini # (
     .ADDR_WIDTH  (ADDR_WIDTH)
)   Addr_Ini (
     .clk             (clk)
    ,.rstn            (rstn)
    ,.cnt_en          (ini_addr_en)
    ,.Initial_finish  (Initial_finish)
    ,.addr            (ini_addr)
);


wire [ADDR_WIDTH-1:0] color_addr;
Addr_Color # (
     .ADDR_WIDTH  (ADDR_WIDTH)
)   Addr_Color (
     .clk             (clk)
    ,.rstn            (color_addr_rstn)
    ,.en              (color_addr_en)
    ,.color_finish    (color_finish)
    ,.clear_finish    (clear_finish)
    ,.addr            (color_addr)
);

wire [ADDR_WIDTH-1:0] addr;
assign addr = Initial_finish ? color_addr : ini_addr;
/*****************************************/
//LCD_DATA
/*****************************************/
wire [15:0] col_start;
wire [15:0] row_start;
Addr_Parameter Addr_Parameter(
     .clk(clk)
    ,.rstn(rstn)
    ,.en(color_addr_change)
    ,.col_start(col_start)
    ,.row_start(row_start)
);

wire [15:0] col_end = col_start + 16'd19;
wire [15:0] row_end = row_start + 16'd19;

wire [15:0] B_DATA;
BlockROM16 # (
     .ADDR_WIDTH  (ADDR_WIDTH) 
    ,.DATA_WIDTH  (16)
)     BlockROM_Data (
     .clk         (clk)
    ,.addr        (addr)
    ,.data        (B_DATA)
);

always @(*) begin
    case (addr)
        17'd108 : LCD_DATA = 16'h002A;
        17'd109 : LCD_DATA = {8'b0,col_start[15:8]};
        17'd110 : LCD_DATA = {8'b0,col_start[7:0]};
        17'd111 : LCD_DATA = {8'b0,col_end[15:8]};
        17'd112 : LCD_DATA = {8'b0,col_end[7:0]};
        17'd113 : LCD_DATA = 16'h002B;
        17'd114 : LCD_DATA = {8'b0,row_start[15:8]};
        17'd115 : LCD_DATA = {8'b0,row_start[7:0]};
        17'd116 : LCD_DATA = {8'b0,row_end[15:8]};
        17'd117 : LCD_DATA = {8'b0,row_end[7:0]};
        17'd118 : LCD_DATA = 16'h002C;
        17'd119 : LCD_DATA = 16'hFFE0;
        17'd120 : LCD_DATA = 16'hFFE0;      
        17'd121 : LCD_DATA = 16'h002A;
        17'd122 : LCD_DATA = {8'b0,col_start[15:8]};
        17'd123 : LCD_DATA = {8'b0,col_start[7:0]};
        17'd124 : LCD_DATA = {8'b0,col_end[15:8]};
        17'd125 : LCD_DATA = {8'b0,col_end[7:0]};
        17'd126 : LCD_DATA = 16'h002B;
        17'd127 : LCD_DATA = {8'b0,row_start[15:8]};
        17'd128 : LCD_DATA = {8'b0,row_start[7:0]};
        17'd129 : LCD_DATA = {8'b0,row_end[15:8]};
        17'd130 : LCD_DATA = {8'b0,row_end[7:0]};
        17'd131 : LCD_DATA = 16'h002C;
        17'd132 : LCD_DATA = 16'hF800;
        17'd133 : LCD_DATA = 16'hF800;
        default: LCD_DATA = B_DATA;
    endcase
end

/*****************************************/
//LCD_RS
/*****************************************/
BlockROM1 # (
     .ADDR_WIDTH  (ADDR_WIDTH)
    ,.DATA_WIDTH  (1)
)     BlockROM_Flag (
     .clk         (clk)
    ,.addr        (addr)
    ,.data        (LCD_RS)// rs = 0 -> Command Addr
);

/*****************************************/
//DELAY
/*****************************************/

Delay # (
    .delay_time(10000000)
) Delay(
     .clk(clk)
    ,.rstn(delay_rstn)
    ,.en(delay_en)
    ,.delay_finish(delay_finish)
);

endmodule
