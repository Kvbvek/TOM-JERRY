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
 * Testbench to check 
 */

`timescale 1 ns / 1 ps

module is_gameover_tb;


/**
 *  Local parameters
 */

localparam CLK_PERIOD = 25;     // 40 MHz


/**
 * Local variables and signals
 */

logic clk, rst;
logic [7:0] cheese_ctr_w;
pos_if j();
pos_if t();

logic [1:0] gameover_w;

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

is_gameover dut (
    .clk(clk),
    .rst(rst),
    .cheese_ctr(cheese_ctr_w),
    .jerrypos(j),
    .tompos(t),
    .gameover(gameover_w)

);

/**
 * Main test
 */

initial begin
    $display("Starting simulation...");
    rst = 1'b0;
    j.x = 0;
    j.y = 0;
    t.x = 0;
    t.y = 0;
    cheese_ctr_w = 0;
    # 30 rst = 1'b1;
    # 30 rst = 1'b0;

    // $display("Starting simulation...");
    $display("Output - gameover[1:0]: %b at %t - exp 00", gameover_w, $time);
    # 50;
    $display("Output - gameover[1:0]: %b at %t - exp 00", gameover_w, $time);
    # 150;
    j.x = 500;
    j.y = 650;
    t.x = 156;
    t.y = 120;
    cheese_ctr_w = 9;
    #125
    $display("Output - gameover[1:0]: %b at %t  - exp 00", gameover_w, $time);
    # 25;
    #125
    $display("Output - gameover[1:0]: %b at %t  - exp 00", gameover_w, $time);
    cheese_ctr_w = 20;
    #125;
    # 50;
    $display("Output - gameover[1:0]: %b at %t  - exp 01", gameover_w, $time);
    cheese_ctr_w = 1;
    #4;
    $display("Output - gameover[1:0]: %b at %t  - exp 00", gameover_w, $time);
    #25;
    $display("Output - gameover[1:0]: %b at %t  - exp 00", gameover_w, $time);

    // End the simulation.
    $display("Simulation is over, check the waveforms.");
    $finish;
end

endmodule
