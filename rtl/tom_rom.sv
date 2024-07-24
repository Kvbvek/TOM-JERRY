/**
 * Copyright (C) 2024  AGH University of Science and Technology
 * MTM UEC2
 * Authors: Jakub Brzazgacz, Tomasz Maślanka
 * Description:
 * Module reading Tom model from ROM
 */

 module tom_rom
	(
		input wire clk,
		input wire [19:0] address,
		output logic [11:0] data
	);

	 (* rom_style = "block" *) // block || distributed

	logic [11:0] rom [4999:0]; // rom memory

	initial
		$readmemh("../../rtl/data/tom.dat", rom);

	always_ff @(posedge clk) begin
		data <= rom[address];
	end

endmodule