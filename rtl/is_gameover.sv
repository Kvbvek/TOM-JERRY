/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module to check the game has ended
 */


 `timescale 1 ns / 1 ps

 module is_gameover (
     input  logic clk,
     input  logic rst,
     input logic [7:0] cheese_ctr,
     input logic rst_button,
    pos_if.in jerrypos,
    pos_if.in tompos,

    output logic [1:0] gameover
 );
 
 import game_pkg::*;
 import functions_tasks_pkg::*;
 

 /**
  * Local variables and signals
  */
 logic [1:0] gameover_nxt;


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
    if(checkCollisionWithObject(tompos.x, tompos.y, jerrypos.x, jerrypos.y, TOM_WIDTH, TOM_HEIGHT, 25) != 2'b00) begin
        gameover_nxt = 2'b10;
    end
    else if(cheese_ctr == 20) begin
        gameover_nxt = 2'b01;
    end
    else begin
        gameover_nxt = 2'b00;
    end
 end
 
 endmodule
 