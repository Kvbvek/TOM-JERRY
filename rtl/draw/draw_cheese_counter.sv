/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module for drawing in left upper corner counter of cheeses that Jerry has collected so far.
 */

module draw_cheese_counter (
    input  logic clk,
    input  logic rst,
    input logic [7:0] cheese_ctr,
    vga_if.in in,

    vga_if.out out
    
);

// import vga_pkg::*;
import game_pkg::*;

// local parameters
localparam CH_MIDDLE_START = 30;
localparam CH_MIDDLE_END = 40;
localparam CH_SIDE_START = 31;
localparam CH_SIDE_END = 39;

localparam CH1_X = 5;
localparam CH2_X = 10;
localparam CH3_X = 15;
localparam CH4_X = 20;
localparam CH5_X = 25;
localparam CH6_X = 30;
localparam CH7_X = 35;
localparam CH8_X = 40;
localparam CH9_X = 45;

// local variables
logic [11:0] rgb_nxt;

// output register with sync reset
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

// logic
always_comb begin
    case(cheese_ctr)
        8'd0: begin
            if((in.vcount >= 30) && (in.vcount <= 35) && (in.hcount >= 5) && (in.hcount <= 10)) rgb_nxt = 12'hf_c_0;
            else rgb_nxt = in.rgb;
        end
        8'd1: begin
            if(
                (in.hcount == CH1_X    ) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH1_X - 1) && (in.vcount >= CH_SIDE_START  ) && (in.vcount < CH_SIDE_END  ) ||
                (in.hcount == CH1_X + 1) && (in.vcount >= CH_SIDE_START  ) && (in.vcount < CH_SIDE_END  )
            ) 
            begin
            rgb_nxt = 12'hf_c_0;
            end

            else begin
                rgb_nxt = in.rgb;
            end
        end
        8'd2: begin
            if(
                (in.hcount == CH1_X    ) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH1_X - 1) && (in.vcount >= CH_SIDE_START  ) && (in.vcount < CH_SIDE_END  ) ||
                (in.hcount == CH1_X + 1) && (in.vcount >= CH_SIDE_START  ) && (in.vcount < CH_SIDE_END  ) ||

                (in.hcount == CH2_X    ) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH2_X - 1) && (in.vcount >= CH_SIDE_START  ) && (in.vcount < CH_SIDE_END  ) ||
                (in.hcount == CH2_X + 1) && (in.vcount >= CH_SIDE_START  ) && (in.vcount < CH_SIDE_END  )
            ) 
            begin
            rgb_nxt = 12'hf_c_0;
            end

            else begin
                rgb_nxt = in.rgb;
            end
        end
        8'd3: begin
            if(
                (in.hcount == CH1_X    ) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH1_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH1_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH2_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH2_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH2_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH3_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH3_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH3_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END)
            ) 
            begin
            rgb_nxt = 12'hf_c_0;
            end

            else begin
                rgb_nxt = in.rgb;
            end
        end
        8'd4: begin
            if(
                (in.hcount == CH1_X    ) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH1_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH1_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH2_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH2_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH2_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH3_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH3_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH3_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH4_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH4_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH4_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END)
            ) 
            begin
            rgb_nxt = 12'hf_c_0;
            end

            else begin
                rgb_nxt = in.rgb;
            end
        end
        8'd5: begin
            if(
                (in.hcount == CH1_X    ) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH1_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH1_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH2_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH2_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH2_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH3_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH3_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH3_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH4_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH4_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH4_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH5_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH5_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH5_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END)
            ) 
            begin
            rgb_nxt = 12'hf_c_0;
            end

            else begin
                rgb_nxt = in.rgb;
            end
        end
        8'd6: begin
            if(
                (in.hcount == CH1_X    ) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH1_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH1_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH2_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH2_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH2_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH3_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH3_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH3_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH4_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH4_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH4_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH5_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH5_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH5_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH6_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH6_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH6_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END)
            ) 
            begin
            rgb_nxt = 12'hf_c_0;
            end

            else begin
                rgb_nxt = in.rgb;
            end
        end
        8'd7: begin
            if(
                (in.hcount == CH1_X    ) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH1_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH1_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH2_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH2_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH2_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH3_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH3_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH3_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH4_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH4_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH4_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH5_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH5_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH5_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH6_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH6_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH6_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH7_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH7_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH7_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END)
            ) 
            begin
            rgb_nxt = 12'hf_c_0;
            end

            else begin
                rgb_nxt = in.rgb;
            end
        end
        8'd8: begin
            if(
                (in.hcount == CH1_X    ) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH1_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH1_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH2_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH2_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH2_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH3_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH3_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH3_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH4_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH4_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH4_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH5_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH5_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH5_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH6_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH6_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH6_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH7_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH7_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH7_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH8_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH8_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH8_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) 
            ) 
            begin
            rgb_nxt = 12'hf_c_0;
            end

            else begin
                rgb_nxt = in.rgb;
            end
        end
        8'd9: begin
            if(
                (in.hcount == CH1_X    ) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH1_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH1_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH2_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH2_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH2_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH3_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH3_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH3_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH4_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH4_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH4_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH5_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH5_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH5_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH6_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH6_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH6_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH7_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH7_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH7_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH8_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH8_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH8_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||

                (in.hcount == CH9_X) && (in.vcount >= CH_MIDDLE_START) && (in.vcount < CH_MIDDLE_END) ||
                (in.hcount == CH9_X - 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) ||
                (in.hcount == CH9_X + 1) && (in.vcount >= CH_SIDE_START) && (in.vcount < CH_SIDE_END) 
            ) 
            begin
            rgb_nxt = 12'hf_c_0;
            end

            else begin
                rgb_nxt = in.rgb;
            end
        end
        default: begin
            if((in.vcount >= 5) && (in.vcount <= 10) && (in.hcount >= 5) && (in.hcount <= 10)) rgb_nxt = 12'hf_c_0;
            else rgb_nxt = in.rgb;
        end
    endcase
end
        
     
    

endmodule