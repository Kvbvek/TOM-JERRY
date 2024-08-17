/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module to check if jerry took the cheese
 */


 `timescale 1 ns / 1 ps

 module cheese_taken (
     input  logic clk,
     input  logic rst,

    pos_if.in jerrypos,
    pos_if.in cheesepos,
    output logic is_cheese_taken
     
 );
 
 import game_pkg::*;
 import functions_tasks_pkg::*;
 
localparam OBJ_HEIGHT = 18;

 /**
  * Local variables and signals
  */
 logic is_cheese_taken_nxt;


 always_ff @(posedge clk) begin
    if (rst) begin
        is_cheese_taken <= '0;
    end 
    else begin
        is_cheese_taken <= is_cheese_taken_nxt;
    end
 end
 
// logic

 always_comb begin
    if(checkCollisionWithPlatform(jerrypos.x, jerrypos.y, cheesepos.x, cheesepos.y, JERRY_WIDTH, JERRY_HEIGHT, 25) != 2'b00) begin
        is_cheese_taken_nxt = 1;
    end
    else begin
        is_cheese_taken_nxt = 0;
    end
 end
 
 endmodule
 