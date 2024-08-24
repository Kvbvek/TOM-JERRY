/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module informing if game ended
 */


`timescale 1 ns / 1 ps

module get_over (
    input  logic clk,
    input  logic rst,
    input logic [1:0] gameover,
    input logic reset,

    output logic over

);


/**
 * Local variables and signals
 */

logic over_nxt;

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
    if(over == 1'b1 && !reset) begin
        over_nxt = 1'b1;
    end
    else begin
        if((gameover[1:0] != 2'b00) && !reset) over_nxt = 1'b1;
        else over_nxt = 1'b0; 
    end
end


endmodule
