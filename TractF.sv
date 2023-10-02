`ifndef TRACTF
`define TRACTF
`include "InstructionsMemory.sv" 
module TractF(
	input logic [31:0] PCTargetE, 
	input logic PCSrcE, 
	input logic StallF,
	input logic clk,
	input logic [31:0] WD,
	output logic [31:0] InstrF,
	output logic [31:0] PCPlus4F,
	output logic [31:0] PCF
	);
	
	logic [31:0] PrePCF;
	logic [31:0] PCF1;
	assign PrePCF = PCSrcE ? PCTargetE : PCPlus4F;
	
	always_ff @(posedge clk) begin
		if (~StallF == 1) 
			PCF1 <= PrePCF;
	end
	
	always_comb begin
	PCPlus4F = PCF1 + 4;
	PCF = PCPlus4F;
	end
	
	InstructionsMemory #(.ADDR_WIDTH(5), .DATA_WIDTH(32)) InstrMem (.clk(clk),
																						 .ADDR(PCF), 
																						 .WD(WD), 
																						 .RD(InstrF));											
	
endmodule
`endif 