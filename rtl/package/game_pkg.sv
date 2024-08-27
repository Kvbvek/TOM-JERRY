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

    localparam NUMBER_WIDTH = 22;
    localparam NUMBER_HEIGHT = 36;
    localparam NUMBER_BG_COLOR = 12'hf_f_f;


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
    localparam P1_Y_END = 600;
    localparam P1_Y_COLLISION = 600;
    localparam P1_LENGTH = 470;

    localparam P2_X_START = 780;
    localparam P2_X_END = 920;
    localparam P2_Y_START = 595;
    localparam P2_Y_END = 600;
    localparam P2_Y_COLLISION = 600;
    localparam P2_LENGTH = 140;

    localparam P3_X_START = 0;
    localparam P3_X_END = 250;
    localparam P3_Y_START = 455;
    localparam P3_Y_END = 460;
    localparam P3_Y_COLLISION = 460;
    localparam P3_LENGTH = 250;

    localparam P4_X_START = 500;
    localparam P4_X_END = 600;
    localparam P4_Y_START = 455;
    localparam P4_Y_END = 460;
    localparam P4_Y_COLLISION = 460;
    localparam P4_LENGTH = 100;

    localparam P5_X_START = 600;
    localparam P5_X_END = 975;
    localparam P5_Y_START = 315;
    localparam P5_Y_END = 320;
    localparam P5_Y_COLLISION = 320;
    localparam P5_LENGTH = 375;

    localparam P6_X_START = 125;
    localparam P6_X_END = 450;
    localparam P6_Y_START = 265;
    localparam P6_Y_END = 270;
    localparam P6_Y_COLLISION = 270;
    localparam P6_LENGTH = 325;


    localparam P7_X_START = 60;
    localparam P7_X_END = 210;
    localparam P7_Y_START = 420;
    localparam P7_Y_END = 425;
    localparam P7_Y_COLLISION = 425;
    localparam P7_LENGTH = 150;


    localparam P8_X_START = 0;
    localparam P8_X_END = 25;
    localparam P8_Y_START = 350;
    localparam P8_Y_END = 355;
    localparam P8_Y_COLLISION = 355;
    localparam P8_LENGTH = 25;

    localparam P9_X_START = 35;
    localparam P9_X_END = 65;
    localparam P9_Y_START = 280;
    localparam P9_Y_END = 285;
    localparam P9_Y_COLLISION = 285;
    localparam P9_LENGTH = 30;

  
    localparam P10_X_START = 990 ;
    localparam P10_X_END = 1030;
    localparam P10_Y_START = 535;
    localparam P10_Y_END = 540;
    localparam P10_Y_COLLISION = 540;
    localparam P10_LENGTH = 40;

    
    localparam P11_X_START = 0;
    localparam P11_X_END = 70;
    localparam P11_Y_START = 675;
    localparam P11_Y_END = 680;
    localparam P11_Y_COLLISION = 680;
    localparam P11_LENGTH = 70;

    localparam P12_X_START = 35;
    localparam P12_X_END = 65;
    localparam P12_Y_START = 420;
    localparam P12_Y_END = 425;
    localparam P12_Y_COLLISION = 425;
    localparam P12_LENGTH = 30;


    localparam P13_X_START = 680;
    localparam P13_X_END = 750;
    localparam P13_Y_START = 675;
    localparam P13_Y_END = 680;
    localparam P13_Y_COLLISION = 680;
    localparam P13_LENGTH = 70;

    localparam P14_X_START = 300;
    localparam P14_X_END = 400;
    localparam P14_Y_START = 515;
    localparam P14_Y_END = 520;
    localparam P14_Y_COLLISION = 520;
    localparam P14_LENGTH = 100;

    localparam P15_X_START = 620;
    localparam P15_X_END = 680;
    localparam P15_Y_START = 515;
    localparam P15_Y_END = 520;
    localparam P15_Y_COLLISION = 520;
    localparam P15_LENGTH = 60;

    localparam P16_X_START = 440;
    localparam P16_X_END = 490;
    localparam P16_Y_START = 350;
    localparam P16_Y_END = 355;
    localparam P16_Y_COLLISION = 355;
    localparam P16_LENGTH = 50;

    localparam P17_X_START = 920 ;
    localparam P17_X_END = 960;
    localparam P17_Y_START = 455;
    localparam P17_Y_END = 460;
    localparam P17_Y_COLLISION = 460;
    localparam P17_LENGTH = 40;

    localparam P18_X_START = 990 ;
    localparam P18_X_END = 1030;
    localparam P18_Y_START = 375;
    localparam P18_Y_END = 380;
    localparam P18_Y_COLLISION = 380;
    localparam P18_LENGTH = 40;

    localparam P19_X_START = 0;
    localparam P19_X_END = 1020;
    localparam P19_Y_START = 760;
    localparam P19_Y_END = 765;
    localparam P19_Y_COLLISION = 765;
    localparam P19_LENGTH = 1020;
    
    endpackage
    
    