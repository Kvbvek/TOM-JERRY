//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   tom_ctrl
 Author:        Tomasz Maslanka, Jakub Brzazgacz
 Version:       1.0
 Last modified: 2024-07-28
 Coding style: safe with FPGA sync reset
 Description:  Module for controlling movement left right of player
 */
//////////////////////////////////////////////////////////////////////////////

//`timescale 1 ns / 1 ps

module tom_ctrl (
    input  logic clk,
    input  logic rst,
    // todo input from keyboard
    input logic left,
    input logic right,

    output logic [9:0] tom_x,
    output logic [9:0] tom_y
    
);

// import vga_pkg::*;


//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------
// coords as two lower values, meaning upper y cord and left x cord 
localparam TOM_X_SPAWN = 500;
localparam TOM_Y_SPAWN = 700;
localparam COUNTER_STOP = 500_000;

//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------

logic [19:0] counter, counter_nxt;

logic [9:0] tom_x_nxt;
logic [9:0] tom_y_nxt;
logic spawned, spawned_nxt;

always_ff @(posedge clk) begin
    if (rst) begin
        tom_x <= '0;
        tom_y <= '0;

        counter <= '0;
        spawned <= '0;
    end else begin
        tom_x <= tom_x_nxt;
        tom_y <= tom_y_nxt;

        counter <= counter_nxt;
        spawned <= spawned_nxt;
    end
end

// logic

always_comb begin
    if(!spawned) begin
        tom_x_nxt = TOM_X_SPAWN;
        tom_y_nxt = TOM_Y_SPAWN;
        spawned_nxt = 1;
        counter_nxt = 0;
    end
    else begin 
        if(right && !left) begin
            if(counter >= COUNTER_STOP) begin
                tom_x_nxt = tom_x + 1;
                tom_y_nxt = tom_y;
                counter_nxt = 0;
            end
            else begin 
                tom_x_nxt = tom_x;
                tom_y_nxt = tom_y;
                counter_nxt = counter + 1;
            end
        end
        else if(!right && left) begin
            if(counter >= COUNTER_STOP) begin
                tom_x_nxt = tom_x - 1;
                tom_y_nxt = tom_y;
                counter_nxt = 0;
            end
            else begin 
                tom_x_nxt = tom_x;
                tom_y_nxt = tom_y;
                counter_nxt = counter + 1;
            end
        end
        else begin
            tom_x_nxt = tom_x;
            tom_y_nxt = tom_y;
            counter_nxt = 0;
        end
        spawned_nxt = 1;
    end
end

endmodule
