/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * get over .
 */


`timescale 1 ns / 1 ps

module get_over (
    input  logic clk,
    input  logic rst,
    input logic [1:0] gameover,

    output logic over

);


/**
 * Local variables and signals
 */

logic over_nxt = 0;
// logic o;

/**
 * Internal logic
 */

always_ff @(posedge clk) begin
    if (rst) begin
        over <= '0;
    end
     else begin
        over <= over_nxt;
    end
end



always_comb begin
    // o_nxt = (gameover[1] | gameover[0]);
    if(over == 1'b1) begin
        over_nxt = 1'b1;
    end
    else begin
        if(gameover[1:0] != 2'b00) over_nxt = 1'b1;
        else over_nxt = 1'b0; 
    end
end


endmodule
