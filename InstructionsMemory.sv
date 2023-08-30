module InstructionsMemory#(
	parameter ADDR_WIDTH = 5,
	parameter DATA_WIDTH = 32)
(
	input logic ADDR,
	output logic RD);
	
logic [DATA_WIDTH-1:0] memory [2**ADDR_WIDTH];
always_ff @ (posedge clk) begin
	 
		memory[ADDR] <= WD3;
end
assign RD = memory[ADDR];
endmodule;