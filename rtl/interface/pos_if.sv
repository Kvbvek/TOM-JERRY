/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author:Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Interface with x,y coords position
 */

//  import vga_pkg::*;

interface pos_if;
        logic [9:0] x, y;

        modport in (input x, y);
        modport out (output x, y);

endinterface
