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
    input  logic [15:0] keycode,
    output  logic right,
    output  logic left,
    output  logic jump
    // output  reg [1:0] stay
 );

    logic r_nxt, l_nxt, j_nxt;


    always_ff @(posedge clk) begin
        if(rst)begin
            right <= '0;
            left <= '0;
            jump <= '0;
        end
        else begin
            right <= r_nxt;
            left <= l_nxt;
            jump <= j_nxt;
        end
    end

    always_comb begin
        case(keycode[15:8])
            8'hf0: begin
                case(keycode[7:0])
                    8'h1C: begin
                        r_nxt = 0;
                        l_nxt = left;
                        j_nxt = jump;
                    end
                    8'h23: begin
                        l_nxt = 0; 
                        r_nxt = right; 
                        j_nxt = jump;
                    end
                    8'h1D: begin 
                        j_nxt = 0; 
                        l_nxt = left; 
                        r_nxt = right;
                    end
                    default: begin
                        r_nxt = right;
                        l_nxt = left;
                        j_nxt = jump;
                    end
                endcase
            end

            8'h00: begin
                case(keycode[7:0])
                    8'h1C: begin
                        r_nxt = 1;
                        l_nxt = left;
                        j_nxt = jump;
                    end
                    8'h23: begin
                        l_nxt = 1; 
                        r_nxt = right; 
                        j_nxt = jump;
                    end
                    8'h1D: begin 
                        j_nxt = 1; 
                        l_nxt = left; 
                        r_nxt = right;
                    end
                    default: begin
                        r_nxt = right;
                        l_nxt = left;
                        j_nxt = jump;
                    end
                endcase
            end

            default: begin
                r_nxt = right;
                l_nxt = left;
                j_nxt = jump;
            end

        endcase
    end

 endmodule 