/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Vga timing controller.
 */

`timescale 1 ns / 1 ps

module vga_timing (
    input  logic clk,
    input  logic rst,
    output logic [10:0] vcount,
    output logic vsync,
    output logic vblnk,
    output logic [10:0] hcount,
    output logic hsync,
    output logic hblnk
);

import vga_pkg::*;


/**
 * Local variables and signals
 */
logic [10:0] vcount_nxt;
logic vsync_nxt;
logic vblnk_nxt;
logic [10:0] hcount_nxt;
logic hsync_nxt;
logic hblnk_nxt;

/**
 * Internal logic
 */
 always_ff @(posedge clk) begin
    if (rst) begin
        vcount <= '0;
        vsync  <= '0;
        vblnk  <= '0;
        hcount <= '0;
        hsync  <= '0;
        hblnk  <= '0;
    end 
    else begin
        vcount <= vcount_nxt;
        vsync  <= vsync_nxt;
        vblnk  <= vblnk_nxt;
        hcount <= hcount_nxt;
        hsync  <= hsync_nxt;
        hblnk  <= hblnk_nxt;
    end
end

always_comb begin
    if(hcount == (HOR_TOTAL_TIME - 1)) begin
        hcount_nxt = '0;
        if(vcount == (VER_TOTAL_TIME - 1)) begin 
            vcount_nxt = '0;
        end
        else begin
            vcount_nxt = vcount + 1;
        end
    end

    else begin
        hcount_nxt = hcount + 1;
        vcount_nxt = vcount;
    end

    if((hcount_nxt >= HOR_SYNC_START) && (hcount_nxt < (HOR_SYNC_START + HOR_SYNC_TIME))) begin 
        hsync_nxt = 1;
    end
    else begin 
        hsync_nxt = '0; 
    end

    if((hcount_nxt >= (HOR_BLANK_START)) && (hcount_nxt <= (HOR_TOTAL_TIME - 1))) begin 
        hblnk_nxt = 1;
    end
    else begin 
        hblnk_nxt = '0;
    end

    if((vcount_nxt >= (VER_SYNC_START)) && (vcount_nxt < (VER_SYNC_START + VER_SYNC_TIME)))begin 
        vsync_nxt = 1;
    end
    else begin 
        vsync_nxt = '0;
    end

    if((vcount_nxt >= (VER_BLANK_START)) && (vcount_nxt <= (VER_TOTAL_TIME - 1))) begin 
        vblnk_nxt = 1;
    end
    else begin 
        vblnk_nxt = '0;
    end
end

endmodule
