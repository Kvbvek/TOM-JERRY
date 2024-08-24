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
            12'h010: data = "R";
            12'h011: data = "E";    
            12'h012: data = "S";
            12'h013: data = "S";
            12'h014: data = " ";
            12'h015: data = "S";
            12'h016: data = "P";
            12'h017: data = "A";
            12'h018: data = "C";
            12'h019: data = "E";
            12'h020: data = " ";
            12'h021: data = "T";
            12'h022: data = "O";
            12'h023: data = " ";
            12'h024: data = "R";
            12'h025: data = "E";
            12'h026: data = "S";
            12'h027: data = "T";
            12'h028: data = "A";
            12'h029: data = "R";
            12'h030: data = "T";
            default: data = 7'h20;
        endcase
end


endmodule 