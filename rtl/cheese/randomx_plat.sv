/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module for generating pseudo random coords to spawn cheese on platforms.
 * Made pseudo random because function $urandom_range() is not supported :(
 */

 `timescale 1 ns / 1 ps

 module randomx_plat (
     input  logic clk,
     input  logic rst,
     input  logic [1:0] rnd_generate,

    pos_if.out pout1,
    pos_if.out pout2
     
 );
 
 import game_pkg::*;
 
// local parameters
localparam OBJ_HEIGHT = 20;
localparam PLATFORM_NUMBER = 19;
localparam MAX_X_CTR = 1000;

// local variables
logic [9:0] ctr, ctr_nxt;
logic [6:0] ctr1, ctr1_nxt, ctr2, ctr2_nxt;
pos_if pnxt1();
pos_if pnxt2();

logic start, start_nxt;

// output register with sync reset
 always_ff @(posedge clk) begin
    if (rst) begin
        pout1.x <= '0;
        pout1.y <= '0;
        pout2.x <= '0;
        pout2.y <= '0;

        start <= '0;

        ctr <= '0;
        ctr1 <= '0;
        ctr2 <= '0;

    end else begin
        pout1.x <= pnxt1.x;
        pout1.y <= pnxt1.y;
        pout2.x <= pnxt2.x;
        pout2.y <= pnxt2.y;

        start <= start_nxt;

        ctr <= ctr_nxt;
        ctr1 <= ctr1_nxt;
        ctr2 <= ctr2_nxt;

    end
 end
 
// logic
always_comb begin
    if(ctr >= MAX_X_CTR) ctr_nxt = 0;
    else ctr_nxt = ctr + 1;

    if(ctr1 >= PLATFORM_NUMBER) ctr1_nxt = 0;
    else ctr1_nxt = ctr1 + 1;

    if(ctr2 >= PLATFORM_NUMBER) ctr2_nxt = 0;
    else ctr2_nxt = ctr2 + 1;

    if(!start) begin
        if(ctr1 == 7'd0) begin
            pnxt1.y = P1_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P1_LENGTH) + P1_X_START;
        end
        else if(ctr1 == 7'd1) begin
            pnxt1.y = P2_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P2_LENGTH) + P2_X_START;
        end
        else if(ctr1 == 7'd2) begin
            pnxt1.y = P3_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P3_LENGTH) + P3_X_START;
        end
        else if(ctr1 == 7'd3) begin
            pnxt1.y = P4_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P4_LENGTH) + P4_X_START;
        end
        else if(ctr1 == 7'd4) begin
            pnxt1.y = P5_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P5_LENGTH) + P5_X_START;
        end
        else if(ctr1 == 7'd5) begin
            pnxt1.y = P6_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P6_LENGTH) + P6_X_START;
        end
        else if(ctr1 == 7'd6) begin
            pnxt1.y = P6_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P6_LENGTH) + P6_X_START;
        end
        else if(ctr1 == 7'd7) begin
            pnxt1.y = P8_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P8_LENGTH) + P8_X_START;
        end
        else if(ctr1 == 7'd8) begin
            pnxt1.y = P9_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P9_LENGTH) + P9_X_START;
        end
        else if(ctr1 == 7'd9) begin
            pnxt1.y = P10_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P10_LENGTH) + P10_X_START;
        end
        else if(ctr1 == 7'd10) begin
            pnxt1.y = P11_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P11_LENGTH) + P11_X_START;
        end
        else if(ctr1 == 7'd11) begin
            pnxt1.y = P12_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P12_LENGTH) + P12_X_START;
        end
        else if(ctr1 == 7'd12) begin
            pnxt1.y = P13_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P13_LENGTH) + P13_X_START;
        end
        else if(ctr1 == 7'd13) begin
            pnxt1.y = P14_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P14_LENGTH) + P14_X_START;
        end
        else if(ctr1 == 7'd14) begin
            pnxt1.y = P15_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P15_LENGTH) + P15_X_START;
        end
        else if(ctr1 == 7'd15) begin
            pnxt1.y = P16_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P16_LENGTH) + P16_X_START;
        end
        else if(ctr1 == 7'd16) begin
            pnxt1.y = P17_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P17_LENGTH) + P17_X_START;
        end
        else if(ctr1 == 7'd17) begin
            pnxt1.y = P18_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P18_LENGTH) + P18_X_START;
        end
        else if(ctr1 == 7'd18) begin
            pnxt1.y = P19_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P19_LENGTH) + P19_X_START;
        end
        else begin
            pnxt1.y = P1_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P1_LENGTH) + P1_X_START;
        end
        pnxt2.x = (ctr2 % P19_LENGTH) + P19_X_START + 350;
        pnxt2.y = P19_Y_COLLISION - OBJ_HEIGHT;
    end

    else if((rnd_generate == 2'b01)) begin
        if(ctr1 == 7'd0) begin
            pnxt1.y = P1_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P1_LENGTH) + P1_X_START;
        end
        else if(ctr1 == 7'd1) begin
            pnxt1.y = P2_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P2_LENGTH) + P2_X_START;
        end
        else if(ctr1 == 7'd2) begin
            pnxt1.y = P3_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P3_LENGTH) + P3_X_START;
        end
        else if(ctr1 == 7'd3) begin
            pnxt1.y = P4_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P4_LENGTH) + P4_X_START;
        end
        else if(ctr1 == 7'd4) begin
            pnxt1.y = P5_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P5_LENGTH) + P5_X_START;
        end
        else if(ctr1 == 7'd5) begin
            pnxt1.y = P6_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P6_LENGTH) + P6_X_START;
        end
        else if(ctr1 == 7'd6) begin
            pnxt1.y = P6_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P6_LENGTH) + P6_X_START;
        end
        else if(ctr1 == 7'd7) begin
            pnxt1.y = P8_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P8_LENGTH) + P8_X_START;
        end
        else if(ctr1 == 7'd8) begin
            pnxt1.y = P9_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P9_LENGTH) + P9_X_START;
        end
        else if(ctr1 == 7'd9) begin
            pnxt1.y = P10_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P10_LENGTH) + P10_X_START;
        end
        else if(ctr1 == 7'd10) begin
            pnxt1.y = P11_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P11_LENGTH) + P11_X_START;
        end
        else if(ctr1 == 7'd11) begin
            pnxt1.y = P12_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P12_LENGTH) + P12_X_START;
        end
        else if(ctr1 == 7'd12) begin
            pnxt1.y = P13_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P13_LENGTH) + P13_X_START;
        end
        else if(ctr1 == 7'd13) begin
            pnxt1.y = P14_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P14_LENGTH) + P14_X_START;
        end
        else if(ctr1 == 7'd14) begin
            pnxt1.y = P15_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P15_LENGTH) + P15_X_START;
        end
        else if(ctr1 == 7'd15) begin
            pnxt1.y = P16_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P16_LENGTH) + P16_X_START;
        end
        else if(ctr1 == 7'd16) begin
            pnxt1.y = P17_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P17_LENGTH) + P17_X_START;
        end
        else if(ctr1 == 7'd17) begin
            pnxt1.y = P18_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P18_LENGTH) + P18_X_START;
        end
        else if(ctr1 == 7'd18) begin
            pnxt1.y = P19_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P19_LENGTH) + P19_X_START;
        end
        else begin
            pnxt1.y = P1_Y_COLLISION - OBJ_HEIGHT;
            pnxt1.x = (ctr % P1_LENGTH) + P1_X_START;
        end
        pnxt2.x = pout2.x;
        pnxt2.y = pout2.y;
    end

    else if((rnd_generate == 2'b10)) begin
        if(ctr2 == 7'd0) begin
            pnxt2.y = P19_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P19_LENGTH) + P19_X_START;
        end
        else if(ctr2 == 7'd1) begin
            pnxt2.y = P18_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P18_LENGTH) + P18_X_START;
        end
        else if(ctr2 == 7'd2) begin
            pnxt2.y = P17_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P17_LENGTH) + P17_X_START;
        end
        else if(ctr2 == 7'd3) begin
            pnxt2.y = P16_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P16_LENGTH) + P16_X_START;
        end
        else if(ctr2 == 7'd4) begin
            pnxt2.y = P15_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P15_LENGTH) + P15_X_START;
        end
        else if(ctr2 == 7'd5) begin
            pnxt2.y = P14_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P14_LENGTH) + P14_X_START;
        end
        else if(ctr2 == 7'd6) begin
            pnxt2.y = P13_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P13_LENGTH) + P13_X_START;
        end
        else if(ctr2 == 7'd7) begin
            pnxt2.y = P12_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P11_LENGTH) + P12_X_START;
        end
        else if(ctr2 == 7'd8) begin
            pnxt2.y = P9_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P9_LENGTH) + P9_X_START;
        end
        else if(ctr2 == 7'd9) begin
            pnxt2.y = P10_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P10_LENGTH) + P10_X_START;
        end
        else if(ctr2 == 7'd10) begin
            pnxt2.y = P9_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P9_LENGTH) + P9_X_START;
        end
        else if(ctr2 == 7'd11) begin
            pnxt2.y = P8_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P8_LENGTH) + P8_X_START;
        end
        else if(ctr2 == 7'd12) begin
            pnxt2.y = P6_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P6_LENGTH) + P6_X_START;
        end
        else if(ctr2 == 7'd13) begin
            pnxt2.y = P6_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P6_LENGTH) + P6_X_START;
        end
        else if(ctr2 == 7'd14) begin
            pnxt2.y = P5_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P5_LENGTH) + P5_X_START;
        end
        else if(ctr2 == 7'd15) begin
            pnxt2.y = P4_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P4_LENGTH) + P4_X_START;
        end
        else if(ctr2 == 7'd16) begin
            pnxt2.y = P3_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P3_LENGTH) + P3_X_START;
        end
        else if(ctr2 == 7'd17) begin
            pnxt2.y = P2_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P2_LENGTH) + P2_X_START;
        end
        else if(ctr2 == 7'd18) begin
            pnxt2.y = P1_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P19_LENGTH) + P1_X_START;
        end
        else begin
            pnxt2.y = P1_Y_COLLISION - OBJ_HEIGHT;
            pnxt2.x = (ctr % P1_LENGTH) + P1_X_START;
        end
        pnxt1.x = pout1.x;
        pnxt1.y = pout1.y;
    end
    
    else begin
        pnxt1.x = pout1.x;
        pnxt1.y = pout1.y;
        pnxt2.x = pout2.x;
        pnxt2.y = pout2.y;
    end
    start_nxt = 1;
end
 
endmodule
 