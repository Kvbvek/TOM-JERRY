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
     input logic [9:0] tom_x,
     input logic [9:0] tom_y,
    vga_if in,

    output logic [19:0] address,
    vga_if out
 
     /* input logic [9:0] x_tom,
     input logic [9:0] y_tom */
     
 );
 
 // import vga_pkg::*;
 import game_pkg::*;
 
 
 /**
  * Local variables and signals
  */
 
logic [11:0] rgb_nxt;
logic [19:0] address_nxt;

logic [10:0] vcount_d, hcount_d;
logic [11:0] rgb_d;

 
 /**
  * Internal logic
  */

 delay #(
        .WIDTH (38),
        .CLK_DEL(3)
    ) u_delay (
        .clk (clk),
        .rst (rst),
        .din ({in.vcount, in.vblnk, in.vsync, in.hcount, in.hblnk, in.hsync,in.rgb}),
        .dout ({vcount_d, vblnk_d, vsync_d, hcount_d, hblnk_d, hsync_d, rgb_d})
    );

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
    end else begin
        out.vcount <= vcount_d;
        out.vsync  <= vsync_d;
        out.vblnk  <= vblnk_d;
        out.hcount <= hcount_d;
        out.hsync  <= hsync_d;
        out.hblnk  <= hblnk_d;
        out.rgb    <= rgb_nxt;

         address    <= address_nxt;
    end
 end
 
 always_comb begin
    address_nxt = ((in.vcount - tom_y)) * (TOM_WIDTH) + ((in.hcount - tom_x));
     if((in.vcount < (768 - tom_y)) && (in.vcount >= (768 - TOM_HEIGHT - tom_y))  && (in.hcount >= tom_x) && (in.hcount < tom_x + TOM_WIDTH)) begin
        /* if(data == 12'hf_f_f) begin
            rgb_nxt = in.rgb;
        end
        else begin 
            rgb_nxt = data;
        end */
        rgb_nxt = data;
     end
     else begin
        rgb_nxt = rgb_d;
     end
 end
 
 endmodule
 