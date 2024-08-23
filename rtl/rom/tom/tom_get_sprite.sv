/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module 
 */

 module tom_get_sprite(
		input wire clk, // posedge active clock
        input wire rst,
		input wire [6:0] sprite_control,
        input wire [10:0] addrA,
		output logic [11:0] rgb
	);

    logic [11:0] tom_idle_r, tom_jump_r, tom_run_r_1, tom_run_r_2, tom_run_r_3,
    tom_run_r_4, tom_run_r_5, tom_run_r_6, tom_run_r_7, tom_run_r_8,
    tom_idle_l, tom_jump_l, tom_run_l_1, tom_run_l_2, tom_run_l_3,
    tom_run_l_4, tom_run_l_5, tom_run_l_6, tom_run_l_7, tom_run_l_8;

    logic [11:0] tom_idle_r_i, tom_jump_r_i, tom_run_r_1_i, tom_run_r_2_i, tom_run_r_3_i,
    tom_run_r_4_i, tom_run_r_5_i, tom_run_r_6_i, tom_run_r_7_i, tom_run_r_8_i,
    tom_idle_l_i, tom_jump_l_i, tom_run_l_1_i, tom_run_l_2_i, tom_run_l_3_i,
    tom_run_l_4_i, tom_run_l_5_i, tom_run_l_6_i, tom_run_l_7_i, tom_run_l_8_i;
    logic [11:0] rgb_nxt;

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/right/tom_idle_r.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_idle_r (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_idle_r_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/right/tom_jump_r.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_jump_r (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_jump_r_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/right/tom_run_r_1.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_r_1 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_r_1_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/right/tom_run_r_2.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_r_2 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_r_2_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/right/tom_run_r_3.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_r_3 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_r_3_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/right/tom_run_r_4.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_r_4 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_r_4_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/right/tom_run_r_5.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_r_5 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_r_5_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/right/tom_run_r_6.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_r_6 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_r_6_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/right/tom_run_r_7.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_r_7 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_r_7_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/right/tom_run_r_8.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_r_8 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_r_8_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/left/tom_idle_l.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_idle_l (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_idle_l_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/left/tom_jump_l.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_jump_l (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_jump_l_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/left/tom_run_l_1.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_l_1 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_l_1_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/left/tom_run_l_2.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_l_2 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_l_2_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/left/tom_run_l_3.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_l_3 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_l_3_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/left/tom_run_l_4.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_l_4 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_l_4_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/left/tom_run_l_5.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_l_5 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_l_5_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/left/tom_run_l_6.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_l_6 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_l_6_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/left/tom_run_l_7.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_l_7 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_l_7_i)
    );

    read_rom #(
        .DATA_PATH ("../../rtl/data/tom/left/tom_run_l_8.dat"),
        .ADDR_WIDTH(11)
    ) read_rom_tom_run_l_8 (
        .clk (clk),
        .addrA(addrA),
        .dout (tom_run_l_8_i)
    );
    // logic [47:0] dout_s;

    delay #(
        .WIDTH (240),
        .CLK_DEL(1)
    ) u_delay (
        .clk (clk),
        .rst (rst),
        .din ({tom_idle_r_i, tom_jump_r_i, tom_run_r_1_i, tom_run_r_2_i, tom_run_r_3_i, tom_run_r_4_i, tom_run_r_5_i,
        tom_run_r_6_i, tom_run_r_7_i, tom_run_r_8_i, tom_idle_l_i, tom_jump_l_i, tom_run_l_1_i, tom_run_l_2_i, tom_run_l_3_i, tom_run_l_4_i, tom_run_l_5_i,
        tom_run_l_6_i, tom_run_l_7_i, tom_run_l_8_i}),
        .dout ({tom_idle_r, tom_jump_r, tom_run_r_1, tom_run_r_2, tom_run_r_3, tom_run_r_4, tom_run_r_5,
        tom_run_r_6, tom_run_r_7, tom_run_r_8, tom_idle_l, tom_jump_l, tom_run_l_1, tom_run_l_2, tom_run_l_3, tom_run_l_4, tom_run_l_5,
        tom_run_l_6, tom_run_l_7, tom_run_l_8})
    );

    always_comb begin
        if(sprite_control[6] == 1) begin
			if(sprite_control[5] == 1) begin
				rgb_nxt = tom_jump_r;
			end
			else begin
				if(sprite_control[4] == 1) begin
					rgb_nxt = tom_idle_r;
				end
				else begin
					case(sprite_control[3:0])
						4'b0000: rgb_nxt = tom_run_r_1;
						4'b0001: rgb_nxt = tom_run_r_2;
						4'b0010: rgb_nxt = tom_run_r_3;
						4'b0011: rgb_nxt = tom_run_r_4;
						4'b0100: rgb_nxt = tom_run_r_5;
						4'b0101: rgb_nxt = tom_run_r_6;
						4'b0110: rgb_nxt = tom_run_r_7;
						4'b0111: rgb_nxt = tom_run_r_8;
						default: rgb_nxt = tom_run_r_1;
					endcase;
				end
			end
		end
		else begin
			if(sprite_control[5] == 1) begin
				rgb_nxt = tom_jump_l;
			end
			else begin
				if(sprite_control[4] == 1) begin
					rgb_nxt = tom_idle_l;
				end
				else begin
					case(sprite_control[3:0])
						4'b0000: rgb_nxt = tom_run_l_1;
						4'b0001: rgb_nxt = tom_run_l_2;
						4'b0010: rgb_nxt = tom_run_l_3;
						4'b0011: rgb_nxt = tom_run_l_4;
						4'b0100: rgb_nxt = tom_run_l_5;
						4'b0101: rgb_nxt = tom_run_l_6;
						4'b0110: rgb_nxt = tom_run_l_7;
						4'b0111: rgb_nxt = tom_run_l_8;
						default: rgb_nxt = tom_run_l_1;
					endcase;
				end
			end
		end
    end

    always_ff @(posedge clk) begin
        if(rst) rgb <= '0;
        else rgb <= rgb_nxt;
    end

 endmodule