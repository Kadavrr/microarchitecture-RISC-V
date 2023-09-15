module Tract(
	input logic clk,
	input logic [31:0] WD,
	input logic StallF, StallD, FlushD, FlushE,
	input logic ForwardAE, ForwardBE,
	output logic Rs1D, Rs2D, Rs1E, Rs2E, RdE, RegWriteM,
	output logic PCSrcE, ResultSrcE0, RdM, RdW, RegWriteW
	);
	//Work in progress
	logic [31:0] PCTarget;
	logic PCSrcE, StallF;
	logic [31:0] InstrF;
	logic [31:0] PCPlus4F;
	logic [31:0] PCD;
	TractF tractf (.PCTargetE(PCTargetE),
						.PCSrcE(PCSrcE),
						.StallF(StallF),
						.clk(clk),
						.WD(WD),
						.InstrF(InstrF),
						.PCPlus4F(PCPlus4F),
						.PCD(PCD));
						
						
	TractD tractd (.InstrD(),
						.PCPlus4F(),
						.PCF(),
						.ResultW(),
						.RdW(),
						.RegWriteW(),
						.RegWriteD(),
						.MemWriteD(),
						.ResultSrcD(),
						.Jump(),
						.BranchD(),
						.ALUSrcAD(),
						.SumSrcD(),
						.Rs1D(),
						.Rs2D(),
						.PCPlus4D(),
						.PCD(),
						.ImmExtD(),
						.RdD());
						
	TractE tracte (.RegWriteE1(),
						.MemWriteE1(),
						.ResultSrcE1(),
						.JumpE(),
						.BranchE(),
						.ALUSrcE(),
						.ALUControlE(),
						.StoreSrcE1(),
						.TypeBranchE(),
						.LoadPartE1(),
						.ALUSrcE1(),
						.SumSrcE1(),
						.LoadSrcE1(),
						.Rs1E1(),
						.Rs2E1(),
						.PCPlus4E1(),
						.PCE(),
						.ImmExtE(),
						.ResultW(),
						.ALUResultM(),
						.Rd1E(),
						.Rd2E(),
						.Rd2E(),
						.RdE1(),
						.ForwardAE(),
						.ForwardBE(),
						.RegWriteE(),
						.RdE(),
						.ResultSrcE(),
						.ALUResultE(),
						.WriteDataE(),
						.PCPlus4E(),
						.PCSrcE(),
						.Rs2E(),
						.Rs1E(),
						.MemWriteE(),
						.StoreSrcE(),
						.LoadSrcE(),
						.PCTargetE());
	
endmodule