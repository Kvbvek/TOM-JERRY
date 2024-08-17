/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Package with game related constants.
 */

 package game_pkg;

   localparam COLOR_PINK = 12'hf_6_f;

    localparam TOM_WIDTH = 32;
    localparam TOM_HEIGHT = 50;
    localparam TOM_BG_COLOR = COLOR_PINK;

    localparam JERRY_WIDTH = 25;
    localparam JERRY_HEIGHT = 32;
    localparam JERRY_BG_COLOR = 12'hf_7_f;

    localparam CHEESE_WIDTH = 25;
    localparam CHEESE_HEIGHT = 18;
    localparam CHEESE_BG_COLOR = 12'hf_f_f;
    // map related constants

    // PLATFORMS
    localparam P1_X_START = 180;
    localparam P1_X_END = 650;
    localparam P1_Y_START = 595;
    localparam P1_Y_END = 605;
    localparam P1_Y_COLLISION = 600;
    localparam P1_LENGTH = 470;

    localparam P2_X_START = 780;
    localparam P2_X_END = 920;
    localparam P2_Y_START = 595;
    localparam P2_Y_END = 605;
    localparam P2_Y_COLLISION = 600;
    localparam P2_LENGTH = 140;

    localparam P3_X_START = 0;
    localparam P3_X_END = 250;
    localparam P3_Y_START = 455;
    localparam P3_Y_END = 465;
    localparam P3_Y_COLLISION = 460;
    localparam P3_LENGTH = 250;

    localparam P4_X_START = 500;
    localparam P4_X_END = 600;
    localparam P4_Y_START = 455;
    localparam P4_Y_END = 465;
    localparam P4_Y_COLLISION = 460;
    localparam P4_LENGTH = 100;

    localparam P5_X_START = 600;
    localparam P5_X_END = 975;
    localparam P5_Y_START = 315;
    localparam P5_Y_END = 325;
    localparam P5_Y_COLLISION = 320;
    localparam P5_LENGTH = 375;

    localparam P6_X_START = 125;
    localparam P6_X_END = 450;
    localparam P6_Y_START = 265;
    localparam P6_Y_END = 275;
    localparam P6_Y_COLLISION = 270;
    localparam P6_LENGTH = 325;
    
    endpackage
    
    