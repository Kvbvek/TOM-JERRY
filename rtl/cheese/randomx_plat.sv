/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module for generating pseudo random coords to spawn cheese on platforms.
 * Made pseudo random because function $urandom_range() is not supported :(
 */


 `timescale 1 ns / 1 ps

 module randomx_plat (
     input  logic clk,
     input  logic rst,
     input  logic rnd_generate,

    pos_if.out pout
     
 );
 
 import game_pkg::*;
 
// local parameters
localparam OBJ_HEIGHT = 20;
localparam PLATFORM_NUMBER = 19;
localparam MAX_X_CTR = 1000;

// local variables
logic [9:0] ctr, ctr_nxt;
logic [6:0] ctr1, ctr1_nxt;
pos_if pnxt();
logic start, start_nxt;

// output register with sync reset
 always_ff @(posedge clk) begin
    if (rst) begin
        pout.x <= '0;
        pout.y <= '0;

        start <= '0;

        ctr <= '0;
        ctr1 <= '0;

    end else begin
        pout.x <= pnxt.x;
        pout.y <= pnxt.y;

        start <= start_nxt;

        ctr <= ctr_nxt;
        ctr1 <= ctr1_nxt;

    end
 end
 
// logic
always_comb begin
    if(ctr >= MAX_X_CTR) ctr_nxt = 0;
    else ctr_nxt = ctr + 1;

    if(ctr1 >= PLATFORM_NUMBER) ctr1_nxt = 0;
    else ctr1_nxt = ctr1 + 1;

    if(!start || rnd_generate) begin
        if(ctr1 == 7'd0) begin
            pnxt.y = P1_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P1_LENGTH) + P1_X_START;
        end
        else if(ctr1 == 7'd1) begin
            pnxt.y = P2_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P2_LENGTH) + P2_X_START;
        end
        else if(ctr1 == 7'd2) begin
            pnxt.y = P3_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P3_LENGTH) + P3_X_START;
        end
        else if(ctr1 == 7'd3) begin
            pnxt.y = P4_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P4_LENGTH) + P4_X_START;
        end
        else if(ctr1 == 7'd4) begin
            pnxt.y = P5_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P5_LENGTH) + P5_X_START;
        end
        else if(ctr1 == 7'd5) begin
            pnxt.y = P6_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P6_LENGTH) + P6_X_START;
        end
        else if(ctr1 == 7'd6) begin
            pnxt.y = P6_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P6_LENGTH) + P6_X_START;
        end
        else if(ctr1 == 7'd7) begin
            pnxt.y = P8_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P8_LENGTH) + P8_X_START;
        end
        else if(ctr1 == 7'd8) begin
            pnxt.y = P9_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P9_LENGTH) + P9_X_START;
        end
        else if(ctr1 == 7'd9) begin
            pnxt.y = P10_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P10_LENGTH) + P10_X_START;
        end
        else if(ctr1 == 7'd10) begin
            pnxt.y = P11_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P11_LENGTH) + P11_X_START;
        end
        else if(ctr1 == 7'd11) begin
            pnxt.y = P12_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P12_LENGTH) + P12_X_START;
        end
        else if(ctr1 == 7'd12) begin
            pnxt.y = P13_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P13_LENGTH) + P13_X_START;
        end
        else if(ctr1 == 7'd13) begin
            pnxt.y = P14_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P14_LENGTH) + P14_X_START;
        end
        else if(ctr1 == 7'd14) begin
            pnxt.y = P15_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P15_LENGTH) + P15_X_START;
        end
        else if(ctr1 == 7'd15) begin
            pnxt.y = P16_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P16_LENGTH) + P16_X_START;
        end
        else if(ctr1 == 7'd16) begin
            pnxt.y = P17_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P17_LENGTH) + P17_X_START;
        end
        else if(ctr1 == 7'd17) begin
            pnxt.y = P18_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P18_LENGTH) + P18_X_START;
        end
        else if(ctr1 == 7'd18) begin
            pnxt.y = P19_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P19_LENGTH) + P19_X_START;
        end
        else begin
            pnxt.y = P1_Y_COLLISION - OBJ_HEIGHT;
            pnxt.x = (ctr % P1_LENGTH) + P1_X_START;
        end
    end
    
    else begin
        pnxt.x = pout.x;
        pnxt.y = pout.y;
    end
    start_nxt = 1;
end
 
endmodule
 