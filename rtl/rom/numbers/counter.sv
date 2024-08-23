/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module 
 */


 module counter(
    input clk,
    input rst,
    input [7:0] cheese_ctr,
    input logic [19:0] addrA,
    output logic [11:0] rgb
 );

 logic [11:0] zero, one, two, three, four, five, six, seven, eight, nine;
 logic [11:0] rgb_nxt;

 read_rom # (
    .DATA_PATH("../../rtl/data/numbers/0.dat")
 ) read_rom_0 (
    .clk(clk),
    .addrA(addrA),
    .dout (zero)
 );

read_rom #(
    .DATA_PATH("../../rtl/data/numbers/1.dat")
) read_rom_1(
    .clk(clk),
    .addrA(addrA),
    .dout(one)
);

read_rom #(
    .DATA_PATH("../../rtl/data/numbers/2.dat")
) read_rom_2(
    .clk(clk),
    .addrA(addrA),
    .dout(two)
);

read_rom #(
    .DATA_PATH("../../rtl/data/numbers/3.dat")
) read_rom_3(
    .clk(clk),
    .addrA(addrA),
    .dout(three)
);

read_rom #(
    .DATA_PATH("../../rtl/data/numbers/4.dat")
) read_rom_4(
    .clk(clk),
    .addrA(addrA),
    .dout(four)
);

read_rom #(
    .DATA_PATH("../../rtl/data/numbers/5.dat")
) read_rom_5(
    .clk(clk),
    .addrA(addrA),
    .dout(five)
);

read_rom #(
    .DATA_PATH("../../rtl/data/numbers/6.dat")
) read_rom_6(
    .clk(clk),
    .addrA(addrA),
    .dout(six)
);

read_rom #(
    .DATA_PATH("../../rtl/data/numbers/7.dat")
) read_rom_7(
    .clk(clk),
    .addrA(addrA),
    .dout(seven)
);

read_rom #(
    .DATA_PATH("../../rtl/data/numbers/8.dat")
) read_rom_8(
    .clk(clk),
    .addrA(addrA),
    .dout(eight)
);

read_rom #(
    .DATA_PATH("../../rtl/data/numbers/9.dat")
) read_rom_9(
    .clk(clk),
    .addrA(addrA),
    .dout(nine)
);


always_comb begin
    if(cheese_ctr == 0) begin
        rgb_nxt = zero;
    end else if(cheese_ctr == 1) begin
        rgb_nxt = one; 
    end else if(cheese_ctr == 2) begin
        rgb_nxt = two;
    end else if(cheese_ctr == 3) begin
        rgb_nxt = three;
    end else if(cheese_ctr == 4) begin
        rgb_nxt = four;
    end else if(cheese_ctr == 5) begin
        rgb_nxt = five;
    end else if(cheese_ctr == 6) begin
        rgb_nxt = six;
    end else if(cheese_ctr == 7) begin
        rgb_nxt = seven;
    end else if(cheese_ctr == 8) begin
        rgb_nxt = eight;
    end else if(cheese_ctr == 9) begin
        rgb_nxt = nine;
    end
    else begin
        rgb_nxt = zero;
    end
end

always_ff @(posedge clk) begin
    if(rst) rgb <= '0;
    else rgb <= rgb_nxt;
end


 endmodule 