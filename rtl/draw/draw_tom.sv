/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module for drawing Tom model on display
 */

 `timescale 1 ns / 1 ps

 module draw_tom (
     input  logic clk,
     input  logic rst,
     input logic [11:0] data,
     pos_if.in tom_pos,
    vga_if.in in,

    output logic [10:0] address,
    vga_if.out out,
    pos_if.out host_pos
     
 );
 
 import game_pkg::*;
 
// local variables
logic [11:0] rgb_nxt;
logic [10:0] address_nxt;

logic [10:0] vcount_d, hcount_d, imag_x, imag_y, imag_x_nxt, imag_y_nxt;
logic [11:0] rgb_d;

logic vblnk_d, vsync_d, hblnk_d, hsync_d;

 delay #(
        .WIDTH (38),
        .CLK_DEL(4)
    ) u_delay (
        .clk (clk),
        .rst (rst),
        .din ({in.vcount, in.vblnk, in.vsync, in.hcount, in.hblnk, in.hsync,in.rgb}),
        .dout ({vcount_d, vblnk_d, vsync_d, hcount_d, hblnk_d, hsync_d, rgb_d})
    );

 // output register with sync reset
 always_ff @(posedge clk) begin
    if (rst) begin
        out.vcount <= '0;
        out.vsync  <= '0;
        out.vblnk  <= '0;
        out.hcount <= '0;
        out.hsync  <= '0;
        out.hblnk  <= '0;
        out.rgb    <= '0;

         address    <= '0;

         imag_x <= '0;
         imag_y <= '0;

         host_pos.x <= '0;
         host_pos.y <= '0;

    end else begin
        out.vcount <= vcount_d;
        out.vsync  <= vsync_d;
        out.vblnk  <= vblnk_d;
        out.hcount <= hcount_d;
        out.hsync  <= hsync_d;
        out.hblnk  <= hblnk_d;
        out.rgb    <= rgb_nxt;

         address    <= address_nxt;

         imag_x <= imag_x_nxt;
         imag_y <= imag_y_nxt;

         host_pos.x <= tom_pos.x;
         host_pos.y <= tom_pos.y;
    end
 end
 
// logic
 always_comb begin
    imag_x_nxt = in.hcount - tom_pos.x;
    imag_y_nxt = in.vcount - tom_pos.y;
    address_nxt = imag_y * TOM_WIDTH + imag_x;
     if((in.vcount >= tom_pos.y) && (in.vcount < (tom_pos.y + TOM_HEIGHT))  && (in.hcount > tom_pos.x + 4) && (in.hcount <= tom_pos.x + 4 + TOM_WIDTH)) begin
        if(data == TOM_BG_COLOR) begin
            rgb_nxt = rgb_d;
        end
        else begin 
            rgb_nxt = data;
        end
     end
     else begin
        rgb_nxt = rgb_d;
     end
 end
 
 endmodule
 