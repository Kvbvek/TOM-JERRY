/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * Testbench to check if pseudo random coordinates are being generated properly.
 */

`timescale 1 ns / 1 ps

module get_over_tb;


/**
 *  Local parameters
 */

localparam CLK_PERIOD = 25;     // 40 MHz


/**
 * Local variables and signals
 */

logic clk, rst;
logic [1:0] gameover_s;
logic ov, reset_w;

/**
 * Clock generation
 */

initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end


/**
 * Submodules instances
 */

get_over dut (
    .clk(clk),
    .reset(reset_w),
    .rst(rst),
    .gameover(gameover_s),
    .over(ov)

);

/**
 * Main test
 */

initial begin
    rst = 1'b0;
    # 30 rst = 1'b1;
    # 30 rst = 1'b0;
    gameover_s = 2'b00;
    reset_w = 0;

    $display("Starting simulation...");
    $display("Over value - %d at %t", ov, $time);
    # 50 gameover_s = 2'b10;
    # 25;
    $display("Over value - %d at %t", ov, $time);
    # 50;
    gameover_s = 2'b00;
    $display("Over value - %d at %t", ov, $time);
    # 50;
    $display("Over value - %d at %t", ov, $time);

    // End the simulation.
    $display("Simulation is over, check the waveforms.");
    $finish;
end

endmodule
