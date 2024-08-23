# Copyright (C) 2023  AGH University of Science and Technology
# MTM UEC2
# Author: Piotr Kaczmarczyk
#
# Description:
# Project detiles required for generate_bitstream.tcl
# Make sure that project_name, top_module and target are correct.
# Provide paths to all the files required for synthesis and implementation.
# Depending on the file type, it should be added in the corresponding section.
# If the project does not use files of some type, leave the corresponding section commented out.

#-----------------------------------------------------#
#                   Project details                   #
#-----------------------------------------------------#
# Project name                                  -- EDIT
set project_name vga_project

# Top module name                               -- EDIT
set top_module top_vga_basys3

# FPGA device
set target xc7a35tcpg236-1

#-----------------------------------------------------#
#                    Design sources                   #
#-----------------------------------------------------#
# Specify .xdc files location                   -- EDIT
set xdc_files {
    constraints/top_vga_basys3.xdc
}

# Specify SystemVerilog design files location   -- EDIT
set sv_files {
    ../rtl/package/vga_pkg.sv
    ../rtl/package/game_pkg.sv
    ../rtl/package/functions_tasks_pkg.sv
    ../rtl/interface/vga_if.sv
    ../rtl/interface/pos_if.sv
    ../rtl/timing/vga_timing.sv
    ../rtl/timing/delay.sv
    ../rtl/Keyboard/key_decoder_movement.sv
    ../rtl/Keyboard/key_decoder_reset.sv
    ../rtl/cheese/cheese_taken.sv
    ../rtl/cheese/randomx_plat.sv
    ../rtl/movement/host_move_ctrl.sv
    ../rtl/movement/player_move_ctrl.sv
    ../rtl/draw/draw_bg.sv
    ../rtl/draw/draw_counter.sv
    ../rtl/draw/draw_tom.sv
    ../rtl/draw/draw_jerry.sv
    ../rtl/draw/draw_cheese.sv
    ../rtl/draw/draw_gameover.sv
    ../rtl/gameover/get_over.sv
    ../rtl/gameover/is_gameover.sv
    ../rtl/rom/read_rom.sv
    ../rtl/rom/tom/tom_get_sprite.sv
    ../rtl/rom/jerry/jerry_get_sprite.sv
    ../rtl/top/top_vga.sv
    rtl/top_vga_basys3.sv
}

# Specify Verilog design files location         -- EDIT
set verilog_files {
     ../fpga/rtl/clk_wiz_0_clk_wiz.v
     ../fpga/rtl/clk_wiz_0.v
     ../rtl/Keyboard/top.v
     ../rtl/Keyboard/bin2ascii.v
     ../rtl/Keyboard/debouncer.v
     ../rtl/Keyboard/PS2Receiver.v
}


# Specify VHDL design files location            -- EDIT
# set vhdl_files {
#    path/to/file.vhd
# }

# Specify files for a memory initialization     -- EDIT
 set mem_files {
     ../rtl/data/tom/right/tom_idle_r.dat
     ../rtl/data/tom/right/tom_jump_r.dat
     ../rtl/data/tom/right/tom_run_r_1.dat
     ../rtl/data/tom/right/tom_run_r_2.dat
     ../rtl/data/tom/right/tom_run_r_3.dat
     ../rtl/data/tom/right/tom_run_r_4.dat
     ../rtl/data/tom/right/tom_run_r_5.dat
     ../rtl/data/tom/right/tom_run_r_6.dat
     ../rtl/data/tom/right/tom_run_r_7.dat
     ../rtl/data/tom/right/tom_run_r_8.dat
     ../rtl/data/tom/left/tom_idle_l.dat
     ../rtl/data/tom/left/tom_jump_l.dat
     ../rtl/data/tom/left/tom_run_l_1.dat
     ../rtl/data/tom/left/tom_run_l_2.dat
     ../rtl/data/tom/left/tom_run_l_3.dat
     ../rtl/data/tom/left/tom_run_l_4.dat
     ../rtl/data/tom/left/tom_run_l_5.dat
     ../rtl/data/tom/left/tom_run_l_6.dat
     ../rtl/data/tom/left/tom_run_l_7.dat
     ../rtl/data/tom/left/tom_run_l_8.dat
     ../rtl/data/jerry/right/jerry_idle_r.dat
     ../rtl/data/jerry/right/jerry_run_r_1.dat
     ../rtl/data/jerry/right/jerry_run_r_2.dat
     ../rtl/data/jerry/right/jerry_run_r_3.dat
     ../rtl/data/jerry/right/jerry_run_r_4.dat
     ../rtl/data/jerry/right/jerry_run_r_5.dat
     ../rtl/data/jerry/right/jerry_run_r_6.dat
     ../rtl/data/jerry/right/jerry_run_r_7.dat
     ../rtl/data/jerry/right/jerry_run_r_8.dat
     ../rtl/data/jerry/left/jerry_idle_l.dat
     ../rtl/data/jerry/left/jerry_run_l_1.dat
     ../rtl/data/jerry/left/jerry_run_l_2.dat
     ../rtl/data/jerry/left/jerry_run_l_3.dat
     ../rtl/data/jerry/left/jerry_run_l_4.dat
     ../rtl/data/jerry/left/jerry_run_l_5.dat
     ../rtl/data/jerry/left/jerry_run_l_6.dat
     ../rtl/data/jerry/left/jerry_run_l_7.dat
     ../rtl/data/jerry/left/jerry_run_l_8.dat
     ../rtl/data/cheese.dat

 }
