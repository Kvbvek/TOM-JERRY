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

// local parameters
localparam COLOR_BLACK = 12'h0_0_0;
localparam PLATFORM_COLOR = 12'h1_1_1;
localparam COLOR_GREEN = 12'h0_b_0;
localparam COLOR_BROWN = 12'h8_5_2;
localparam CLOUD_COLOR = 12'hd_d_d;
localparam WINDOW_COLOR = 12'hd_d_f;
localparam ROOF_COLOR = 12'ha_1_0;
localparam HANDLE_COLOR = 12'he_e_e;
localparam DOOR_COLOR = 12'h7_4_1;
localparam WALL_COLOR = 12'hc_c_c;
localparam CHIMNEY_COLOR = 12'h2_2_2;
localparam SKY_COLOR = 12'h0_a_f;

// local variables
logic [11:0] rgb_nxt;

// output register with sync reset
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

// logic
always_comb begin : bg_comb_blk
    if (in.vblnk || in.hblnk) begin             // Blanking region:
        rgb_nxt = COLOR_BLACK;                    // - make it it black.
    end 
    else begin                              // Active region:
        if (in.vcount == 0 || in.vcount == VER_PIXELS - 1 || in.hcount == 0 || in.hcount == HOR_PIXELS - 1)                    
            rgb_nxt = COLOR_BLACK;                
        
        else begin        
            if(
            (in.vcount > P1_Y_START) && (in.vcount < P1_Y_END) && ((in.hcount > P1_X_START) && (in.hcount < P1_X_END) || (in.hcount > P2_X_START) && (in.hcount < P2_X_END)) || 
            (in.vcount > P3_Y_START) && (in.vcount < P3_Y_END) && ((in.hcount > P3_X_START) && (in.hcount < P3_X_END) || (in.hcount > P4_X_START) && (in.hcount < P4_X_END)) || 
            (in.vcount > P5_Y_START) && (in.vcount < P5_Y_END) && ((in.hcount > P5_X_START) && (in.hcount < P5_X_END)) || 
            (in.vcount > P6_Y_START) && (in.vcount < P6_Y_END) && ((in.hcount > P6_X_START) && (in.hcount < P6_X_END))
            || (in.vcount > P7_Y_START) && (in.vcount < P7_Y_END) && ((in.hcount > P7_X_START) && (in.hcount < P7_X_END))
            || (in.vcount > P8_Y_START) && (in.vcount < P8_Y_END) && ((in.hcount > P8_X_START) && (in.hcount < P8_X_END)) || (in.vcount > P9_Y_START) && (in.vcount < P9_Y_END) && ((in.hcount > P9_X_START) && (in.hcount < P9_X_END))
            || (in.hcount > P10_X_START) && (in.hcount < P10_X_END) && ((in.vcount > P10_Y_START) && (in.vcount < P10_Y_END)) 
            || (in.hcount > P11_X_START) && (in.hcount < P11_X_END) && ((in.vcount > P11_Y_START) && (in.vcount < P11_Y_END))
            || (in.hcount > P12_X_START) && (in.hcount < P12_X_END) && ((in.vcount > P12_Y_START) && (in.vcount < P12_Y_END))
            || (in.hcount > P13_X_START) && (in.hcount < P13_X_END) && ((in.vcount > P13_Y_START) && (in.vcount < P13_Y_END))
            || (in.hcount > P14_X_START) && (in.hcount < P14_X_END) && ((in.vcount > P14_Y_START) && (in.vcount < P14_Y_END))
            || (in.hcount > P15_X_START) && (in.hcount < P15_X_END) && ((in.vcount > P15_Y_START) && (in.vcount < P15_Y_END))
            || (in.hcount > P16_X_START) && (in.hcount < P16_X_END) && ((in.vcount > P16_Y_START) && (in.vcount < P16_Y_END))
            || (in.hcount > P17_X_START) && (in.hcount < P17_X_END) && ((in.vcount > P17_Y_START) && (in.vcount < P17_Y_END))
            || (in.hcount > P18_X_START) && (in.hcount < P18_X_END) && ((in.vcount > P18_Y_START) && (in.vcount < P18_Y_END))
            || (in.hcount > P19_X_START) && (in.hcount < P19_X_END) && ((in.vcount > P19_Y_START) && (in.vcount < P19_Y_END))
            )
            begin
                rgb_nxt = PLATFORM_COLOR;
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
            
            || ((in.vcount == P7_Y_START    ) && ((in.hcount > P7_X_START + 1) && (in.hcount < P7_X_END + 1)))
            || ((in.vcount == P7_Y_START - 1) && ((in.hcount > P7_X_START + 2) && (in.hcount < P7_X_END + 2)))
            || ((in.vcount == P7_Y_START - 2) && ((in.hcount > P7_X_START + 3) && (in.hcount < P7_X_END + 3)))

            || ((in.vcount == P8_Y_START    ) && ((in.hcount > P8_X_START + 1) && (in.hcount < P8_X_END + 1)))
            || ((in.vcount == P8_Y_START - 1) && ((in.hcount > P8_X_START + 2) && (in.hcount < P8_X_END + 2)))
            || ((in.vcount == P8_Y_START - 2) && ((in.hcount > P8_X_START + 3) && (in.hcount < P8_X_END + 3)))

            || ((in.vcount == P9_Y_START    ) && ((in.hcount > P9_X_START + 1) && (in.hcount < P9_X_END + 1)))
            || ((in.vcount == P9_Y_START - 1) && ((in.hcount > P9_X_START + 2) && (in.hcount < P9_X_END + 2)))
            || ((in.vcount == P9_Y_START - 2) && ((in.hcount > P9_X_START + 3) && (in.hcount < P9_X_END + 3)))

            || ((in.vcount == P11_Y_START    ) && ((in.hcount > P11_X_START + 1) && (in.hcount < P11_X_END + 1)))
            || ((in.vcount == P11_Y_START - 1) && ((in.hcount > P11_X_START + 2) && (in.hcount < P11_X_END + 2)))
            || ((in.vcount == P11_Y_START - 2) && ((in.hcount > P11_X_START + 3) && (in.hcount < P11_X_END + 3)))

            || ((in.vcount == P10_Y_START    ) && ((in.hcount > P10_X_START + 1) && (in.hcount < P10_X_END + 1)))
            || ((in.vcount == P10_Y_START - 1) && ((in.hcount > P10_X_START + 2) && (in.hcount < P10_X_END + 2)))
            || ((in.vcount == P10_Y_START - 2) && ((in.hcount > P10_X_START + 3) && (in.hcount < P10_X_END + 3)))

            || ((in.vcount == P12_Y_START    ) && ((in.hcount > P12_X_START + 1) && (in.hcount < P12_X_END + 1)))
            || ((in.vcount == P12_Y_START - 1) && ((in.hcount > P12_X_START + 2) && (in.hcount < P12_X_END + 2)))
            || ((in.vcount == P12_Y_START - 2) && ((in.hcount > P12_X_START + 3) && (in.hcount < P12_X_END + 3)))

            || ((in.vcount == P13_Y_START    ) && ((in.hcount > P13_X_START + 1) && (in.hcount < P13_X_END + 1)))
            || ((in.vcount == P13_Y_START - 1) && ((in.hcount > P13_X_START + 2) && (in.hcount < P13_X_END + 2)))
            || ((in.vcount == P13_Y_START - 2) && ((in.hcount > P13_X_START + 3) && (in.hcount < P13_X_END + 3)))

            || ((in.vcount == P14_Y_START    ) && ((in.hcount > P14_X_START + 1) && (in.hcount < P14_X_END + 1)))
            || ((in.vcount == P14_Y_START - 1) && ((in.hcount > P14_X_START + 2) && (in.hcount < P14_X_END + 2)))
            || ((in.vcount == P14_Y_START - 2) && ((in.hcount > P14_X_START + 3) && (in.hcount < P14_X_END + 3)))

            || ((in.vcount == P15_Y_START    ) && ((in.hcount > P15_X_START + 1) && (in.hcount < P15_X_END + 1)))
            || ((in.vcount == P15_Y_START - 1) && ((in.hcount > P15_X_START + 2) && (in.hcount < P15_X_END + 2)))
            || ((in.vcount == P15_Y_START - 2) && ((in.hcount > P15_X_START + 3) && (in.hcount < P15_X_END + 3)))

            || ((in.vcount == P16_Y_START    ) && ((in.hcount > P16_X_START + 1) && (in.hcount < P16_X_END + 1)))
            || ((in.vcount == P16_Y_START - 1) && ((in.hcount > P16_X_START + 2) && (in.hcount < P16_X_END + 2)))
            || ((in.vcount == P16_Y_START - 2) && ((in.hcount > P16_X_START + 3) && (in.hcount < P16_X_END + 3)))
            
            || ((in.vcount == P17_Y_START    ) && ((in.hcount > P17_X_START + 1) && (in.hcount < P17_X_END + 1)))
            || ((in.vcount == P17_Y_START - 1) && ((in.hcount > P17_X_START + 2) && (in.hcount < P17_X_END + 2)))
            || ((in.vcount == P17_Y_START - 2) && ((in.hcount > P17_X_START + 3) && (in.hcount < P17_X_END + 3)))
            
            || ((in.vcount == P18_Y_START    ) && ((in.hcount > P18_X_START + 1) && (in.hcount < P18_X_END + 1)))
            || ((in.vcount == P18_Y_START - 1) && ((in.hcount > P18_X_START + 2) && (in.hcount < P18_X_END + 2)))
            || ((in.vcount == P18_Y_START - 2) && ((in.hcount > P18_X_START + 3) && (in.hcount < P18_X_END + 3)))
            
            || ((in.vcount == P19_Y_START    ) && ((in.hcount > P19_X_START + 1) && (in.hcount < P19_X_END + 1)))
            || ((in.vcount == P19_Y_START - 1) && ((in.hcount > P19_X_START + 2) && (in.hcount < P19_X_END + 2)))
            || ((in.vcount == P19_Y_START - 2) && ((in.hcount > P19_X_START + 3) && (in.hcount < P19_X_END + 3)))
            )
            begin
                rgb_nxt = COLOR_BLACK;
            end

            // grass
            else if((in.vcount >= 550) && (in.vcount <= 767) && (in.hcount >= 1) && (in.hcount <= 1023)) begin
                if(in.vcount == 550) rgb_nxt = COLOR_BLACK;
                else rgb_nxt = COLOR_GREEN;
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
                    rgb_nxt = COLOR_BROWN;
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
                    rgb_nxt = COLOR_BROWN;
                end
            end

            // house
            else if((in.vcount <= 550) && (in.vcount >= 250) && (in.hcount >= 650) && (in.hcount <= 1023)) begin
                // roof part
                if((in.vcount < 300)) begin
                    rgb_nxt = ROOF_COLOR;
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
                        rgb_nxt = WINDOW_COLOR;
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
                        rgb_nxt = HANDLE_COLOR;
                    end
                    else begin
                        rgb_nxt = DOOR_COLOR;
                    end
                end
                // house wall
                else begin
                    rgb_nxt = WALL_COLOR;
                end
            end
            
            // roof
            else if((in.vcount >= -in.hcount + 850) && (in.vcount <= 300) && (in.vcount >= 1) && (in.hcount >= 475) && (in.hcount <= 1023)) begin
                if((in.vcount == -in.hcount + 850) || (in.vcount == 300)) begin
                    rgb_nxt = COLOR_BLACK;
                end
                else begin
                    rgb_nxt = ROOF_COLOR;
                end
            end
            else if((in.vcount <= 250) && (in.vcount >= 1) && (in.hcount >= 850) && (in.hcount <= 1023)) begin
                rgb_nxt = ROOF_COLOR;
            end

            // chimney
            else if((in.hcount >= 650) && (in.hcount <= 750) && (in.vcount >= 70) && (in.vcount <= 200)) begin
                rgb_nxt = CHIMNEY_COLOR;
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
                rgb_nxt = CLOUD_COLOR;
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
                rgb_nxt = CLOUD_COLOR;
            end

            // cloud 3
            else if(
                (in.vcount == 110) && (in.hcount >= 367  ) && (in.hcount <= 513    ) ||
                (in.vcount == 111) && (in.hcount >= 361  ) && (in.hcount <= 525    ) ||
                (in.vcount == 112) && (in.hcount >= 359  ) && (in.hcount <= 537    ) ||
                (in.vcount == 113) && (in.hcount >= 356  ) && (in.hcount <= 540 + 4) ||
                (in.vcount == 114) && (in.hcount >= 330+1) && (in.hcount <= 540 + 1) ||
                (in.vcount == 115) && (in.hcount >= 330-3) && (in.hcount <= 540 + 3) ||
                (in.vcount == 116) && (in.hcount >= 330-2) && (in.hcount <= 540 + 2) ||
                (in.vcount == 117) && (in.hcount >= 330-1) && (in.hcount <= 540 + 2) ||
                (in.vcount == 118) && (in.hcount >= 330-2) && (in.hcount <= 540 + 0) ||
                (in.vcount == 119) && (in.hcount >= 330-2) && (in.hcount <= 540 + 1) ||
                (in.vcount == 120) && (in.hcount >= 330-3) && (in.hcount <= 540 + 3) ||
                (in.vcount == 121) && (in.hcount >= 330-1) && (in.hcount <= 540 + 3) ||
                (in.vcount == 122) && (in.hcount >= 330-3) && (in.hcount <= 540 + 2) ||
                (in.vcount == 123) && (in.hcount >= 330-2) && (in.hcount <= 540 + 1) ||
                (in.vcount == 124) && (in.hcount >= 330-1) && (in.hcount <= 535    ) ||
                (in.vcount == 125) && (in.hcount >= 354-4) && (in.hcount <= 529    ) ||
                (in.vcount == 126) && (in.hcount >= 366-4) && (in.hcount <= 522    ) ||
                (in.vcount == 127) && (in.hcount >= 369-5) && (in.hcount <= 516    ) ||
                (in.vcount == 128) && (in.hcount >= 382  ) && (in.hcount <= 503    )
                ) begin
                rgb_nxt = CLOUD_COLOR;
            end

            // cloud 4
            else if(
                (in.vcount == 65) && (in.hcount >= 67  ) && (in.hcount <= 153    ) ||
                (in.vcount == 66) && (in.hcount >= 61  ) && (in.hcount <= 165    ) ||
                (in.vcount == 67) && (in.hcount >= 59  ) && (in.hcount <= 177    ) ||
                (in.vcount == 68) && (in.hcount >= 56  ) && (in.hcount <= 180 + 4) ||
                (in.vcount == 69) && (in.hcount >= 30+1) && (in.hcount <= 180 + 1) ||
                (in.vcount == 70) && (in.hcount >= 30-3) && (in.hcount <= 180 + 3) ||
                (in.vcount == 71) && (in.hcount >= 30-2) && (in.hcount <= 180 + 2) ||
                (in.vcount == 72) && (in.hcount >= 30-1) && (in.hcount <= 175    ) ||
                (in.vcount == 73) && (in.hcount >= 54-4) && (in.hcount <= 169    ) ||
                (in.vcount == 74) && (in.hcount >= 66-4) && (in.hcount <= 162    ) ||
                (in.vcount == 75) && (in.hcount >= 79-5) && (in.hcount <= 156    )
                ) begin
                rgb_nxt = CLOUD_COLOR;
            end



            else if (
                // S
                (in.vcount == 5) && (in.hcount >= 5) && (in.hcount <= 10)                ||
                (in.vcount == in.hcount - 5) && (in.hcount >= 11) && (in.hcount <= 13)   ||
                (in.vcount == -in.hcount + 10) && (in.hcount >= 2) && (in.hcount <= 5)   ||
                (in.vcount == in.hcount + 6) && (in.hcount >= 2) && (in.hcount <= 13)    ||
                (in.vcount == in.hcount + 17) && (in.hcount >= 2) && (in.hcount <= 4)    ||
                (in.vcount == -in.hcount + 33) && (in.hcount >= 11) && (in.hcount <= 13) ||
                (in.vcount == 22) && (in.hcount >= 5) && (in.hcount <= 10)               ||

                // C
                (in.vcount == 5) && (in.hcount >= 20) && (in.hcount <= 25)               ||
                (in.vcount == in.hcount - 20) && (in.hcount >= 25) && (in.hcount <= 28)  ||
                (in.vcount == -in.hcount + 25) && (in.hcount >= 17) && (in.hcount <= 20) ||
                (in.vcount == in.hcount + 2) && (in.hcount >= 17) && (in.hcount <= 20)   ||
                (in.vcount == -in.hcount + 47) && (in.hcount >= 25) && (in.hcount <= 28) ||
                (in.vcount == 22) && (in.hcount >= 20) && (in.hcount <= 25)              ||             
                (in.vcount >= 8) && (in.vcount <= 18) && (in.hcount == 17)               || 

                // O
                (in.vcount == 5) && (in.hcount >= 35) && (in.hcount <= 40)               ||
                (in.vcount == in.hcount - 35) && (in.hcount >= 40) && (in.hcount <= 43)  ||
                (in.vcount == -in.hcount + 40) && (in.hcount >= 32) && (in.hcount <= 35) ||
                (in.vcount == in.hcount - 13) && (in.hcount >= 32) && (in.hcount <= 35)  ||
                (in.vcount == -in.hcount + 62) && (in.hcount >= 40) && (in.hcount <= 43) ||
                (in.vcount == 22) && (in.hcount >= 20) && (in.hcount <= 25)              || 
                (in.vcount >= 8) && (in.vcount <= 18) && (in.hcount == 32)               ||
                (in.vcount == 22) && (in.hcount >= 35) && (in.hcount <= 40)              ||
                (in.vcount >= 8) && (in.vcount <= 18) && (in.hcount == 43)               ||

                // R
                (in.vcount == 5) && (in.hcount >= 46) && (in.hcount <= 51)               ||
                (in.vcount >= 5) && (in.vcount <= 22) && (in.hcount == 46)               ||
                (in.vcount == in.hcount - 46) && (in.hcount >= 51) && (in.hcount <= 54)  ||
                (in.vcount >= 8) && (in.vcount <= 9) && (in.hcount == 54)                ||
                (in.vcount == -in.hcount + 63) && (in.hcount >= 51) && (in.hcount <= 54) ||
                (in.vcount == 12) && (in.hcount >= 46) && (in.hcount <= 51)              ||
                (in.vcount == in.hcount - 39) && (in.hcount >= 51) && (in.hcount <= 54)  ||
                (in.vcount >= 15 ) && (in.vcount <= 22) && (in.hcount == 54)             ||
               
                //E 
                (in.vcount == 5) && (in.hcount >= 57) && (in.hcount <= 65)               ||
                (in.vcount == 22) && (in.hcount >= 57) && (in.hcount <= 65)              ||
                (in.vcount == 13) && (in.hcount >= 57) && (in.hcount <= 64)              ||
                (in.vcount >= 5) && (in.vcount <= 22) && (in.hcount == 57) 
            ) begin
                rgb_nxt = COLOR_BLACK;
            end

            else begin    // The rest of active display pixels:
                rgb_nxt = SKY_COLOR; 
            end
        end
    end
end

endmodule
