/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Tomasz Maslanka, Jakub Brzazgacz
 *
 * Description:
 * Module reading data from ROM
 */

 module read_rom
	#(parameter
		ADDR_WIDTH = 20,
		DATA_WIDTH = 12,
        DATA_PATH = ""
	)
	(
		input wire clk, // posedge active clock
		input wire [ADDR_WIDTH - 1 : 0 ] addrA,
		output logic [DATA_WIDTH - 1 : 0 ] dout
	);

	(* rom_style = "block" *) // block || distributed

	logic [DATA_WIDTH-1:0] rom [2**ADDR_WIDTH-1:0];

    initial
		$readmemh(DATA_PATH, rom);

	always_ff @(posedge clk) begin : rom_read_blk
			dout <= rom[addrA];
	end

endmodule



