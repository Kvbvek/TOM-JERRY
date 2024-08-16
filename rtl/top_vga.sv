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
    input  logic clk100,
    inout  logic kclk,
    inout  logic kdata,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
    // output logic oflag
);


/**
 * Local variables and signals
 */

// VGA signals from timing
vga_if_norgb timing();
// VGA signals from background
vga_if bg();

vga_if tomctrl();
vga_if drawtom();

/**
 * Signals assignments
 */

assign vs = drawtom.vsync;
assign hs = drawtom.hsync;
assign {r,g,b} = drawtom.rgb;


/**
 * Submodules instances
 */

logic [15:0] keycode;

top u_keyboardTop(
  .clk(clk100),
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

logic [19:0] address_wire;
logic [9:0] tom_x_wire;
logic [9:0] tom_y_wire;
logic [6:0] sprite_control_wire;

host_move_ctrl u_host_move_ctrl(
    .clk,
    .rst,
    .left(left_wire),
    .right(right_wire),
    .jump(jump_wire),

    .sprite_control(sprite_control_wire),
    .x(tom_x_wire),
    .y(tom_y_wire)
);

logic [11:0] data_wire;

tom_get_sprite u_tom_get_sprite(
    .clk,
    .rst,
    .sprite_control(sprite_control_wire),
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
    .address(address_wire)
);

endmodule
