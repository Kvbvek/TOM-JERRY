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
    input logic reset,
    input logic [1:0] gameover,

    vga_if.in in,
    vga_if.out out

);

import game_pkg::*;


/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;
vga_if intr();

/**
 * Internal logic
 */


get_over u_get_over(
    .clk,
    .rst,
    .reset,
    .gameover(gameover),
    .over(over_wire)

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

    end else begin
        out.vcount <= intr.vcount;
        out.vsync  <= intr.vsync;
        out.vblnk  <= intr.vblnk;
        out.hcount <= intr.hcount;
        out.hsync  <= intr.hsync;
        out.hblnk  <= intr.hblnk;
        out.rgb    <= rgb_nxt;

    end
end


delay #(
        .WIDTH (38),
        .CLK_DEL(1)
) u_delay_ch (
        .clk (clk),
        .rst (rst),
        .din ({in.vcount, in.vblnk, in.vsync, in.hcount, in.hblnk, in.hsync,in.rgb}),
        .dout ({intr.vcount, intr.vblnk, intr.vsync, intr.hcount, intr.hblnk, intr.hsync,intr.rgb})
    );

always_comb begin
    if(over_wire) begin
            if((intr.vcount > P1_Y_START) && (intr.vcount < P1_Y_END) && ((intr.hcount > P1_X_START) && (intr.hcount < P1_X_END) || (intr.hcount > P2_X_START) && (intr.hcount < P2_X_END)) || 
            (intr.vcount > P3_Y_START) && (intr.vcount < P3_Y_END) && ((intr.hcount > P3_X_START) && (intr.hcount < P3_X_END) || (intr.hcount > P4_X_START) && (intr.hcount < P4_X_END)) || 
            (intr.vcount > P5_Y_START) && (intr.vcount < P5_Y_END) && ((intr.hcount > P5_X_START) && (intr.hcount < P5_X_END)) || 
            (intr.vcount > P6_Y_START) && (intr.vcount < P6_Y_END) && ((intr.hcount > P6_X_START) && (intr.hcount < P6_X_END)))
            begin
                rgb_nxt = 12'h8_2_0;
            end
            else rgb_nxt = intr.rgb;
    end
    else begin
        rgb_nxt = intr.rgb;
    end
end

endmodule
