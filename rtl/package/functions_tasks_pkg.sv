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

    
endpackage
    
    