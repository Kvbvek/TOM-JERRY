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

module randomx_plat_tb;


/**
 *  Local parameters
 */

localparam CLK_PERIOD = 25;     // 40 MHz


/**
 * Local variables and signals
 */

logic clk, rst;
pos_if p1(), p2();
logic [1:0] genr;
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

randomx_plat dut (
    .clk(clk),
    .rst(rst),
    .rnd_generate(genr),
    .pout1(p1),
    .pout2(p2)

);

/**
 * Main test
 */

initial begin
    rst = 1'b0;
    # 30 rst = 1'b1;
    # 30 rst = 1'b0;

    $display("Starting simulation...");

    # 50 genr = 2'b01;
    # 100 genr = 2'b01;
    # 1;
    $display("genr val - %d, positions: x - %d, y - %d.",genr, p1.x, p1.y);
    genr = 2'b01;
    #100;
    $display("After few cycles: genr val - %d, positions: x - %d, y - %d.",genr, p1.x, p1.y);

    # 5 genr = 2'b01;
    # 150 genr = 2'b01;
    # 1;

    $display("genr val - %d, positions: x - %d, y - %d.",genr, p1.x, p1.y);

    # 50 genr = 2'b01;
    # 150 genr = 2'b01;
    # 1;

    $display("genr val - %d, positions: x - %d, y - %d.",genr, p1.x, p1.y);

    # 50 genr = 2'b01;
    # 150 genr = 2'b01;
    # 1;

    $display("genr val - %d, positions: x - %d, y - %d.",genr, p1.x, p1.y);

    // End the simulation.
    $display("Simulation is over, check the waveforms.");
    $finish;
end

endmodule
