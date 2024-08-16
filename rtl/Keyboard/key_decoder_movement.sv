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

 module key_decoder_movement(
    input  logic clk,
    input  logic rst,
    input  logic [15:0] keycode,
    output  logic right,
    output  logic left,
    output  logic jump
 );

    logic r_nxt, l_nxt, j_nxt;
    logic [7:0] ctr, ctr_nxt;
    // 23 D prawo | 1D W skok | 1C A lewo

    always_ff @(posedge clk) begin
        if(rst)begin
            right <= '0;
            left <= '0;
            jump <= '0;

            ctr <= '0;
        end
        else begin
            right <= r_nxt;
            left <= l_nxt;
            jump <= j_nxt;

             ctr <= ctr_nxt;
        end
    end

    always_comb begin
        if(keycode[15:8] == 8'hf0) begin
            if(keycode[7:0] == 8'h1C) begin
                    r_nxt = right;
                    l_nxt = 0;
                end
            else if(keycode[7:0] == 8'h23) begin
                    l_nxt = left; 
                    r_nxt = 0; 
                end
            else begin
                    r_nxt = right;
                    l_nxt = left;
            end
        end

        else begin
            if(keycode[7:0] == 8'h1C) begin
                    r_nxt = right;
                    l_nxt = 1;
                end
            else if(keycode[7:0] == 8'h23) begin
                    l_nxt = left; 
                    r_nxt = 1; 
                end
            else begin
                    r_nxt = right;
                    l_nxt = left;
            end
        end

        if((keycode[7:0] == 8'h1D) && keycode[15:8] != 8'hf0) begin
            if(ctr > 50) begin // just few clock cycles to catch the info of jumping
                j_nxt = 0;
                ctr_nxt = 0;
            end
            else begin
                j_nxt = 1;
                ctr_nxt = ctr + 1;
            end            
        end

        else begin
            j_nxt = 0;
            ctr_nxt = 0;
        end

    end

 endmodule 