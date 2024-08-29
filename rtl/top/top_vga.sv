/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * The project top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic clk,
    input  logic rst,
    input  logic clk87,
    inout  logic kclk,
    inout  logic kdata,
  
    input  logic l_in,
    input  logic r_in,
    input  logic j_in,

    output logic l_out,
    output logic r_out,
    output logic j_out,

    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);


/**
 * Local variables and signals
 */

vga_if_norgb timing();
vga_if bg();
vga_if tomctrl();
vga_if drawtom();
vga_if drawjerry();
vga_if drawcheese();
vga_if drawcheeseo();
vga_if drawgameover();
vga_if drawcounter();
vga_if in_over();
vga_if del_if();
vga_if choosescreen();

logic [15:0] keycode;

logic [10:0] address_wire;
logic [9:0] tom_x_wire;
logic [9:0] tom_y_wire;
logic [6:0] sprite_control_wire_t;

wire [11:0] char_xy_end;
wire [6:0] char_code_end;
wire [3:0] char_line_end;
wire [7:0] char_pixel_end;

logic [11:0] data_wire;

pos_if hostp();

logic [9:0] address_wire_j;
logic [9:0] jerry_x_wire;
logic [9:0] jerry_y_wire;
logic [6:0] sprite_control_wire_j;

logic [11:0] data_wire_j;

pos_if jerryp();
pos_if cheesep1();
pos_if cheesep2();
logic [1:0] is_cheese_taken_wire;

logic [19:0] address_wire_c1, address_wire_c2;

logic [11:0] chrgb1, chrgb2;

logic cheese_gm_wire;
logic [7:0] cheese_ctr_wire;

logic [1:0] gameover_wire;

logic left_wire, right_wire, jump_wire, reset_wire;

logic over_wire;

logic [11:0] chrgbo1, chrgbo2;


/**
 * Signals assignments
 */

assign vs = choosescreen.vsync;
assign hs = choosescreen.hsync;
assign {r,g,b} = choosescreen.rgb;

assign l_out = left_wire;
assign r_out = right_wire;
assign j_out = jump_wire;

/**
 * Submodules instances
 */

top u_keyboardTop(
  .clk(clk87),
  .rst(rst),
  .PS2Clk(kclk),
  .PS2Data(kdata),
  .keyc(keycode)
  
);

key_decoder_movement u_key_decoder_movement(
.clk(clk),
.rst(rst),
.keycode(keycode),

.left(left_wire),
.right(right_wire),
.jump(jump_wire)

);  

key_decoder_reset u_key_decoder_reset(
    .clk(clk),
    .rst(rst),
    .keycode(keycode),

    .reset(reset_wire)
);

vga_timing u_vga_timing (
    .clk,
    .rst,
    .out(timing)
);

draw_bg u_draw_bg (
    .clk,
    .rst,

    .in(timing),
    .out(bg)
);

host_move_ctrl u_host_move_ctrl(
    .clk,
    .rst,
    .over(over_wire),
    .left(left_wire),
    .right(right_wire),
    .jump(jump_wire),
    .reset(reset_wire),

    .sprite_control(sprite_control_wire_t),
    .x(tom_x_wire),
    .y(tom_y_wire)
);

tom_get_sprite u_tom_get_sprite(
    .clk,
    .rst,
    .sprite_control(sprite_control_wire_t),
    .addrA(address_wire),
    .rgb(data_wire)

);

draw_tom u_draw_tom (
    .clk,
    .rst,
    .tom_x(tom_x_wire),
    .tom_y(tom_y_wire),
    .data(data_wire),
    .in(bg),
    .out(drawtom),
    .address(address_wire),
    .host_pos(hostp)
);

player_move_ctrl u_player_move_ctrl(
    .clk,
    .rst,
    .over(over_wire),
    .left(l_in),
    .right(r_in),
    .jump(j_in),
    .reset(reset_wire),

    .sprite_control(sprite_control_wire_j),
    .x(jerry_x_wire),
    .y(jerry_y_wire)
);

jerry_get_sprite u_jerry_get_sprite(
    .clk,
    .rst,
    .sprite_control(sprite_control_wire_j),
    .addrA(address_wire_j),
    .rgb(data_wire_j)

);

draw_jerry u_draw_jerry (
    .clk,
    .rst,
    .jerry_x(jerry_x_wire),
    .jerry_y(jerry_y_wire),
    .data(data_wire_j),
    .in(drawtom),
    .out(drawjerry),
    .address(address_wire_j),
    .player_pos(jerryp)
);


cheese_taken u_cheese_taken(
    .clk,
    .rst,
    .reset(reset_wire),
    .jerrypos(jerryp),
    .cheesepos1(cheesep1),
    .cheesepos2(cheesep2),
    .is_cheese_taken(is_cheese_taken_wire),
    .cheese_ctr(cheese_ctr_wire),
    .cheese_gm(cheese_gm_wire)
);

randomx_plat u_randomx_plat(
    .clk,
    .rst,
    .rnd_generate(is_cheese_taken_wire),
    .pout1(cheesep1),
    .pout2(cheesep2)

);

delay #(
        .WIDTH (38),
        .CLK_DEL(3)
) u_delay_ch (
        .clk (clk),
        .rst (rst),
        .din ({drawjerry.vcount, drawjerry.vblnk, drawjerry.vsync, drawjerry.hcount, drawjerry.hblnk, drawjerry.hsync,drawjerry.rgb}),
        .dout ({drawcheese.vcount, drawcheese.vblnk, drawcheese.vsync, drawcheese.hcount, drawcheese.hblnk, drawcheese.hsync,drawcheese.rgb})
    );

read_rom #(
        .DATA_PATH ("../../rtl/data/cheese.dat")
) read_rom_cheese1 (
        .clk (clk),
        .addrA(address_wire_c1),
        .dout (chrgb1)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/cheese.dat")
) read_rom_cheese2 (
        .clk (clk),
        .addrA(address_wire_c2),
        .dout (chrgb2)
    );

delay #(
    .WIDTH (24),
    .CLK_DEL(1)
) u_delay_rom_ch (
    .clk (clk),
    .rst (rst),
    .din ({chrgb1, chrgb2}),
    .dout ({chrgbo1, chrgbo2})
);

draw_cheese u_draw_cheese1(
    .clk,
    .rst,
    .pin(cheesep1),
    .data(chrgbo1),
    .in(drawcheese),
    .out(drawcheeseo),
    .address(address_wire_c1)

);

vga_if drawcheese2();

draw_cheese u_draw_cheese2(
    .clk,
    .rst,
    .pin(cheesep2),
    .data(chrgbo2),
    .in(drawcheeseo),
    .out(drawcheese2),
    .address(address_wire_c2)

);

draw_cheese_counter u_draw_cheese_counter(
    .clk,
    .rst,
    .cheese_ctr(cheese_ctr_wire),
    .in(drawcheese2),
    .out(drawcounter)
);

is_gameover u_is_gameover(
    .clk,
    .rst,
    .cheese_gm(cheese_gm_wire),
    .tompos(hostp),
    .jerrypos(jerryp),
    .gameover(gameover_wire)

);

get_over u_get_over(
    .clk,
    .rst,
    .reset(reset_wire),
    .gameover(gameover_wire),
    .over(over_wire)

);

write #(
    .BEGIN_TXT_X(375),
    .BEGIN_TXT_Y(200),
    .TXT_COLOUR(12'h0_0_0)
)
u_write_gameover(
    .clk,
    .rst,
    .char_pixels(char_pixel_end),
    .char_xy(char_xy_end),
    .char_line(char_line_end),
    .in(drawcounter),
    .out(drawgameover)
);

font_rom u_font_rom(
    .clk,
    .char_code(char_code_end),
    .char_line_pixels(char_pixel_end),
    .char_line(char_line_end)
    
);
char_rom_gameover u_char_rom_gameover(
    .clk,
    .char_xy(char_xy_end),
    .char_code(char_code_end)
);

delay #(
        .WIDTH (38),
        .CLK_DEL(6)
) u_delay_text (
        .clk (clk),
        .rst (rst),
        .din ({drawcounter.vcount, drawcounter.vblnk, drawcounter.vsync, drawcounter.hcount, drawcounter.hblnk, drawcounter.hsync,drawcounter.rgb}),
        .dout ({del_if.vcount, del_if.vblnk, del_if.vsync, del_if.hcount, del_if.hblnk, del_if.hsync,del_if.rgb})
    );

draw_gameover u_draw_gameover(
    .clk,
    .rst,
    .over(over_wire),
    .in_text(drawgameover),
    .in_notext(del_if),
    .out(choosescreen)
    
);

endmodule


