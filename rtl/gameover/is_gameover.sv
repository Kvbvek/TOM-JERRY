/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module to check if the game has ended
 */

 `timescale 1 ns / 1 ps

 module is_gameover (
     input  logic clk,
     input  logic rst,
     input logic cheese_gm,
    pos_if.in jerrypos,
    pos_if.in tompos,

    output logic [1:0] gameover
 );
 
 import game_pkg::*;
 import functions_tasks_pkg::*;
 
// local variables
 logic [1:0] gameover_nxt;

// output register with sync reset
 always_ff @(posedge clk) begin
    if (rst) begin
        gameover <= '0;
    end 
    else begin
        gameover <= gameover_nxt;
    end
 end
 
// logic
 always_comb begin
    if(((tompos.y + TOM_HEIGHT) == (jerrypos.y + JERRY_HEIGHT)) || ((tompos.y + TOM_HEIGHT) == jerrypos.y)) begin 
        if(((tompos.x >= jerrypos.x) && (tompos.x <= jerrypos.x + JERRY_WIDTH)) || ((tompos.x + TOM_WIDTH >= jerrypos.x) && (tompos.x + TOM_WIDTH <= jerrypos.x + JERRY_WIDTH))) begin 
            gameover_nxt = 2'b10;
        end
        else begin
            gameover_nxt = 2'b00;
        end
    end
    else if(cheese_gm) begin
        gameover_nxt = 2'b01;
    end
    else begin
        gameover_nxt = 2'b00;
    end
 end
 
 endmodule
 