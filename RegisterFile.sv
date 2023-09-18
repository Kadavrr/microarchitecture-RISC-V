module RegisterFile #(
	parameter ADDR_WIDTH = 5,
	parameter DATA_WIDTH = 32)
	
(
	input logic [ADDR_WIDTH-1:0] ADDR1, ADDR2, ADDR3,
	input logic [ADDR_WIDTH-1:0] ADDR4, ADDR5, ADDR6,
	input logic [DATA_WIDTH-1:0] WD3, WD6,
	input logic clk,
	input logic WE3, WE6,
	output logic [DATA_WIDTH-1:0] RD1, RD2, RD4, RD5);
	
logic [DATA_WIDTH-1:0] memory [2**ADDR_WIDTH];

always_ff @ (negedge clk) begin
	if (WE3) begin
		memory[ADDR3] <= WD3;
		end
	else if (WE6) begin
		memory[ADDR6] <= WD6;
		end
	end
	
assign RD1 = memory[ADDR1];
assign RD2 = memory[ADDR2];
assign RD4 = memory[ADDR4];
assign RD5 = memory[ADDR5];

endmodule	