//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   move_ctrl
 Author:        Tomasz Maslanka, Jakub Brzazgacz
 Version:       1.0
 Last modified: 2024-08-07
 Coding style: safe with FPGA sync reset
 Description:  Decoder for keyboard signals
 */
//////////////////////////////////////////////////////////////////////////////

 module decoder(
    input  logic clk,
    input  logic rst,
    input  reg [15:0] keycode,
    output  reg [1:0] right,
    output  reg [1:0] left,
    output  reg [1:0] jump,
    output  reg [1:0] stay
 );

    logic [1:0] right_nxt;
    logic [1:0] left_nxt;
    logic [1:0] jump_nxt;
    logic [1:0] stay_nxt;

    always_ff @(posedge clk) begin
        if(rst)begin
            right <= 2'b00;
            left <= 2'b00;
            jump <= 2'b00;
            stay <= 2'b01;
        end
        else begin
            right <= right_nxt;
            left <= left_nxt;
            jump <= jump_nxt;
            stay <= stay_nxt;
        end
    end

    always_comb begin
        right_nxt = 2'b00;
        left_nxt = 2'b00;
        jump_nxt = 2'b00;
        stay_nxt = 2'b01;

        case(keycode)
            16'h1C: right_nxt = 2'b01;
            16'h23: left_nxt = 2'b10;
            16'h1D: jump_nxt = 2'b11;
            default: stay_nxt = 2'b00;
        endcase
    end

 endmodule 