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
    input logic [1:0] gameover,

    vga_if.in in,
    vga_if.out out

);

import vga_pkg::*;
import game_pkg::*;


/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;
logic over, over_n, over_nxt;

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

        over <= '0;
    end else begin
        out.vcount <= in.vcount;
        out.vsync  <= in.vsync;
        out.vblnk  <= in.vblnk;
        out.hcount <= in.hcount;
        out.hsync  <= in.hsync;
        out.hblnk  <= in.hblnk;
        out.rgb    <= rgb_nxt;

        over <= over_nxt;
    end
end

always_comb begin
    if(gameover != 2'b00) over_n = 1;
    else   over_n = 0;

    if(over == 1) over_nxt = 1;
    else over_nxt = over;
    // if(over) begin
    //     if((in.vcount > P1_Y_START) && (in.vcount < P1_Y_END) && ((in.hcount > P1_X_START) && (in.hcount < P1_X_END) || (in.hcount > P2_X_START) && (in.hcount < P2_X_END)) || 
    //         (in.vcount > P3_Y_START) && (in.vcount < P3_Y_END) && ((in.hcount > P3_X_START) && (in.hcount < P3_X_END) || (in.hcount > P4_X_START) && (in.hcount < P4_X_END)) || 
    //         (in.vcount > P5_Y_START) && (in.vcount < P5_Y_END) && ((in.hcount > P5_X_START) && (in.hcount < P5_X_END)) || 
    //         (in.vcount > P6_Y_START) && (in.vcount < P6_Y_END) && ((in.hcount > P6_X_START) && (in.hcount < P6_X_END)))
    //         begin
    //             rgb_nxt = 12'h8_2_0;
    //         end
    //         else rgb_nxt = in.rgb;
    // end
    // else begin
    //     rgb_nxt = in.rgb;
    // end                            

    if(over) begin
            if((in.vcount > P1_Y_START) && (in.vcount < P1_Y_END) && ((in.hcount > P1_X_START) && (in.hcount < P1_X_END) || (in.hcount > P2_X_START) && (in.hcount < P2_X_END)) || 
            (in.vcount > P3_Y_START) && (in.vcount < P3_Y_END) && ((in.hcount > P3_X_START) && (in.hcount < P3_X_END) || (in.hcount > P4_X_START) && (in.hcount < P4_X_END)) || 
            (in.vcount > P5_Y_START) && (in.vcount < P5_Y_END) && ((in.hcount > P5_X_START) && (in.hcount < P5_X_END)) || 
            (in.vcount > P6_Y_START) && (in.vcount < P6_Y_END) && ((in.hcount > P6_X_START) && (in.hcount < P6_X_END)))
            begin
                rgb_nxt = 12'h8_2_0;
            end
            else rgb_nxt = in.rgb;
    end
    else begin
        rgb_nxt = in.rgb;
    end

end

endmodule
