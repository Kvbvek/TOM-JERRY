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
@brief Task to check whether the object's coordinates do not exceed the screen boundaries, if so, keeps the object in screen boundaries
@param takes in x coordinate (left), y coordinate (upper), height and width of the object
@return returns corrected coordinate X
  */
task correctCoordinateX(
    input [9:0] x, input int width,
    output [9:0] corrected_x
    );
    begin
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
    end

endtask

/*
@brief Task to check whether the object's coordinates do not exceed the screen boundaries, if so, keeps the object in screen boundaries
@param y coordinate (upper), height of the object
@return returns corrected coordinate Y
  */
 task correctCoordinateY(
    input [9:0] y, input int height,
    output [9:0] corrected_y
    );
    begin
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
    end

endtask

/*
@brief Function to check if there is collision between player model and single platform
@param player x,y coordinates, width and height, platform coordinates and platform length
@return returns 1 if collision occured, otherwise 0
  */
function bit checkCollisionWithPlatform(
    input [9:0] x, y, x_plat_start, y_plat, input int width, height, plat_length
    // output bit result
    );
    begin
        if((((x <= x_plat_start + plat_length) && (x + width >= x_plat_start)) && (y + height >= y_plat) && (y <= y_plat)) || 
        (((y + height == y_plat) || (y == y_plat) && (x + width >= x_plat_start) && (x <= x_plat_start))))
        begin
            return 1;
        end
        else begin
            return 0;
        end
    end

endfunction

/*
@brief Function to check if there is collision between player model and all platforms
@param player x,y coordinates, width and height
@return returns 1 if collision occured, otherwise 0
  */
function bit checkCollisionWithAllPlatforms(
    input [9:0] x, input [9:0] y, input int width, height
    );
    begin
        bit result = (checkCollisionWithPlatform(x, y, P1_X_START, P1_Y_COLLISION, width, height, P1_LENGTH) | 
        checkCollisionWithPlatform(x, y, P2_X_START, P2_Y_COLLISION, width, height, P2_LENGTH) |
        checkCollisionWithPlatform(x, y, P3_X_START, P3_Y_COLLISION, width, height, P3_LENGTH) |
        checkCollisionWithPlatform(x, y, P4_X_START, P4_Y_COLLISION, width, height, P4_LENGTH) |
        checkCollisionWithPlatform(x, y, P5_X_START, P5_Y_COLLISION, width, height, P5_LENGTH) | 
        checkCollisionWithPlatform(x, y, P6_X_START, P6_Y_COLLISION, width, height, P6_LENGTH));
        return result;
    end

endfunction

/*
@brief Function to check if player felt from platform while moving
@param player x,y coordinates, width and height
@return returns 1 if player will fall, otherwise 0
  */
//  function bit playerFallFromPlatform(
//     input [9:0] x, input [9:0] y, x_plat, x_plat_length input int width, height
//     );
//     begin
//         bit result = (checkCollisionWithPlatform(x, y, P1_X_START, P1_Y_COLLISION, width, height, P1_LENGTH) | 
//         checkCollisionWithPlatform(x, y, P2_X_START, P2_Y_COLLISION, width, height, P2_LENGTH) |
//         checkCollisionWithPlatform(x, y, P3_X_START, P3_Y_COLLISION, width, height, P3_LENGTH) |
//         checkCollisionWithPlatform(x, y, P4_X_START, P4_Y_COLLISION, width, height, P4_LENGTH) |
//         checkCollisionWithPlatform(x, y, P5_X_START, P5_Y_COLLISION, width, height, P5_LENGTH) | 
//         checkCollisionWithPlatform(x, y, P6_X_START, P6_Y_COLLISION, width, height, P6_LENGTH));
//         return result;
//     end

// endfunction

endpackage
    
    