/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Draw background.
 */


`timescale 1 ns / 1 ps

module draw_bg (
    input  logic clk,
    input  logic rst,

    vga_if_norgb.in in,
    vga_if.out out

);

import vga_pkg::*;
import game_pkg::*;


/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;


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
    end else begin
        out.vcount <= in.vcount;
        out.vsync  <= in.vsync;
        out.vblnk  <= in.vblnk;
        out.hcount <= in.hcount;
        out.hsync  <= in.hsync;
        out.hblnk  <= in.hblnk;
        out.rgb    <= rgb_nxt;
    end
end

always_comb begin : bg_comb_blk
    if (in.vblnk || in.hblnk) begin             // Blanking region:
        rgb_nxt = 12'h0_0_0;                    // - make it it black.
    end else begin                              // Active region:
        if (in.vcount == 0)                     // - top edge:
            rgb_nxt = 12'hf_f_0;                // - - make a yellow line.
        else if (in.vcount == VER_PIXELS - 1)   // - bottom edge:
            rgb_nxt = 12'hf_0_0;                // - - make a red line.
        else if (in.hcount == 0)                // - left edge:
            rgb_nxt = 12'h0_f_0;                // - - make a green line.
        else if (in.hcount == HOR_PIXELS - 1)   // - right edge:
            rgb_nxt = 12'h0_0_f;                // - - make a blue line.

        
        else begin        
            if((in.vcount > P1_Y_START) && (in.vcount < P1_Y_END) && ((in.hcount > P1_X_START) && (in.hcount < P1_X_END) || (in.hcount > P2_X_START) && (in.hcount < P2_X_END)) || 
            (in.vcount > P3_Y_START) && (in.vcount < P3_Y_END) && ((in.hcount > P3_X_START) && (in.hcount < P3_X_END) || (in.hcount > P4_X_START) && (in.hcount < P4_X_END)) || 
            (in.vcount > P5_Y_START) && (in.vcount < P5_Y_END) && ((in.hcount > P5_X_START) && (in.hcount < P5_X_END)) || 
            (in.vcount > P6_Y_START) && (in.vcount < P6_Y_END) && ((in.hcount > P6_X_START) && (in.hcount < P6_X_END)))
            begin
                rgb_nxt = 12'h0_0_0;
            end
            else begin    // The rest of active display pixels:
                rgb_nxt = 12'ha_a_a; 
            end
        end // - fill with gray.
    end
end

endmodule