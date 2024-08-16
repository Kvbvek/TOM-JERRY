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
    inout         PS2Data,
    inout         PS2Clk,
    // output        tx
    output  [15:0]     keyc
);
    // wire        tready;
    // wire        ready;
    // wire        tstart;
    // reg         start=0;
    reg         CLK50MHZ=0;
    // wire [31:0] tbuf;
    // reg  [15:0] keycodev=0;
    // wire [15:0] keycode;
    // wire [ 7:0] tbus;
    // reg  [ 2:0] bcount=0;
    wire        flag;
    // reg         cn=0;
    
    always @(posedge(clk))begin
        CLK50MHZ<=~CLK50MHZ;
    end
    
    PS2Receiver uut (
        .clk(CLK50MHZ),
        .kclk(PS2Clk),
        .kdata(PS2Data),
        .keycode(keyc),
        .oflag(flag)
    );
    
    
    
endmodule
