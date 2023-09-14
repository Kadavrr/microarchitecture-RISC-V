module ConflictPreventionUnit(
	input logic RS1D, RS2D, RS1E, RS2E, PCSrcE,
	input logic ResultSrcE0,
	input RdE, RdM, RdW, RegWriteW, RegWriteM,
	output logic StallF, StallD, FlushD, FlushE,
	output logic ForwardAE, ForwardBE);
	
	always_comb begin
	logic lwStall;
	
	if ((RS1E != 0) && (RS1E == RdM) && RegWriteM)
		ForwardAE = 10;
	else if ((RS1E != 0) && (RS1E == RdW) && RegWriteW)
		ForwardAE = 01;
	else ForwardAE = 00;
	
	if ((RS2E != 0) && (RS2E == RdM) && RegWriteM)
		ForwardBE = 10;
	else if ((RS2E != 0) && (RS2E == RdW) && RegWriteW)
		ForwardBE = 01;
	else ForwardBE = 00;
	
	lwStall = ResultSrcE0 && ((RS1D == RdE) | (RS2D == RdE));
	StallF = lwStall;
	StallD = lwStall;
	FlushD = PCSrcE;
	FlushE = lwStall | PCSrcE;
	end
	
	endmodule
	