/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Package containg functions and tasks
 */

package functions_tasks_pkg;

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
            corrected_x = 0;
        end 
        else if (x + width > 1023) begin
            corrected_x = 1024 - width;
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
            corrected_y = 0;
        end 
        else if (y + height > 767) begin
            corrected_y = 768 - height;
        end 
        else begin
            corrected_y = y;
        end
    end

endtask

/* task checkCollisionWithPlatforms(
    input [9:0] x, input [9:0] y, input int height, input int width,
    output result);
    begin
        if((in.vcount == 600) && ((in.hcount > 180) && (in.hcount < 650) || (in.hcount > 780) && (in.hcount < 920)) || 
            (in.vcount == 460) && ((in.hcount > 0) && (in.hcount < 250) || (in.hcount > 500) && (in.hcount < 600)) || 
            (in.vcount == 320) && ((in.hcount > 600) && (in.hcount < 975)) || 
            (in.vcount == 220) && ((in.hcount > 125) && (in.hcount < 450)))

        if((y == 220) && (x <=))
    end
endtask */
endpackage
    
    