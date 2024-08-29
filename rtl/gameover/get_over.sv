/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module to catch the information if game ended
 */

`timescale 1 ns / 1 ps

module get_over (
    input  logic clk,
    input  logic rst,
    input logic [1:0] gameover,
    input logic reset,

    output logic [1:0] over

);

// local variables
logic [1:0] over_nxt;

// output register with sync reset
always_ff @(posedge clk) begin
    if (rst) begin
        over <= '0;
    end
     else begin
        over <= over_nxt;
    end
end

// logic
always_comb begin
    if(over == 2'b10 && !reset) begin
        over_nxt = 2'b10;
    end
    else if(over == 2'b01 && !reset) begin
        over_nxt = 2'b01;
    end
    else begin
        if((gameover[1:0] != 2'b00) && (gameover[1:0] == 2'b10) && !reset) over_nxt = 2'b10;
        else if((gameover[1:0] != 2'b00) && (gameover[1:0] == 2'b01) && !reset) over_nxt = 2'b01;
        else over_nxt = 2'b00; 
    end
end


endmodule
