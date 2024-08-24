/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Package containg functions and tasks
 */

package functions_tasks_pkg;

import game_pkg::*;

/*
@brief Function to check whether the object's X coordinates do not exceed the screen boundaries, if so, keeps the object in screen boundaries
@param takes in x coordinate (left), y coordinate (upper), height and width of the object
@return returns corrected coordinate X
  */
function logic [9:0] correctCoordinateX(
    input [9:0] x, input int width
    );
    begin
        logic [9:0] corrected_x;
        // Correct x coordinate
        if (x < 1) begin
            corrected_x = 1;
        end 
        else if (x + width > 1023) begin
            corrected_x = 1023 - width;
        end 
        else begin
            corrected_x = x;
        end
        return corrected_x;
    end

endfunction

/*
@brief Function to check whether the object's Y coordinates do not exceed the screen boundaries, if so, keeps the object in screen boundaries
@param y coordinate (upper), height of the object
@return returns corrected coordinate Y
  */
 function logic [9:0] correctCoordinateY(
    input [9:0] y, input int height
    );
    begin
        logic [9:0] corrected_y;
        // Correct y coordinate
        if (y < 1) begin
            corrected_y = 1;
        end 
        else if (y + height > 767) begin
            corrected_y = 767 - height;
        end 
        else begin
            corrected_y = y;
        end
        return corrected_y;
    end

 endfunction

/*
@brief Function to check if there is collision between player model and second object for example platform
@param player x,y coordinates, width and height, object coordinates and object length
@return returns 2'b10 if collision from up, 2b'01 if from down, 2b'11 if from right or left, 2'b00 if no collision
  */
function logic [1:0] checkCollisionWithObject(
    input [9:0] x, y, x_plat_start, y_plat, input int width, height, plat_length
    // output bit result
    );
    begin
        logic [1:0] result;
        if((((x == x_plat_start + plat_length) || (x + width == x_plat_start)) && (y + height >= y_plat) && (y <= y_plat)))
        begin
            result = 2'b11; // from left right
        end
        else if(((y + height == y_plat) && (x + width >= x_plat_start) && (x <= x_plat_start + plat_length))) begin
            result = 2'b10; // from up meaning while falling
        end
        else if(((y == y_plat) && (x + width >= x_plat_start) && (x <= x_plat_start + plat_length))) begin
            result = 2'b01; // from down meaning while jumping
        end
        else begin
            result = 2'b00;
        end
        return result;
    end

endfunction

/*
@brief Function to check if there is collision between player model and all platforms
@param player x,y coordinates, width and height
@return returns 2'b11 if collision from right or left, 2b'10 if from up fe. while falling, 2b'01 if from down fe. while jumping, 2'b00 if no collision
  */
function logic [1:0] checkCollisionWithAllPlatforms(
    input [9:0] x, input [9:0] y, input int width, height
    );
    begin
        logic [1:0] result;
        result = (checkCollisionWithObject(x, y, P1_X_START, P1_Y_COLLISION, width, height, P1_LENGTH) | 
                  checkCollisionWithObject(x, y, P2_X_START, P2_Y_COLLISION, width, height, P2_LENGTH) |
                  checkCollisionWithObject(x, y, P3_X_START, P3_Y_COLLISION, width, height, P3_LENGTH) |
                  checkCollisionWithObject(x, y, P4_X_START, P4_Y_COLLISION, width, height, P4_LENGTH) |
                  checkCollisionWithObject(x, y, P5_X_START, P5_Y_COLLISION, width, height, P5_LENGTH) | 
                  checkCollisionWithObject(x, y, P6_X_START, P6_Y_COLLISION, width, height, P6_LENGTH) |
                  checkCollisionWithObject(x, y, P7_X_START, P7_Y_COLLISION, width, height, P7_LENGTH)  |
                  checkCollisionWithObject(x, y, P8_X_START, P8_Y_COLLISION, width, height, P8_LENGTH) |
                  checkCollisionWithObject(x, y, P9_X_START, P9_Y_COLLISION, width, height, P9_LENGTH) |
                  checkCollisionWithObject(x, y, P10_X_START, P10_Y_COLLISION, width, height, P10_LENGTH) |
                  checkCollisionWithObject(x, y, P11_X_START, P11_Y_COLLISION, width, height, P11_LENGTH) |
                  checkCollisionWithObject(x, y, P12_X_START, P12_Y_COLLISION, width, height, P12_LENGTH) |
                  checkCollisionWithObject(x, y, P13_X_START, P13_Y_COLLISION, width, height, P13_LENGTH) |
                  checkCollisionWithObject(x, y, P14_X_START, P14_Y_COLLISION, width, height, P14_LENGTH) |
                  checkCollisionWithObject(x, y, P15_X_START, P15_Y_COLLISION, width, height, P15_LENGTH) |
                  checkCollisionWithObject(x, y, P16_X_START, P16_Y_COLLISION, width, height, P16_LENGTH));
        return result;
    end

endfunction

endpackage
    
    