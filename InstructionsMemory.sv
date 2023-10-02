`ifndef INSTRMEM
`define INSTRMEM
module InstructionsMemory#(
	parameter ADDR_WIDTH = 5,
	parameter DATA_WIDTH = 32)
(
	input logic clk,
	input logic [ADDR_WIDTH-1:0] ADDR,
	input logic [DATA_WIDTH-1:0] WD,
	output logic [DATA_WIDTH-1:0] RD);
	
logic [DATA_WIDTH-1:0] memory [2**ADDR_WIDTH];
always_ff @ (posedge clk) begin
	 
		memory[ADDR] <= WD;
end
assign RD = memory[ADDR];
endmodule
`endif