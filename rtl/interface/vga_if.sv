/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author:Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Interfaces.
 */

 import vga_pkg::*;

interface vga_if;
        logic [10:0] vcount, hcount;
        logic [11:0] rgb;
        logic vsync, vblnk, hsync, hblnk;

        modport in (input vcount, hcount, vsync, hsync, vblnk, hblnk, rgb);
        modport out (output vcount, hcount, vsync, hsync, vblnk, hblnk, rgb);


endinterface

interface vga_if_norgb;
        logic [10:0] vcount, hcount;
        logic vsync, vblnk, hsync, hblnk;

        modport in (input vcount, hcount, vsync, hsync, vblnk, hblnk);
        modport out (output vcount, hcount, vsync, hsync, vblnk, hblnk);

endinterface