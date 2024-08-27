module char_rom_gameover(
    input  logic clk,
    input  logic [11:0] char_xy,
    output logic [6:0] char_code
);

logic [6:0] data;

always_ff @(posedge clk) begin
    char_code <= data;
end

always_comb begin
        case(char_xy) 
            12'h000: data = "G";
            12'h001: data = "A";
            12'h002: data = "M";   
            12'h003: data = "E";
            12'h004: data = "O";
            12'h005: data = "V";
            12'h006: data = "E";
            12'h007: data = "R";
            12'h008: data = " ";
            12'h009: data = "P";
            12'h00a: data = "R";
            12'h00b: data = "E";    
            12'h00c: data = "S";
            12'h00d: data = "S";
            12'h00e: data = " ";
            12'h00f: data = "S";
            12'h010: data = "P";
            12'h011: data = "A";
            12'h012: data = "C";
            12'h013: data = "E";
            12'h014: data = " ";
            12'h015: data = "T";
            12'h016: data = "O";
            12'h017: data = " ";
            12'h018: data = "R";
            12'h019: data = "E";
            12'h01a: data = "S";
            12'h01b: data = "T";
            12'h01c: data = "A";
            12'h01d: data = "R";
            12'h01e: data = "T";
            default: data = 7'h20;
        endcase
end


endmodule 