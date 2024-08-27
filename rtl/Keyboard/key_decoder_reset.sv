//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   keycode_decoder
 Author:        Tomasz Maslanka, Jakub Brzazgacz
 Version:       1.0
 Last modified: 2024-08-07
 Coding style: safe with FPGA sync reset
 Description:  Decoder for keyboard signals
 */
//////////////////////////////////////////////////////////////////////////////

 module key_decoder_reset(
    input  logic clk,
    input  logic rst,
    input  logic [15:0] keycode,
    output logic reset
 );

    logic reset_nxt;

always_ff@(posedge clk)begin
    if(rst) begin
        reset <= '0;
    end else begin
        reset <= reset_nxt;
    end
end

always_comb begin
    if(keycode[15:8] == 8'hf0) begin
        if(keycode[7:0] == 8'h5a) begin
            reset_nxt = 0;
        end else begin
            reset_nxt = reset;
        end
    end else begin
        if(keycode[7:0] == 8'h5a) begin
            reset_nxt = 1;
        end else begin
            reset_nxt = reset;
        end
    end
end


endmodule 