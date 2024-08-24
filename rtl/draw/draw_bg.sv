/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Draw Game background
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

localparam COLOR_BLACK = 12'h0_0_0;
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
        rgb_nxt = COLOR_BLACK;                    // - make it it black.
    end 
    else begin                              // Active region:
        if (in.vcount == 0)                     // - top edge:
            rgb_nxt = 12'hf_f_0;                // - - make a yellow line.
        else if (in.vcount == VER_PIXELS - 1)   // - bottom edge:
            rgb_nxt = 12'hf_0_0;                // - - make a red line.
        else if (in.hcount == 0)                // - left edge:
            rgb_nxt = 12'h0_f_0;                // - - make a green line.
        else if (in.hcount == HOR_PIXELS - 1)   // - right edge:
            rgb_nxt = 12'h0_0_f;                // - - make a blue line.

        
        else begin        
            if(
            (in.vcount > P1_Y_START) && (in.vcount < P1_Y_END) && ((in.hcount > P1_X_START) && (in.hcount < P1_X_END) || (in.hcount > P2_X_START) && (in.hcount < P2_X_END)) || 
            (in.vcount > P3_Y_START) && (in.vcount < P3_Y_END) && ((in.hcount > P3_X_START) && (in.hcount < P3_X_END) || (in.hcount > P4_X_START) && (in.hcount < P4_X_END)) || 
            (in.vcount > P5_Y_START) && (in.vcount < P5_Y_END) && ((in.hcount > P5_X_START) && (in.hcount < P5_X_END)) || 
            (in.vcount > P6_Y_START) && (in.vcount < P6_Y_END) && ((in.hcount > P6_X_START) && (in.hcount < P6_X_END))
            )
            begin
                rgb_nxt = 12'h1_1_1;
            end
            
            // the graphical parts of platforms (3d lookalike)
            else if(
               ((in.vcount == P1_Y_START    ) && ((in.hcount > P1_X_START + 1) && (in.hcount < P1_X_END + 1)))
            || ((in.vcount == P1_Y_START - 1) && ((in.hcount > P1_X_START + 2) && (in.hcount < P1_X_END + 2)))
            || ((in.vcount == P1_Y_START - 2) && ((in.hcount > P1_X_START + 3) && (in.hcount < P1_X_END + 3)))

            || ((in.vcount == P2_Y_START    ) && ((in.hcount > P2_X_START + 1) && (in.hcount < P2_X_END + 1)))
            || ((in.vcount == P2_Y_START - 1) && ((in.hcount > P2_X_START + 2) && (in.hcount < P2_X_END + 2)))
            || ((in.vcount == P2_Y_START - 2) && ((in.hcount > P2_X_START + 3) && (in.hcount < P2_X_END + 3)))

            || ((in.vcount == P3_Y_START    ) && ((in.hcount > P3_X_START + 1) && (in.hcount < P3_X_END + 1)))
            || ((in.vcount == P3_Y_START - 1) && ((in.hcount > P3_X_START + 2) && (in.hcount < P3_X_END + 2)))
            || ((in.vcount == P3_Y_START - 2) && ((in.hcount > P3_X_START + 3) && (in.hcount < P3_X_END + 3)))

            || ((in.vcount == P4_Y_START    ) && ((in.hcount > P4_X_START + 1) && (in.hcount < P4_X_END + 1)))
            || ((in.vcount == P4_Y_START - 1) && ((in.hcount > P4_X_START + 2) && (in.hcount < P4_X_END + 2)))
            || ((in.vcount == P4_Y_START - 2) && ((in.hcount > P4_X_START + 3) && (in.hcount < P4_X_END + 3)))

            || ((in.vcount == P5_Y_START    ) && ((in.hcount > P5_X_START + 1) && (in.hcount < P5_X_END + 1)))
            || ((in.vcount == P5_Y_START - 1) && ((in.hcount > P5_X_START + 2) && (in.hcount < P5_X_END + 2)))
            || ((in.vcount == P5_Y_START - 2) && ((in.hcount > P5_X_START + 3) && (in.hcount < P5_X_END + 3)))

            || ((in.vcount == P6_Y_START    ) && ((in.hcount > P6_X_START + 1) && (in.hcount < P6_X_END + 1)))
            || ((in.vcount == P6_Y_START - 1) && ((in.hcount > P6_X_START + 2) && (in.hcount < P6_X_END + 2)))
            || ((in.vcount == P6_Y_START - 2) && ((in.hcount > P6_X_START + 3) && (in.hcount < P6_X_END + 3)))
            )
            begin
                rgb_nxt = COLOR_BLACK;
            end

            // grass
            else if((in.vcount >= 550) && (in.vcount <= 767) && (in.hcount >= 1) && (in.hcount <= 1023)) begin
                if(in.vcount == 550) rgb_nxt = COLOR_BLACK;
                else rgb_nxt = 12'h0_b_0;
            end

            // fence
            else if((in.vcount >= 300) && (in.vcount <= 550) && (in.hcount >= 1) && (in.hcount <= 500)) begin
                if(
                (in.vcount == 549) && (in.hcount >= 1) && (in.hcount <= 500) ||
                (in.vcount >= 300) && (in.vcount <= 550) && (in.hcount == 1) ||
                (in.vcount >= 300) && (in.vcount <= 550) && (in.hcount == 500) || 
                (in.vcount >= 300) && (in.vcount <= 550) && (in.hcount == 100) ||
                (in.vcount >= 300) && (in.vcount <= 550) && (in.hcount == 200) ||
                (in.vcount >= 300) && (in.vcount <= 550) && (in.hcount == 300) ||
                (in.vcount >= 300) && (in.vcount <= 550) && (in.hcount == 400)
                ) begin
                    rgb_nxt = COLOR_BLACK;
                end
                else begin
                    rgb_nxt = 12'h8_5_2;
                end
            end

            // top parts of fence
            else if(
            (in.vcount >= -in.hcount + 300) && (in.vcount >= in.hcount + 200) && (in.hcount >= 1  ) && (in.hcount <= 100) && (in.vcount <= 300) || 
            (in.vcount >= -in.hcount + 400) && (in.vcount >= in.hcount + 100) && (in.hcount >= 100) && (in.hcount <= 200) && (in.vcount <= 300) ||
            (in.vcount >= -in.hcount + 500) && (in.vcount >= in.hcount      ) && (in.hcount >= 200) && (in.hcount <= 300) && (in.vcount <= 300) ||
            (in.vcount >= -in.hcount + 600) && (in.vcount >= in.hcount - 100) && (in.hcount >= 300) && (in.hcount <= 400) && (in.vcount <= 300) ||
            (in.vcount >= -in.hcount + 700) && (in.vcount >= in.hcount - 200) && (in.hcount >= 400) && (in.hcount <= 500) && (in.vcount <= 300)
            ) begin
                if(
                (in.vcount == -in.hcount + 300) || (in.vcount == in.hcount + 200) || 
                (in.vcount == -in.hcount + 400) || (in.vcount == in.hcount + 100) ||
                (in.vcount == -in.hcount + 500) || (in.vcount == in.hcount      ) ||
                (in.vcount == -in.hcount + 600) || (in.vcount == in.hcount - 100) ||
                (in.vcount == -in.hcount + 700) || (in.vcount == in.hcount - 200) 
                ) begin
                    rgb_nxt = COLOR_BLACK;
                end
                else begin
                    rgb_nxt = 12'h8_5_2;
                end
            end

            // house
            else if((in.vcount <= 550) && (in.vcount >= 250) && (in.hcount >= 650) && (in.hcount <= 1023)) begin
                // roof part
                if((in.vcount < 300)) begin
                    rgb_nxt = 12'ha_1_0;
                end
                // kontury
                else if((in.hcount == 650) || (in.hcount == 1024) || (in.vcount == 300)) begin
                    rgb_nxt = COLOR_BLACK;
                end
                // window
                else if((in.hcount >= 705) && (in.hcount <= 825) && (in.vcount >= 330) && (in.vcount <= 450)) begin
                    if((in.hcount == 705) || (in.hcount == 825) || (in.vcount == 330) || (in.vcount == 450) || (in.vcount == 390) || (in.hcount == 765)) begin
                        rgb_nxt = COLOR_BLACK;
                    end
                    else begin
                        rgb_nxt = 12'hd_d_f;
                    end
                end
                // doors
                else if((in.hcount >= 910) && (in.vcount >= 350) && (in.vcount < 550)) begin
                    if((in.hcount == 910) || (in.vcount == 350)) begin
                        rgb_nxt = COLOR_BLACK;
                    end
                    else if(((in.vcount >= 448) && (in.vcount <= 451)) && (in.hcount == 915) ||
                    ((in.vcount >= 448) && (in.vcount <= 449)) && (in.hcount >= 915) && (in.hcount <= 925)
                    ) begin
                        rgb_nxt = 12'he_e_e;
                    end
                    else begin
                        rgb_nxt = 12'h7_4_1;
                    end
                end
                // house wall
                else begin
                    rgb_nxt = 12'hc_c_c;
                end
            end
            
            // roof
            else if((in.vcount >= -in.hcount + 850) && (in.vcount <= 300) && (in.vcount >= 1) && (in.hcount >= 475) && (in.hcount <= 1023)) begin
                if((in.vcount == -in.hcount + 850) || (in.vcount == 300)) begin
                    rgb_nxt = COLOR_BLACK;
                end
                else begin
                    rgb_nxt = 12'ha_1_0;
                end
            end
            else if((in.vcount <= 250) && (in.vcount >= 1) && (in.hcount >= 850) && (in.hcount <= 1023)) begin
                rgb_nxt = 12'ha_1_0;
            end

            // chimney
            else if((in.hcount >= 650) && (in.hcount <= 750) && (in.vcount >= 70) && (in.vcount <= 200)) begin
                rgb_nxt = 12'h2_2_2;
            end

            // cloud 1
            else if(
                (in.vcount == 150) && (in.hcount >= 137  ) && (in.hcount <= 173    ) ||
                (in.vcount == 151) && (in.hcount >= 131  ) && (in.hcount <= 185    ) ||
                (in.vcount == 152) && (in.hcount >= 129  ) && (in.hcount <= 197    ) ||
                (in.vcount == 153) && (in.hcount >= 126  ) && (in.hcount <= 200 + 4) ||
                (in.vcount == 154) && (in.hcount >= 100+1) && (in.hcount <= 200 + 1) ||
                (in.vcount == 155) && (in.hcount >= 100-3) && (in.hcount <= 200 + 3) ||
                (in.vcount == 156) && (in.hcount >= 100-2) && (in.hcount <= 200 + 2) ||
                (in.vcount == 157) && (in.hcount >= 100-1) && (in.hcount <= 195    ) ||
                (in.vcount == 158) && (in.hcount >= 124-4) && (in.hcount <= 189    ) ||
                (in.vcount == 159) && (in.hcount >= 136-4) && (in.hcount <= 182    ) ||
                (in.vcount == 160) && (in.hcount >= 139-5) && (in.hcount <= 176    )
                ) begin
                rgb_nxt = 12'hd_d_d;
            end

            // cloud 2
            else if(
                (in.vcount == 50) && (in.hcount >= 437  ) && (in.hcount <= 473    ) ||
                (in.vcount == 51) && (in.hcount >= 431  ) && (in.hcount <= 485    ) ||
                (in.vcount == 52) && (in.hcount >= 429  ) && (in.hcount <= 497    ) ||
                (in.vcount == 53) && (in.hcount >= 426  ) && (in.hcount <= 500 + 4) ||
                (in.vcount == 54) && (in.hcount >= 400+1) && (in.hcount <= 500 + 1) ||
                (in.vcount == 55) && (in.hcount >= 400-3) && (in.hcount <= 500 + 3) ||
                (in.vcount == 56) && (in.hcount >= 400-2) && (in.hcount <= 500 + 2) ||
                (in.vcount == 57) && (in.hcount >= 400-1) && (in.hcount <= 500 + 2) ||
                (in.vcount == 58) && (in.hcount >= 400-2) && (in.hcount <= 500 + 0) ||
                (in.vcount == 59) && (in.hcount >= 400-2) && (in.hcount <= 500 + 1) ||
                (in.vcount == 60) && (in.hcount >= 400-3) && (in.hcount <= 500 + 3) ||
                (in.vcount == 61) && (in.hcount >= 400-1) && (in.hcount <= 500 + 3) ||
                (in.vcount == 62) && (in.hcount >= 400-3) && (in.hcount <= 500 + 2) ||
                (in.vcount == 63) && (in.hcount >= 400-2) && (in.hcount <= 500 + 1) ||
                (in.vcount == 64) && (in.hcount >= 400-1) && (in.hcount <= 495    ) ||
                (in.vcount == 65) && (in.hcount >= 424-4) && (in.hcount <= 489    ) ||
                (in.vcount == 66) && (in.hcount >= 436-4) && (in.hcount <= 482    ) ||
                (in.vcount == 67) && (in.hcount >= 439-5) && (in.hcount <= 476    )
                ) begin
                rgb_nxt = 12'hd_d_d;
            end

            else begin    // The rest of active display pixels:
                rgb_nxt = 12'h0_a_f; 
            end
        end
    end
end

endmodule
