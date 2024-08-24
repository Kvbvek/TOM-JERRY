/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Package with vga related constants.
 */

package vga_pkg;

// 1024 x 768 display resolution
    
localparam HOR_PIXELS = 1024;
localparam VER_PIXELS = 768;

localparam HOR_TOTAL_TIME = 1344;
localparam HOR_SYNC_START = 1048;
localparam HOR_SYNC_END = 1184;
localparam HOR_BLANK_START = 1024;
localparam HOR_BLANK_END = 1344;

localparam VER_TOTAL_TIME = 806;
localparam VER_SYNC_START = 771;
localparam VER_SYNC_END = 777;
localparam VER_BLANK_START = 768;
localparam VER_BLANK_END = 806;


endpackage

