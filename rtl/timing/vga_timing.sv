/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Vga timing controller.
 */

`timescale 1 ns / 1 ps

module vga_timing (
    input  logic clk,
    input  logic rst,
    vga_if_norgb.out out
);

import vga_pkg::*;

// local variables
logic [10:0] vcount_nxt;
logic vsync_nxt;
logic vblnk_nxt;
logic [10:0] hcount_nxt;
logic hsync_nxt;
logic hblnk_nxt;

// output register with sync reset
 always_ff @(posedge clk) begin
    if (rst) begin
        out.vcount <= '0;
        out.vsync  <= '0;
        out.vblnk  <= '0;
        out.hcount <= '0;
        out.hsync  <= '0;
        out.hblnk  <= '0;
    end 
    else begin
        out.vcount <= vcount_nxt;
        out.vsync  <= vsync_nxt;
        out.vblnk  <= vblnk_nxt;
        out.hcount <= hcount_nxt;
        out.hsync  <= hsync_nxt;
        out.hblnk  <= hblnk_nxt;
    end
end

// logic
always_comb begin
    if(out.hcount == (HOR_TOTAL_TIME - 1)) begin
        hcount_nxt = '0;
        if(out.vcount == (VER_TOTAL_TIME - 1)) begin 
            vcount_nxt = '0;
        end
        else begin
            vcount_nxt = out.vcount + 1;
        end
    end

    else begin
        hcount_nxt = out.hcount + 1;
        vcount_nxt = out.vcount;
    end

    if((hcount_nxt >= HOR_SYNC_START) && (hcount_nxt < HOR_SYNC_END)) begin 
        hsync_nxt = 1;
    end
    else begin 
        hsync_nxt = '0; 
    end

    if((hcount_nxt >= (HOR_BLANK_START)) && (hcount_nxt <= HOR_BLANK_END )) begin 
        hblnk_nxt = 1;
    end
    else begin 
        hblnk_nxt = '0;
    end

    if((vcount_nxt >= (VER_SYNC_START)) && (vcount_nxt < VER_SYNC_END))begin 
        vsync_nxt = 1;
    end
    else begin 
        vsync_nxt = '0;
    end

    if((vcount_nxt >= (VER_BLANK_START)) && (vcount_nxt <= VER_BLANK_END)) begin 
        vblnk_nxt = 1;
    end
    else begin 
        vblnk_nxt = '0;
    end
end

endmodule
