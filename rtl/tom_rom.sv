/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module reading data from ROM
 */

 module tom_rom
	#(parameter
		ADDR_WIDTH = 20,
		DATA_WIDTH = 12
	)
	(
		input wire clk, // posedge active clock
		input wire [ADDR_WIDTH - 1 : 0 ] addrA,
		output logic [DATA_WIDTH - 1 : 0 ] dout
	);

	(* rom_style = "block" *) // block || distributed

	logic [DATA_WIDTH-1:0] rom [2**ADDR_WIDTH-1:0]; // rom memory

	initial
		$readmemh("../../rtl/data/tom.dat", rom);

	always_ff @(posedge clk) begin : rom_read_blk
			dout <= rom[addrA];
	end

endmodule



