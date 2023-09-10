module DataMemory#(
	parameter ADDR_WIDTH = 5,
	parameter DATA_WIDTH = 32)
(
	input logic [ADDR_WIDTH-1:0] ADDR1, ADDR2,
	input logic [DATA_WIDTH-1:0] WD1, WD2,
	input logic clk,
	input logic WE,
	output logic [DATA_WIDTH-1:0] RD1, RD2);
	
logic [DATA_WIDTH-1:0] memory [2**ADDR_WIDTH];
always_ff @ (posedge clk) begin
	if (WE) begin
		memory[ADDR1] <= WD1;
		memory[ADDR2] <= WD2;
		end
	end
always_comb begin
	RD1 = memory[ADDR1];
	RD2 = memory[ADDR2];
end
	
endmodule