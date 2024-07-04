/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Testbench for vga_timing module.
 */

`timescale 1 ns / 1 ps

module vga_timing_tb;

import vga_pkg::*;


/**
 *  Local parameters
 */

localparam CLK_PERIOD = 25;     // 40 MHz


/**
 * Local variables and signals
 */

logic clk;
logic rst;

wire [10:0] vcount, hcount;
wire        vsync,  hsync;
wire        vblnk,  hblnk;


/**
 * Clock generation
 */

initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end


/**
 * Reset generation
 */

initial begin
                       rst = 1'b0;
    #(1.25*CLK_PERIOD) rst = 1'b1;
                       rst = 1'b1;
    #(2.00*CLK_PERIOD) rst = 1'b0;
end


/**
 * Dut placement
 */

vga_timing dut(
    .clk,
    .rst,
    .vcount,
    .vsync,
    .vblnk,
    .hcount,
    .hsync,
    .hblnk
);

/**
 * Tasks and functions
 */

/**
 * Assertions
 */



property p_horizontal_property;
    @(posedge clk) hcount < VER_TOTAL_TIME;
endproperty

assert property (p_horizontal_property) $display("OK");
else  begin
    $error("Horizontal coordinate is above the maximum value");
end

property p_vertical_property;
    @(posedge clk) vcount < HOR_TOTAL_TIME;
endproperty

assert property (p_vertical_property) $display("OK");
else begin
    $error("Vertical coordinate is above the maximum value");
end



/**
 * Main test
 */

initial begin
    @(posedge rst);
    @(negedge rst);

    wait (vsync == 1'b0);
    @(negedge vsync)
    @(negedge vsync)

    $finish;
end

endmodule

