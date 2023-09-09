module InstructionsMemory#(
	parameter ADDR_WIDTH = 5,
	parameter DATA_WIDTH = 32)
(
	input logic clk,
	input logic ADDR,
	input logic WD,
	output logic RD);
	
logic [DATA_WIDTH-1:0] memory [2**ADDR_WIDTH];
always_ff @ (posedge clk) begin
	 
		memory[ADDR] <= WD;
end
assign RD = memory[ADDR];
endmodule