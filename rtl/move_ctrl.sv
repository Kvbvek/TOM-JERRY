//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   move_ctrl
 Author:        Tomasz Maslanka, Jakub Brzazgacz
 Version:       1.0
 Last modified: 2024-08-07
 Coding style: safe with FPGA sync reset
 Description:  Module for controlling movement of player
 */
//////////////////////////////////////////////////////////////////////////////

//`timescale 1 ns / 1 ps

 module move_ctrl (
    input  logic clk,
    input  logic rst,
    // todo input from keyboard
    input logic  left,
    input logic  right,
    input logic  jump,

    output logic [9:0] x,
    output logic [9:0] y
    
);

import game_pkg::*;
import functions_tasks_pkg::*;


//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------
// coords as two lower values, meaning upper y cord and left x cord 
localparam TOM_X_SPAWN = 500;
localparam TOM_Y_SPAWN = 768 - 1 - TOM_HEIGHT;
localparam JUMP_HEIGHT = 200;

localparam COUNTERX_STOP = 400_000;

localparam STATE_BITS = 2; // number of bits used for state register

//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------
typedef enum logic [STATE_BITS-1 :0] {
    IDLE = 2'b00, // idle state
    MOVING = 2'b01,
    JUMPING = 2'b11,
    FALLING = 2'b10
} state;
state state_c, state_nxt;

logic [19:0] counterx, counterx_nxt, countery, countery_nxt;
logic [23:0] countery_stop, countery_stop_nxt;
logic [9:0] x_tmp, x_nxt;
logic [9:0] y_tmp, y_jump_start, y_jump_start_nxt, y_nxt;
logic spawned, spawned_nxt;

always_ff @(posedge clk) begin
    if (rst) begin
        x <= '0;
        y <= '0;
        y_jump_start <= '0;

        counterx <= '0;
        countery <= '0;
        countery_stop <= '0;
        spawned <= '0;

        state_c <= IDLE;
    end 
    else begin
        x <= x_nxt;
        y <= y_nxt;
        y_jump_start <= y_jump_start_nxt;

        counterx <= counterx_nxt;
        countery <= countery_nxt;
        countery_stop <= countery_stop_nxt;
        spawned <= spawned_nxt;

        state_c <= state_nxt;
    end
end

// logic

always_comb begin
    case(state_c)
        IDLE: begin
            if(!spawned) begin
                x_tmp = TOM_X_SPAWN;
                y_tmp = TOM_Y_SPAWN;
                spawned_nxt = 1;
                state_nxt = IDLE;
                y_jump_start_nxt = 0;
            end
            else begin
                if((right && !left && !jump) || (!right && left && !jump)) begin
                    state_nxt = MOVING;
                    y_jump_start_nxt = 0;
                end
                else if(jump) begin
                    state_nxt = JUMPING;
                    y_jump_start_nxt = y;
                end
                else begin
                    state_nxt = IDLE;
                    y_jump_start_nxt = 0;
                end
                x_tmp = x;
                y_tmp = y;
                spawned_nxt = 1;
            end
            counterx_nxt = 0;
            countery_stop_nxt = 400_000;
            countery_nxt = 0;

            x_nxt = correctCoordinateX(x_tmp, TOM_WIDTH);
            y_nxt = correctCoordinateY(y_tmp, TOM_HEIGHT);
        end

        MOVING: begin
            if(right && !left) begin
                if(counterx >= COUNTERX_STOP) begin
                    x_tmp = correctCoordinateX(x + 1, TOM_WIDTH);
                    counterx_nxt = 0;
                end
                else begin
                    x_tmp = x;
                    counterx_nxt = counterx + 1;
                end
            end
            else if(!right && left) begin
                if(counterx >= COUNTERX_STOP) begin
                    x_tmp = correctCoordinateX(x - 1, TOM_WIDTH);
                    counterx_nxt = 0;
                end
                else begin
                    x_tmp = x;
                    counterx_nxt = counterx + 1;
                end
            end
            else begin
                counterx_nxt = 0;
                x_tmp = x;
            end
            // ------------------------ //
            if(jump) begin
                state_nxt = JUMPING;
                y_jump_start_nxt = y;
            end
            else if((right && !left) || (!right && left)) begin // todo jesli nie ma podlogi pod soba to pojdzie do falling
                state_nxt = MOVING;
                y_jump_start_nxt = 0;
            end
            else begin
                state_nxt = IDLE;
                y_jump_start_nxt = 0;
            end

            // y_jump_start_nxt = 0;
            y_tmp = y;
            spawned_nxt = 1;
            countery_nxt = 0;
            countery_stop_nxt = countery_stop;

            x_nxt = correctCoordinateX(x_tmp, TOM_WIDTH);
            y_nxt = correctCoordinateY(y_tmp, TOM_HEIGHT);
        end

        JUMPING: begin
            if(right && !left) begin
                if(counterx >= COUNTERX_STOP) begin
                    x_tmp = correctCoordinateX(x + 1, TOM_WIDTH);
                    counterx_nxt = 0;
                end
                else begin
                    x_tmp = x;
                    counterx_nxt = counterx + 1;
                end
            end
            else if(!right && left) begin
                if(counterx >= COUNTERX_STOP) begin
                    x_tmp = correctCoordinateX(x - 1, TOM_WIDTH);
                    counterx_nxt = 0;
                end
                else begin
                    x_tmp = x;
                    counterx_nxt = counterx + 1;
                end
            end
            else begin
                x_tmp = x;
                counterx_nxt = 0;
            end
            // ------------------------ //
            if(countery >= countery_stop) begin
                y_tmp = y - 1;
                countery_nxt = 0;
                if(countery_stop >= 800_000) begin
                    countery_stop_nxt = countery_stop;
                end
                else begin
                    countery_stop_nxt = countery_stop + 10_000;
                end
            end
            else begin
                y_tmp = y;
                countery_nxt = countery + 1;
                countery_stop_nxt = countery_stop;
            end
            if((y <= (y_jump_start - JUMP_HEIGHT)) || (checkCollisionWithAllPlatforms(x_tmp, y_tmp, TOM_WIDTH, TOM_HEIGHT) == 2'b01)) begin
                state_nxt = FALLING;
            end
            else begin
                state_nxt = JUMPING;
            end
            spawned_nxt = 1;
            y_jump_start_nxt = y_jump_start;

            x_nxt = correctCoordinateX(x_tmp, TOM_WIDTH);
            y_nxt = correctCoordinateY(y_tmp, TOM_HEIGHT);
        end

        FALLING: begin
            if(right && !left) begin
                if(counterx >= COUNTERX_STOP) begin
                    x_tmp = correctCoordinateX(x + 1, TOM_WIDTH);
                    counterx_nxt = 0;
                end
                else begin
                    x_tmp = x;
                    counterx_nxt = counterx + 1;
                end
            end
            else if(!right && left) begin
                if(counterx >= COUNTERX_STOP) begin
                    x_tmp = correctCoordinateX(x - 1, TOM_WIDTH);
                    counterx_nxt = 0;
                end
                else begin
                    x_tmp = x;
                    counterx_nxt = counterx + 1;
                end
            end
            else begin
                x_tmp = x;
                counterx_nxt = 0;
            end
            // ------------------------ //
            if(countery >= countery_stop) begin
                y_tmp = y + 1;
                countery_nxt = 0;
                if(countery_stop <= 200_000) begin
                    countery_stop_nxt = countery_stop;
                end
                else begin
                    countery_stop_nxt = countery_stop - 20_000;
                end
            end
            else begin
                y_tmp = y;
                countery_nxt = countery + 1;
                countery_stop_nxt = countery_stop;
            end
            if((y < 767 - TOM_HEIGHT) && (checkCollisionWithAllPlatforms(x_tmp, y_tmp, TOM_WIDTH, TOM_HEIGHT) == 2'b00 || 
                checkCollisionWithAllPlatforms(x_tmp, y_tmp, TOM_WIDTH, TOM_HEIGHT) == 2'b11)) begin 
                state_nxt = FALLING;
            end
            else begin
                state_nxt = IDLE;
            end
            spawned_nxt = 1;
            
            y_jump_start_nxt = 0;

            x_nxt = correctCoordinateX(x_tmp, TOM_WIDTH);
            y_nxt = correctCoordinateY(y_tmp, TOM_HEIGHT);
        end

        default: begin
            spawned_nxt = 1;
            state_nxt = IDLE;
            x_tmp = x;
            y_tmp = y;  
            counterx_nxt = 0;
            countery_stop_nxt = 0;
            countery_nxt = 0;
            y_jump_start_nxt = 0;

            x_nxt = correctCoordinateX(x_tmp, TOM_WIDTH);
            y_nxt = correctCoordinateY(y_tmp, TOM_HEIGHT);
        end
    endcase
end

endmodule
