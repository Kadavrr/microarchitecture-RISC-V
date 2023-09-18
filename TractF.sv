module TractF(
	input logic [31:0] PCTargetE, 
	input logic PCSrcE, 
	input logic StallF,
	input logic clk,
	input logic [31:0] WD,
	output logic [31:0] InstrF,
	output logic [31:0] PCPlus4F,
	output logic [31:0] PCD
	);
	
	logic [31:0] PrePCF;
	logic [31:0] PCF;
	assign PrePCF = PCSrcE ? PCTargetE : PCPlus4F;
	
	always_ff @(posedge clk) begin
		if (~StallF == 1) 
			PCF <= PrePCF;
	end
	
	always_comb begin
	PCPlus4F = PCF + 4;
	PCD = PCPlus4F;
	end
	
	InstructionsMemory #(.ADDR_WIDTH(5), .DATA_WIDTH(32)) InstrMem (.ADDR(PCF), 
																						 .WD(WD), 
																						 .RD(InstrF));											
	
endmodule