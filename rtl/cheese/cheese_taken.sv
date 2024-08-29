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
    pos_if.in cheesepos1,
    pos_if.in cheesepos2,
    output logic [1:0] is_cheese_taken,
    output logic [7:0] cheese_ctr,
    output logic cheese_gm
     
);
 
import game_pkg::*;
import functions_tasks_pkg::*;

 // local parameters
localparam MAX_CHEESE = 10;
localparam TIMER_20S = 1_300_000_000;
localparam DELAY_TICKS = 10_000;

// local variables
logic [1:0] is_cheese_taken_nxt;
logic [7:0] cheese_ctr_nxt;
logic [15:0] ctrd, ctrd_nxt;
logic cheese_gm_nxt;
logic [31:0] waiting_ctr1, waiting_ctr1_nxt, waiting_ctr2, waiting_ctr2_nxt;

// output register with sync reset
always_ff @(posedge clk) begin 
    if (rst) begin
        is_cheese_taken <= '0;
        cheese_ctr <= '0;

        ctrd <= '0;

        cheese_gm <= '0;

        waiting_ctr1 <= '0;
        waiting_ctr2 <= '0;
    end 
    else begin
        is_cheese_taken <= is_cheese_taken_nxt;
        cheese_ctr <= cheese_ctr_nxt;

        ctrd <= ctrd_nxt;

        cheese_gm <= cheese_gm_nxt;

        waiting_ctr1 <= waiting_ctr1_nxt;
        waiting_ctr2 <= waiting_ctr2_nxt;
    end
end
 
// logic
always_comb begin
    if(!reset) begin
        if(checkCollisionWithObject(jerrypos.x, jerrypos.y, cheesepos1.x, cheesepos1.y, JERRY_WIDTH, JERRY_HEIGHT, CHEESE_WIDTH) != 2'b00) begin
            if(ctrd >= DELAY_TICKS) begin  
                is_cheese_taken_nxt = 2'b01;
                if(cheese_ctr >= MAX_CHEESE - 1) begin
                    cheese_ctr_nxt = 0;
                    cheese_gm_nxt = 1;
                end
                else begin
                    cheese_ctr_nxt = cheese_ctr + 1;
                    cheese_gm_nxt = 0;
                end
                ctrd_nxt = 0;
                waiting_ctr1_nxt = 0;
            end
            
            else begin
                is_cheese_taken_nxt = 2'b00;
                cheese_ctr_nxt = cheese_ctr;
                ctrd_nxt = ctrd + 1;
                cheese_gm_nxt = 0;
                waiting_ctr1_nxt = 0;
            end
            waiting_ctr2_nxt = waiting_ctr2;
        end

        else if(checkCollisionWithObject(jerrypos.x, jerrypos.y, cheesepos2.x, cheesepos2.y, JERRY_WIDTH, JERRY_HEIGHT, CHEESE_WIDTH) != 2'b00) begin
            if(ctrd >= DELAY_TICKS) begin  
                is_cheese_taken_nxt = 2'b10;
                if(cheese_ctr >= MAX_CHEESE - 1) begin
                    cheese_ctr_nxt = 0;
                    cheese_gm_nxt = 1;
                end
                else begin
                    cheese_ctr_nxt = cheese_ctr + 1;
                    cheese_gm_nxt = 0;
                end
                ctrd_nxt = 0;
                waiting_ctr2_nxt = 0;
            end
            
            else begin
                is_cheese_taken_nxt = 2'b00;
                cheese_ctr_nxt = cheese_ctr;
                ctrd_nxt = ctrd + 1;
                cheese_gm_nxt = 0;
                waiting_ctr2_nxt = 0;
            end
            waiting_ctr1_nxt = waiting_ctr1;
        end

        else if(waiting_ctr1 >= TIMER_20S) begin
            is_cheese_taken_nxt = 2'b01;
            cheese_ctr_nxt = cheese_ctr;
            ctrd_nxt = 0;
            cheese_gm_nxt = 0;
            waiting_ctr1_nxt = 0;
            waiting_ctr2_nxt = waiting_ctr2;
        end

        else if(waiting_ctr2 >= TIMER_20S) begin
            is_cheese_taken_nxt = 2'b10;
            cheese_ctr_nxt = cheese_ctr;
            ctrd_nxt = 0;
            cheese_gm_nxt = 0;
            waiting_ctr1_nxt = waiting_ctr1;
            waiting_ctr2_nxt = 0;
        end

        else begin
            is_cheese_taken_nxt = 2'b00;
            cheese_ctr_nxt = cheese_ctr;
            ctrd_nxt = ctrd;
            cheese_gm_nxt = 0;
            waiting_ctr1_nxt = waiting_ctr1 + 1;
            waiting_ctr2_nxt = waiting_ctr2 + 1;
        end
    end
    else begin
        is_cheese_taken_nxt = 2'b00;
        cheese_ctr_nxt = 0;
        ctrd_nxt = 0;
        cheese_gm_nxt = 0;
        waiting_ctr1_nxt = 0;
        waiting_ctr2_nxt = 0;
    end
end
 
endmodule
 