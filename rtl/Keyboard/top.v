`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc 
// Engineer: Arthur Brown
// 
// Create Date: 07/27/2016 02:04:01 PM
// Design Name: Basys3 Keyboard Demo
// Module Name: top
// Project Name: Keyboard
// Target Devices: Basys3
// Tool Versions: 2016.X
// Description: 
//     Receives input from USB-HID in the form of a PS/2, displays keyboard key presses and releases over USB-UART.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//     Known issue, when multiple buttons are pressed and one is released, the scan code of the one still held down is ometimes re-sent.
//////////////////////////////////////////////////////////////////////////////////


module top(
    input         clk,
    input         rst,
    inout         PS2Data,
    inout         PS2Clk,
    output  reg [15:0]     keyc
);
   
    reg         CLK50MHZ=0;
    wire        flag;
   
    wire [15:0] keyc_wire;
    
    always @(posedge(clk))begin
        CLK50MHZ<=~CLK50MHZ;
    end
    
    always @(posedge CLK50MHZ) begin
        if (rst) begin
            keyc <= 0;
        end
        else begin
            keyc <= keyc_wire;
        end
    end

    PS2Receiver uut (
        .clk(CLK50MHZ),
        .kclk(PS2Clk),
        .kdata(PS2Data),
        .keycode(keyc_wire),
        .oflag(flag)
    );
    
    
    
endmodule
