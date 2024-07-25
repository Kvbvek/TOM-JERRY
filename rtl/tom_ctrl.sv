/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module controlling the position of Tom
 */


`timescale 1 ns / 1 ps

module tom_ctrl (
    input  logic clk,
    input  logic rst,
    // todo input from keyboard

    output logic [9:0] tom_x,
    output logic [9:0] tom_y
    
);

// import vga_pkg::*;


/**
 * Local variables and signals
 */
parameter TOM_X_SPAWN = 50; // left x cord 
parameter TOM_Y_SPAWN = 718; // upper y cord with vga logic, y cords lower on down side

logic [9:0] tom_x_nxt;
logic [9:0] tom_y_nxt;


/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        tom_x <= '0;
        tom_y <= '0;
    end else begin
        tom_x <= tom_x_nxt;
        tom_y <= tom_y_nxt;
    end
end

always_comb begin
    // todo state machine for controlling movement, for now just spawn cords for Tom
    tom_x_nxt = TOM_X_SPAWN;
    tom_y_nxt = TOM_Y_SPAWN;
end

endmodule
