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
     input  logic reset,

    pos_if.in jerrypos,
    pos_if.in cheesepos,
    output logic is_cheese_taken,
    output logic [7:0] cheese_ctr,
    output logic cheese_gm
     
 );
 
 import game_pkg::*;
 import functions_tasks_pkg::*;
 
// localparam OBJ_HEIGHT = 18;
localparam MAX_CHEESE = 10;

 /**
  * Local variables and signals
  */
 logic is_cheese_taken_nxt;
 logic [7:0] cheese_ctr_nxt;
 logic [15:0] ctrd, ctrd_nxt;
logic cheese_gm_nxt;

 always_ff @(posedge clk) begin
    if (rst) begin
        is_cheese_taken <= '0;
        cheese_ctr <= '0;

        ctrd <= '0;

        cheese_gm <= '0;
    end 
    else begin
        is_cheese_taken <= is_cheese_taken_nxt;
        cheese_ctr <= cheese_ctr_nxt;

        ctrd <= ctrd_nxt;

        cheese_gm <= cheese_gm_nxt;
    end
 end
 
// logic

 always_comb begin
    if(!reset) begin
        if(checkCollisionWithObject(jerrypos.x, jerrypos.y, cheesepos.x + 10, cheesepos.y, JERRY_WIDTH, JERRY_HEIGHT, 5) != 2'b00) begin
            if(ctrd >= 10_000) begin  
                is_cheese_taken_nxt = 1;
                if(cheese_ctr >= MAX_CHEESE - 1) begin
                    cheese_ctr_nxt = 1;
                    cheese_gm_nxt = 1;
                end
                else begin
                    cheese_ctr_nxt = cheese_ctr + 1;
                    cheese_gm_nxt = 0;
                end
                ctrd_nxt = 0;
            end
            
            else begin
                is_cheese_taken_nxt = 0;
                cheese_ctr_nxt = cheese_ctr;
                ctrd_nxt = ctrd + 1;
                cheese_gm_nxt = 0;
            end
        end
        else begin
            is_cheese_taken_nxt = 0;
            cheese_ctr_nxt = cheese_ctr;
            ctrd_nxt = ctrd;
            cheese_gm_nxt = 0;
        end
    end
    else begin
        is_cheese_taken_nxt = 0;
        cheese_ctr_nxt = 0;
        ctrd_nxt = 0;
        cheese_gm_nxt = 0;
    end
 end
 
 endmodule
 