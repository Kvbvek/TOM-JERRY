module char_rom_score(
    input logic clk,
    input logic [11:0] char_xy,

    output logic [6:0] char_code
);

logic [6:0] data;

always_ff @(posedge clk) begin
    char_code <= data;
end

always_comb begin
    case(char_xy) 
        12'h000: data = "s";
        12'h001: data = "c";
        12'h002: data = "o";
        12'h003: data = "r";
        12'h004: data = "e";
        default: data = 7'h20;
    endcase
end


endmodule 