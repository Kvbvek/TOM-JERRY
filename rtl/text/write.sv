/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Draw background.
 */


`timescale 1 ns / 1 ps
 module write #(parameter
    BEGIN_TXT_X = 930,
    BEGIN_TXT_Y = 20,
    TXT_COLOUR = 12'h0_0_0
    )
    (
     input  logic clk,
     input  logic rst,
     input  logic [7:0] char_pixels,
 
     output logic  [11:0] char_xy, //oorg 7:0
     output logic  [3:0] char_line,
 
     vga_if.in in,
     vga_if.out out
 );

import vga_pkg::*;
import game_pkg::*;
 
 /**
  * Local variables and signals
  */
logic [11:0] rgb_nxt;
logic [11:0] char_xy_nxt, char_line_calc,char_xy_calc; //org 7:0
logic [3:0] char_line_nxt;
logic [11:0] rgb_d;


logic [10:0] hcount_d, vcount_d;
logic hblnk_d, vblnk_d, hsync_d, vsync_d;



  delay #(
    .CLK_DEL(3),
    .WIDTH(38)
 )
 u_delay(
    .clk,
    .rst,
    .din({in.hblnk, in.hcount, in.hsync, in.vblnk, in.vcount, in.vsync, in.rgb}),
    .dout({hblnk_d,hcount_d,hsync_d, vblnk_d, vcount_d, vsync_d, rgb_d})
 );

 /**
  * Internal logic
  */
 
  always_ff @(posedge clk) begin : bg_ff_blk
     if (rst) begin
         out.vcount <= '0;
         out.vsync  <= '0;
         out.vblnk  <= '0;
         out.hcount <= '0;
         out.hsync  <= '0;
         out.hblnk  <= '0;
         out.rgb    <= '0;

         char_xy        <= '0;
         char_line      <= '0 ;

     end else begin
         out.vcount <= vcount_d;
         out.hcount <= hcount_d;
         out.vsync  <= vsync_d;
         out.hsync  <= hsync_d;
         out.vblnk  <= vblnk_d;
         out.hblnk  <= hblnk_d;
         
         out.rgb    <= rgb_nxt;
         char_xy        <= char_xy_nxt ;
         char_line      <= char_line_nxt ;
     end
 end
 
 always_comb begin

    char_xy_calc = in.hcount - BEGIN_TXT_X; 
    char_line_calc = in.vcount - BEGIN_TXT_Y; 
    char_xy_nxt = {char_line_calc[7:4],char_xy_calc[10:3]}; 
    char_line_nxt = {char_line_calc[3:0]}; 

    if( hcount_d >= (BEGIN_TXT_X) && 
        hcount_d <= (BEGIN_TXT_X + 255) && 
        vcount_d >= BEGIN_TXT_Y && 
        vcount_d <= (BEGIN_TXT_Y + 127)) begin 

        if(in.vblnk || in.hblnk) begin
            rgb_nxt = 12'h0_0_0;
        end
        else
            if(char_pixels[7-3'(hcount_d - BEGIN_TXT_X)]) begin
                rgb_nxt = TXT_COLOUR ; 
            end
            else begin
                rgb_nxt = rgb_d;
            end
    end
    else begin
        rgb_nxt = rgb_d;
    end
end
 
 endmodule