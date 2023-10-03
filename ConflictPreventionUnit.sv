`ifndef CONFUNIT
`define CONFUNIT
module ConflictPreventionUnit(
	input logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW,
	input logic PCSrcE, rst,
	input logic ResultSrcE0,
	input logic RegWriteW, RegWriteM,
	output logic StallF, StallD, FlushD, FlushE,
	output logic [1:0] ForwardAE, ForwardBE);
	
	always_comb begin
	logic lwStall;
	
	if ((Rs1E != 0) && (Rs1E == RdM) && RegWriteM)
		ForwardAE = 2'b10;
	else if ((Rs1E != 0) && (Rs1E == RdW) && RegWriteW)
		ForwardAE = 2'b01;
	else ForwardAE = 2'b00;
	
	if ((Rs2E != 0) && (Rs2E == RdM) && RegWriteM)
		ForwardBE = 2'b10;
	else if ((Rs2E != 0) && (Rs2E == RdW) && RegWriteW)
		ForwardBE = 2'b01;
	else ForwardBE = 2'b00;
	
	lwStall = ResultSrcE0 && ((Rs1D == RdE) | (Rs2D == RdE));
	StallF = lwStall;
	StallD = lwStall;
	if (rst) begin
		FlushE = 1;
		FlushD = 1;
	end
	else begin
		FlushD = PCSrcE;
		FlushE = lwStall | PCSrcE;
		end
	end
	
endmodule
`endif	