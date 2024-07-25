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
            if((in.vcount > 595) && (in.vcount < 605) && ((in.hcount > 180) && (in.hcount < 650) || (in.hcount > 780) && (in.hcount < 920)) || 
            (in.vcount > 455) && (in.vcount < 465) && ((in.hcount > 0) && (in.hcount < 250) || (in.hcount > 500) && (in.hcount < 600)) || 
            (in.vcount > 315) && (in.vcount < 325) && ((in.hcount > 600) && (in.hcount < 975)) || 
            (in.vcount > 215) && (in.vcount < 225) && ((in.hcount > 125) && (in.hcount < 450)))
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
