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
    output logic is_cheese_taken,
    output logic [7:0] cheese_ctr
     
 );
 
 import game_pkg::*;
 import functions_tasks_pkg::*;
 
localparam OBJ_HEIGHT = 18;
localparam MAX_CHEESE = 10;

 /**
  * Local variables and signals
  */
 logic is_cheese_taken_nxt;
 logic [7:0] cheese_ctr_nxt;


 always_ff @(posedge clk) begin
    if (rst) begin
        is_cheese_taken <= '0;
        cheese_ctr <= '0;
    end 
    else begin
        is_cheese_taken <= is_cheese_taken_nxt;
        cheese_ctr <= cheese_ctr_nxt;
    end
 end
 
// logic

 always_comb begin
    if(checkCollisionWithObject(jerrypos.x, jerrypos.y, cheesepos.x + 10, cheesepos.y, JERRY_WIDTH, JERRY_HEIGHT, 5) != 2'b00) begin
        is_cheese_taken_nxt = 1;
        if(cheese_ctr >= MAX_CHEESE) begin
            cheese_ctr_nxt = 1;
        end
        else begin
            cheese_ctr_nxt = cheese_ctr + 1;
        end
    end
    else begin
        is_cheese_taken_nxt = 0;
        cheese_ctr_nxt = cheese_ctr;
    end
 end
 
 endmodule
 