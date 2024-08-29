module char_rom_gameover
    #( parameter
    TOM = 1
    )
(
    input  logic clk,
    input  logic [11:0] char_xy,
    output logic [6:0] char_code
);

logic [6:0] data;

always_ff @(posedge clk) begin
    char_code <= data;
end

always_comb begin
    if(TOM == 1) begin
        case(char_xy) 
            12'h000: data = "T";
            12'h001: data = "O";
            12'h002: data = "M";   
            12'h003: data = " ";
            12'h004: data = "W";
            12'h005: data = "I";
            12'h006: data = "N";
            12'h007: data = "S";
            12'h008: data = " ";
            12'h009: data = "P";
            12'h00a: data = "R";
            12'h00b: data = "E";    
            12'h00c: data = "S";
            12'h00d: data = "S";
            12'h00e: data = " ";
            12'h00f: data = "E";
            12'h010: data = "N";
            12'h011: data = "T";
            12'h012: data = "E";
            12'h013: data = "R";
            12'h014: data = " ";
            12'h015: data = "T";
            12'h016: data = "O";
            12'h017: data = " ";
            12'h018: data = "R";
            12'h019: data = "E";
            12'h01a: data = "S";
            12'h01b: data = "E";
            12'h01c: data = "T";
            default: data = 7'h20;
        endcase
    end
    else begin
        case(char_xy) 
            12'h000: data = "J";
            12'h001: data = "E";
            12'h002: data = "R";   
            12'h003: data = "R";
            12'h004: data = "Y";
            12'h005: data = " ";
            12'h006: data = "W";
            12'h007: data = "I";
            12'h008: data = "N";
            12'h009: data = "S";
            12'h00a: data = " ";
            12'h00b: data = "P";
            12'h00c: data = "R";
            12'h00d: data = "E";    
            12'h00e: data = "S";
            12'h00f: data = "S";
            12'h010: data = " ";
            12'h011: data = "E";
            12'h012: data = "N";
            12'h013: data = "T";
            12'h014: data = "E";
            12'h015: data = "R";
            12'h016: data = " ";
            12'h017: data = "T";
            12'h018: data = "O";
            12'h019: data = " ";
            12'h01a: data = "R";
            12'h01b: data = "E";
            12'h01c: data = "S";
            12'h01d: data = "E";
            12'h01e: data = "T";
            default: data = 7'h20;
        endcase
    end
end


endmodule 