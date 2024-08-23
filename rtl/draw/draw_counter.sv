/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module 
 */
module draw_counter (
    input  logic clk,
    input  logic rst,
    input logic [7:0] cheese_ctr,
    vga_if.in in,

    vga_if.out out
    
);

// import vga_pkg::*;
import game_pkg::*;

// localparam NUMBER_X_SPAWN = 900;
// localparam NUMBER_Y_SPAWN = 600;

logic [11:0] rgb_nxt;


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
            out.vcount <= in.vcount;
            out.vsync  <= in.vsync;
            out.vblnk  <= in.vblnk;
            out.hcount <= in.hcount;
            out.hsync  <= in.hsync;
            out.hblnk  <= in.hblnk;
            out.rgb    <= rgb_nxt;
    
        end
    end
    always_comb begin
        case(cheese_ctr)
            8'd0: begin
                if((in.vcount == 5) && (in.hcount >= 1000) && (in.hcount < 1015)) rgb_nxt = 12'h3_2_6;
                else rgb_nxt = in.rgb;
            end
            8'd1: begin
                if((in.hcount == 950) && (in.vcount >= 5) && (in.vcount < 15)) rgb_nxt = 12'h3_2_6;
                else rgb_nxt = in.rgb;
            end
            8'd2: begin
                if(((in.hcount == 950) || (in.hcount == 955)) && (in.vcount >= 5) && (in.vcount < 15)) rgb_nxt = 12'h3_2_6;
                else rgb_nxt = in.rgb;
            end
            8'd3: begin
                if(((in.hcount == 950) || (in.hcount == 955) || (in.hcount == 960)) && (in.vcount >= 5) && (in.vcount < 15)) rgb_nxt = 12'h3_2_6;
                else rgb_nxt = in.rgb;
            end
            8'd4: begin
                if(((in.hcount == 950) || (in.hcount == 955) || (in.hcount == 960) || (in.hcount == 965)) && (in.vcount >= 5) && (in.vcount < 15)) rgb_nxt = 12'h3_2_6;
                else rgb_nxt = in.rgb;
            end
            8'd5: begin
                if(((in.hcount == 950) || (in.hcount == 955) || (in.hcount == 960) || (in.hcount == 965) || (in.hcount == 970)) && (in.vcount >= 5) && (in.vcount < 15)) rgb_nxt = 12'h3_2_6;
                else rgb_nxt = in.rgb;
            end
            8'd6: begin
                if(((in.hcount == 950) || (in.hcount == 955) || (in.hcount == 960) || (in.hcount == 965) || (in.hcount == 970) || (in.hcount == 975)) && (in.vcount >= 5) && (in.vcount < 15)) rgb_nxt = 12'h3_2_6;
                else rgb_nxt = in.rgb;
            end
            8'd7: begin
                if(((in.hcount == 950) || (in.hcount == 955) || (in.hcount == 960) || (in.hcount == 965) || (in.hcount == 970) || (in.hcount == 975) || (in.hcount == 980)) && (in.vcount >= 5) && (in.vcount < 15)) rgb_nxt = 12'h3_2_6;
                else rgb_nxt = in.rgb;
            end
            8'd8: begin
                if(((in.hcount == 950) || (in.hcount == 955) || (in.hcount == 960) || (in.hcount == 965) || (in.hcount == 970) || (in.hcount == 975) || (in.hcount == 980) || (in.hcount == 985)) && (in.vcount >= 5) && (in.vcount < 15)) rgb_nxt = 12'h3_2_6;
                else rgb_nxt = in.rgb;
            end
            8'd9: begin
                if(((in.hcount == 950) || (in.hcount == 955) || (in.hcount == 960) || (in.hcount == 965) || (in.hcount == 970) || (in.hcount == 975) || (in.hcount == 980) || (in.hcount == 985) || (in.hcount == 985)) && (in.vcount >= 5) && (in.vcount < 15)) rgb_nxt = 12'h3_2_6;
                else rgb_nxt = in.rgb;
            end
            default: begin
                if((in.vcount == 5) && (in.hcount >= 1000) && (in.hcount < 1015)) rgb_nxt = 12'h3_2_6;
                else rgb_nxt = in.rgb;
            end
        endcase
    end
        
     
    

endmodule