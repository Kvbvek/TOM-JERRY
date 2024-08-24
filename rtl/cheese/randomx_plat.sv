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
localparam PLATFORM_NUMBER = 6;

// local variables
logic [9:0] ctr, ctr_nxt;
logic [2:0] ctr1, ctr1_nxt;
pos_if pnxt();
logic start, start_nxt;


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
    if(ctr >= 1000) ctr_nxt = 0;
    else ctr_nxt = ctr + 1;

    if(ctr1 >= PLATFORM_NUMBER) ctr1_nxt = 0;
    else ctr1_nxt = ctr1 + 1;

    if(!start) begin
            if(ctr1 == 3'b000) begin
                pnxt.y = P1_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P1_LENGTH) + P1_X_START;
            end
            else if(ctr1 == 3'b001) begin
                pnxt.y = P2_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P2_LENGTH) + P2_X_START;
            end
            else if(ctr1 == 3'b010) begin
                pnxt.y = P3_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P3_LENGTH) + P3_X_START;
            end
            else if(ctr1 == 3'b011) begin
                pnxt.y = P4_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P4_LENGTH) + P4_X_START;
            end
            else if(ctr1 == 3'b100) begin
                pnxt.y = P5_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P5_LENGTH) + P5_X_START;
            end
            else if(ctr1 == 3'b101) begin
                pnxt.y = P6_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P6_LENGTH) + P6_X_START;
            end
            else begin
                pnxt.y = P1_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P1_LENGTH) + P1_X_START;
            end
    end
    else begin
        if(rnd_generate) begin
            if(ctr1 == 3'b000) begin
                pnxt.y = P1_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P1_LENGTH) + P1_X_START;
            end
            else if(ctr1 == 3'b001) begin
                pnxt.y = P2_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P2_LENGTH) + P2_X_START;
            end
            else if(ctr1 == 3'b010) begin
                pnxt.y = P3_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P3_LENGTH) + P3_X_START;
            end
            else if(ctr1 == 3'b011) begin
                pnxt.y = P4_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P4_LENGTH) + P4_X_START;
            end
            else if(ctr1 == 3'b100) begin
                pnxt.y = P5_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P5_LENGTH) + P5_X_START;
            end
            else if(ctr1 == 3'b101) begin
                pnxt.y = P6_Y_COLLISION - OBJ_HEIGHT;
                pnxt.x = (ctr % P6_LENGTH) + P6_X_START;
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
    end
    start_nxt = 1;
end
 
endmodule
 