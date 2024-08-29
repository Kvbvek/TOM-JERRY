/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Draw if gameover.
 */


`timescale 1 ns / 1 ps

module draw_gameover (
    input  logic clk,
    input  logic rst,
    input logic [1:0] over,

    vga_if.in in_notext,
    vga_if.in in_texttom,
    vga_if.in in_textjerry,
    vga_if.out out

);

import game_pkg::*;


/**
 * Local variables and signals
 */

// logic [11:0] rgb_nxt;
vga_if intr();
// vga_if out_over();

/**
 * Internal logic
 * 
 */

always_ff @(posedge clk) begin
    if (rst) begin
        out.vcount <= '0;
        out.vsync  <= '0;
        out.vblnk  <= '0;
        out.hcount <= '0;
        out.hsync  <= '0;
        out.hblnk  <= '0;
        out.rgb    <= '0;

    end else begin
        out.vcount <= intr.vcount;
        out.vsync  <= intr.vsync;
        out.vblnk  <= intr.vblnk;
        out.hcount <= intr.hcount;
        out.hsync  <= intr.hsync;
        out.hblnk  <= intr.hblnk;
        out.rgb    <= intr.rgb;

    end
end


always_comb begin
    if(over == 2'b10) begin
        intr.vcount = in_texttom.vcount;
        intr.vsync  = in_texttom.vsync;
        intr.vblnk  = in_texttom.vblnk;
        intr.hcount = in_texttom.hcount;
        intr.hsync  = in_texttom.hsync;
        intr.hblnk  = in_texttom.hblnk;
        intr.rgb = in_texttom.rgb;
    end
    else if(over == 2'b01) begin
        intr.vcount = in_textjerry.vcount;
        intr.vsync  = in_textjerry.vsync;
        intr.vblnk  = in_textjerry.vblnk;
        intr.hcount = in_textjerry.hcount;
        intr.hsync  = in_textjerry.hsync;
        intr.hblnk  = in_textjerry.hblnk;
        intr.rgb = in_textjerry.rgb;
    end
    else begin
        intr.vcount = in_notext.vcount;
        intr.vsync  = in_notext.vsync;
        intr.vblnk  = in_notext.vblnk;
        intr.hcount = in_notext.hcount;
        intr.hsync  = in_notext.hsync;
        intr.hblnk  = in_notext.hblnk;
        intr.rgb    = in_notext.rgb;
    end
end

endmodule
