/*
 Module name:   host_move_ctrl
 Author:        Tomasz Maslanka, Jakub Brzazgacz
 Version:       1.0
 Last modified: 2024-08-07
 Coding style: safe with FPGA sync reset
 Description:  Module for controlling movement of host
 */

`timescale 1 ns / 1 ps

 module host_move_ctrl (
    input  logic clk,
    input  logic rst,
    input  logic reset,
    input logic [1:0] over,

    input logic  left,
    input logic  right,
    input logic  jump,

    output logic [6:0] sprite_control, // {prawo,skok,idle,licznik}
    
    pos_if.out tom_pos
    
);

import game_pkg::*;
import functions_tasks_pkg::*;


// local parameters
// coords as two lower values, meaning upper y cord and left x cord 
localparam TOM_X_SPAWN = 500;
localparam TOM_Y_SPAWN = 768 - 5 - TOM_HEIGHT;
localparam JUMP_HEIGHT = 200;

localparam COUNTERX_STOP = 425_000;
localparam COUNTERX_AIR_STOP = 600_000;

localparam STATE_BITS = 2; // number of bits used for state register

// local variables
typedef enum logic [STATE_BITS-1 :0] {
    IDLE = 2'b00, // idle state
    MOVING = 2'b01,
    JUMPING = 2'b11,
    FALLING = 2'b10
} state;
state state_c, state_nxt;

logic [19:0] counterx, counterx_nxt, countery, countery_nxt;
logic [19:0] countery_jump_stop, countery_jump_stop_nxt;
logic [19:0] countery_fall_stop, countery_fall_stop_nxt;
logic [9:0] x_tmp, x_nxt;
logic [9:0] y_tmp, y_jump_start, y_jump_start_nxt, y_nxt;
logic [6:0] sprite_control_nxt;

// output register with sync reset
always_ff @(posedge clk) begin
    if (rst) begin
        tom_pos.x <= TOM_X_SPAWN;
        tom_pos.y <= TOM_Y_SPAWN;
        y_jump_start <= '0;

        counterx <= '0;
        countery <= '0;
        countery_fall_stop <= '0;
        countery_jump_stop <= '0;

        sprite_control <= '0;

        state_c <= IDLE;
    end 
    else begin
        tom_pos.x <= x_nxt;
        tom_pos.y <= y_nxt;
        y_jump_start <= y_jump_start_nxt;

        counterx <= counterx_nxt;
        countery <= countery_nxt;
        countery_fall_stop <= countery_fall_stop_nxt;
        countery_jump_stop <= countery_jump_stop_nxt;

        sprite_control <= sprite_control_nxt;

        state_c <= state_nxt;
    end
end

// logic
always_comb begin
    case(state_c)
        IDLE: begin
            if(reset || over != 2'b00) begin
                x_tmp = TOM_X_SPAWN;
                y_tmp = TOM_Y_SPAWN;
                state_nxt = IDLE;
                
                sprite_control_nxt = 7'b1010000;
            end

            else begin
                if((right && !left && !jump) || (!right && left && !jump)) begin
                    state_nxt = MOVING;
                end
                else if(jump) begin
                    state_nxt = JUMPING;
                end
                else begin
                    state_nxt = IDLE;
                end
                x_tmp = tom_pos.x;
                y_tmp = tom_pos.y;

                sprite_control_nxt = {sprite_control[6],6'b010000};
            end

            y_jump_start_nxt = tom_pos.y;

            counterx_nxt = 0;
            countery_nxt = 0;
            countery_jump_stop_nxt = 200_000;
            countery_fall_stop_nxt = 800_000;

            x_nxt = correctCoordinateX(x_tmp, TOM_WIDTH);
            y_nxt = correctCoordinateY(y_tmp, TOM_HEIGHT);
        end

        MOVING: begin
            if(right && !left) begin
                if(counterx >= COUNTERX_STOP) begin
                    x_tmp = correctCoordinateX(tom_pos.x + 1, TOM_WIDTH);
                    counterx_nxt = 0;
                    if((tom_pos.x % 8) == 0) begin
                        sprite_control_nxt[3:0] = (sprite_control[3:0] + 1) % 8;
                    end
                    else begin
                        sprite_control_nxt[3:0] = sprite_control[3:0];
                    end
                end
                else begin
                    x_tmp = tom_pos.x;
                    counterx_nxt = counterx + 1;
                    sprite_control_nxt[3:0] = sprite_control[3:0];
                end
                sprite_control_nxt[6:4] = 3'b100;
            end

            else if(!right && left) begin
                if(counterx >= COUNTERX_STOP) begin
                    x_tmp = correctCoordinateX(tom_pos.x - 1, TOM_WIDTH);
                    counterx_nxt = 0;
                    if((tom_pos.x % 8) == 0) begin
                        sprite_control_nxt[3:0] = (sprite_control[3:0] + 1) % 8;
                    end
                    else begin
                        sprite_control_nxt[3:0] = sprite_control[3:0];
                    end
                end
                else begin
                    x_tmp = tom_pos.x;
                    counterx_nxt = counterx + 1;
                    sprite_control_nxt[3:0] = sprite_control[3:0];
                end
                sprite_control_nxt[6:4] = 3'b000;
            end

            else begin
                counterx_nxt = 0;
                x_tmp = tom_pos.x;
                sprite_control_nxt = sprite_control;
            end
            
            // ------------------------ //

            if(jump) begin
                state_nxt = JUMPING;
            end
            else if((right && !left) || (!right && left)) begin
                if(checkCollisionWithAllPlatforms(x_tmp, y_tmp, TOM_WIDTH, TOM_HEIGHT) == 2'b10 || ((tom_pos.y + TOM_HEIGHT) == 767)) begin
                    state_nxt = MOVING;
                end
                else begin
                    state_nxt = FALLING;
                end
            end
            else begin
                state_nxt = IDLE;
            end

            y_jump_start_nxt = tom_pos.y;

            y_tmp = tom_pos.y;
            countery_nxt = 0;
            countery_jump_stop_nxt = 200_000;
            countery_fall_stop_nxt = 800_000;

            x_nxt = correctCoordinateX(x_tmp, TOM_WIDTH);
            y_nxt = correctCoordinateY(y_tmp, TOM_HEIGHT);
        end

        JUMPING: begin
            if(right && !left) begin
                if(counterx >= COUNTERX_AIR_STOP) begin
                    x_tmp = correctCoordinateX(tom_pos.x + 1, TOM_WIDTH);
                    counterx_nxt = 0;
                    sprite_control_nxt[3:0] = (sprite_control[3:0] + 1) % 8;
                end
                else begin
                    x_tmp = tom_pos.x;
                    counterx_nxt = counterx + 1;
                     sprite_control_nxt[3:0] = sprite_control[3:0];
                end
                sprite_control_nxt[6:4] = 3'b110;
            end

            else if(!right && left) begin
                if(counterx >= COUNTERX_AIR_STOP) begin
                    x_tmp = correctCoordinateX(tom_pos.x - 1, TOM_WIDTH);
                    counterx_nxt = 0;
                     sprite_control_nxt[3:0] = (sprite_control[3:0] + 1) % 8;
                end
                else begin
                    x_tmp = tom_pos.x;
                    counterx_nxt = counterx + 1;
                    sprite_control_nxt[3:0] = sprite_control[3:0];
                end
                sprite_control_nxt[6:4] = 3'b010;
            end

            else begin
                x_tmp = tom_pos.x;
                counterx_nxt = 0;
                sprite_control_nxt = {sprite_control[6],1'b1,sprite_control[4:0]};
            end

            // ------------------------ //

            if(countery >= countery_jump_stop) begin
                y_tmp = tom_pos.y - 1;
                countery_nxt = 0;
                if(tom_pos.y <= y_jump_start - 175) begin
                    if(countery_jump_stop >= 800_000) begin
                        countery_jump_stop_nxt = 800_000;
                    end
                    else begin
                        countery_jump_stop_nxt = countery_jump_stop + 20_000;
                    end
                end
                else begin
                    countery_jump_stop_nxt = 200_000;
                end
            end
            else begin
                y_tmp = tom_pos.y;
                countery_nxt = countery + 1;
                countery_jump_stop_nxt = countery_jump_stop;
            end

            // ------------------------ //

            if((tom_pos.y < (y_jump_start - JUMP_HEIGHT)) || (checkCollisionWithAllPlatforms(x_tmp, y_tmp, TOM_WIDTH, TOM_HEIGHT) == 2'b01)) begin
                state_nxt = FALLING;
                countery_fall_stop_nxt = countery_fall_stop;
            end
            else begin
                state_nxt = JUMPING;
                countery_fall_stop_nxt = 800_000;
            end
            y_jump_start_nxt = y_jump_start;

            x_nxt = correctCoordinateX(x_tmp, TOM_WIDTH);
            y_nxt = correctCoordinateY(y_tmp, TOM_HEIGHT);
        end

        FALLING: begin
            if(right && !left) begin
                if(counterx >= COUNTERX_AIR_STOP) begin
                    x_tmp = correctCoordinateX(tom_pos.x + 1, TOM_WIDTH);
                    counterx_nxt = 0;
                    sprite_control_nxt[3:0] = (sprite_control[3:0] + 1) % 8;
                end
                else begin
                    x_tmp = tom_pos.x;
                    counterx_nxt = counterx + 1;
                    sprite_control_nxt[3:0] = sprite_control[3:0];
                end
                sprite_control_nxt[6:4] = 3'b110;
            end

            else if(!right && left) begin
                if(counterx >= COUNTERX_STOP) begin
                    x_tmp = correctCoordinateX(tom_pos.x - 1, TOM_WIDTH);
                    counterx_nxt = 0;
                    sprite_control_nxt[3:0] = (sprite_control[3:0] + 1) % 8;
                end
                else begin
                    x_tmp = tom_pos.x;
                    counterx_nxt = counterx + 1;
                    sprite_control_nxt[3:0] = sprite_control[3:0];
                end
                sprite_control_nxt[6:4] = 3'b010;
            end

            else begin
                x_tmp = tom_pos.x;
                counterx_nxt = 0;
                sprite_control_nxt = sprite_control;
            end

            // ------------------------ //

            if(countery >= countery_fall_stop) begin
                y_tmp = tom_pos.y + 1;
                countery_nxt = 0;
                if(countery_fall_stop <= 150_000) begin
                    countery_fall_stop_nxt = 150_000;
                end
                else begin
                    countery_fall_stop_nxt = countery_fall_stop - 20_000;
                end
            end
            else begin
                y_tmp = tom_pos.y;
                countery_nxt = countery + 1;
                countery_fall_stop_nxt = countery_fall_stop;
            end

            // ------------------------ //

            if(tom_pos.y < (767 - TOM_HEIGHT)) begin 
                if(checkCollisionWithAllPlatforms(x_tmp, y_tmp, TOM_WIDTH, TOM_HEIGHT) == 2'b10) begin
                    state_nxt = IDLE;
                end
                else begin
                    state_nxt = FALLING;
                end
            end
            else begin
                state_nxt = IDLE;
            end
            
            y_jump_start_nxt = tom_pos.y;

            countery_jump_stop_nxt = countery_jump_stop;

            x_nxt = correctCoordinateX(x_tmp, TOM_WIDTH);
            y_nxt = correctCoordinateY(y_tmp, TOM_HEIGHT);
        end

        default: begin
            state_nxt = IDLE;
            x_tmp = tom_pos.x;
            y_tmp = tom_pos.y;  
            counterx_nxt = 0;
            countery_jump_stop_nxt = 200_000;
            countery_fall_stop_nxt = 800_000;
            countery_nxt = 0;
            y_jump_start_nxt = tom_pos.y;
            sprite_control_nxt = 7'b1010000;
            x_nxt = correctCoordinateX(x_tmp, TOM_WIDTH);
            y_nxt = correctCoordinateY(y_tmp, TOM_HEIGHT);
        end
    endcase
end

endmodule
