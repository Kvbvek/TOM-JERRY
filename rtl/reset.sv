/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module to reset the game
 */

`timescale 1 ns / 1 ps

 module reset(
    input logic clk,
    input logic rst,
    input logic rst_button,
    pos_if.in jerrypos,
    pos_if.in tompos,

    output logic [1:0] reset
 );

 import game_pkg::*;

logic [1:0] reset_nxt;

 always_ff@(posedge clk) begin
    if(rst) begin
        reset <= '0;
    end else begin
        reset <= reset_nxt;
    end

 end

 always_comb begin
    if(rst_button ) begin
    end
 end



 endmodule