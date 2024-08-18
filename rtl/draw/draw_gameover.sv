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
logic over, over_nxt = 0;
vga_if intr();

/**
 * Internal logic
 */

always_ff @(posedge clk) begin
    if (rst) begin
        over <= '0;
    end
     else begin
        over <= over_nxt;
    end
end

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

always_comb begin
    // if(over) over_nxt = 1;
    // else over_nxt = (gameover[1] | gameover[0]);
    over_nxt = 0;
    if(gameover[1] == 1'b1 || gameover[0] == 1'b1) over_nxt = 1;
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

   

end

delay #(
        .WIDTH (38),
        .CLK_DEL(2)
) u_delay_ch (
        .clk (clk),
        .rst (rst),
        .din ({in.vcount, in.vblnk, in.vsync, in.hcount, in.hblnk, in.hsync,in.rgb}),
        .dout ({intr.vcount, intr.vblnk, intr.vsync, intr.hcount, intr.hblnk, intr.hsync,intr.rgb})
    );

always_comb begin
    if(over) begin
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
