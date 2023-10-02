`include "TractF.sv"
`include "TractD.sv"
`include "TractE.sv"
`include "TractF.sv"
`include "TractM.sv"
`include "TractW.sv"
module Tract(
	input logic clk,
	input logic [31:0] WD,
	input logic StallF, StallD, FlushD, FlushE,
	input logic [1:0] ForwardAE, ForwardBE,
	output logic [4:0] Rs1E, Rs2E, RdE, Rs1D, Rs2D,
   output logic RegWriteM,
	output logic PCSrcE, ResultSrcE0, RegWriteW,
	output logic [4:0] RdM, RdW,
	output logic ControlSignal
	);
	logic [31:0] PCTargetE;
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
						
//add signals FlushD and StallD
	always_ff @(posedge clk or posedge FlushD) begin
		if (FlushD) begin
			PCD <= 0;
			PCPlus4D <= 0;
			InstrD <= 0;
		end
		else if (~StallD) begin
			PCD <= PCF;
			PCPlus4D <= PCPlus4F;
			InstrD <= InstrF;
		end
	end
						
	logic [31:0] InstrD;
	logic [31:0] PCPlus4D1;
	logic [31:0] PCF;
	logic [31:0] ResultW;
	logic RegWriteD, MemWriteD;
	logic [1:0] ResultSrcD;
	logic JumpD, BranchD, ALUSrcD;
	logic [3:0] ALUControlD;
	logic [1:0] StoreSrcD;
	logic [2:0] TypeBranchD;
	logic [2:0] LoadSrcD;
	logic ALUSrcAD, SumSrcD;
	logic [31:0] PCPlus4D;	
	logic [31:0] ImmExtD;
	logic [4:0] RdD;
	logic [31:0] RD1D, RD2D;
	
	TractD tractd (.InstrD(InstrD),
						.PCPlus4D1(PCPlus4D1),
						.PCF(PCF),
						.ResultW(ResultW),
						.RdW(RdW),
						.RegWriteW(RegWriteW),
						.clk(clk),
						.RD1D(RD1D),
						.RD2D(RD2D),
						.RegWriteD(RegWriteD),
						.MemWriteD(MemWriteD),
						.ResultSrcD(ResultSrcD),
						.JumpD(JumpD),
						.BranchD(BranchD),
						.ALUSrcD(ALUSrcD),
						.ALUSrcAD(ALUSrcAD),
						.ALUControlD(ALUControlD),
						.StoreSrcD(StoreSrcD),
						.TypeBranchD(TypeBranchD),
						.LoadSrcD(LoadSrcD),
						.SumSrcD(SumSrcD),
						.Rs1D(Rs1D),
						.Rs2D(Rs2D),
						.PCPlus4D(PCPlus4D),
						.PCD(PCD),
						.ImmExtD(ImmExtD),
						.RdD(RdD),
						.ControlSignal(ControlSignal));
						
		always_ff @(posedge clk or posedge FlushE) begin
		if (FlushE) begin
			RegWriteE <= 0;
			MemWriteE <= 0;
			ResultSrcE <= 0;
			JumpE <= 0;
			BranchE <= 0;
			ALUControlE <= 0;
			ALUSrcE <= 0;
			ALUSrcAE <= 0;
			SumSrcE <= 0;
			RD1E <= 0;
			RD2E <= 0;
			PCE <= 0;
			Rs1E <= 0;
			Rs2E <= 0;
			RdE <= 0;
			ImmExtE <= 0;
			PCPlus4E <= 0;
			TypeBranchE <= 0;
			StoreSrcE <= 0;
			LoadSrcE <= 0;
		end
		else begin
			RegWriteE <= RegWriteD;
			MemWriteE <= MemWriteD;
			ResultSrcE <= ResultSrcD;
			JumpE <= JumpD;
			BranchE <= BranchD;
			ALUControlE <= ALUControlD;
			ALUSrcE <= ALUSrcD;
			ALUSrcAE <= ALUSrcAD;
			SumSrcE <= SumSrcD;
			RD1E <= RD1D;
			RD2E <= RD2D;
			PCE <= PCD;
			Rs1E <= Rs1D;
			Rs2E <=Rs2D;
			RdE <= RdD;
			ImmExtE <= ImmExtD;
			PCPlus4E <= PCPlus4D;
			TypeBranchE <= TypeBranchD;
			StoreSrcE <= StoreSrcD;
			LoadSrcE <= LoadSrcD;
		end
			
	end
						
	logic RegWriteE1, MemWriteE1, ALUSrcAE;
	logic [1:0] ResultSrcE1;
	logic JumpE, BranchE;
	logic [3:0] ALUControlE;
	logic [1:0] StoreSrcE1;
	logic [2:0] LoadSrcE1, TypeBranchE;
	logic Rs1E1, Rs2E1;
	logic [2:0] SumSrcE;
	logic [31:0] PCPlus4E1, PCE, ImmExtE, ALUResultE;
	logic [31:0] RD1E, RD2E;
	logic [4:0] RdE1;
	logic RegWriteE;
	logic [1:0] ResultSrcE;
	logic [31:0] WriteDataE;
	logic [31:0] PCPlus4E;
	logic MemWriteE, ALUSrcE;
	logic [2:0] StoreSrcE, LoadSrcE;
	logic [31:0] ALUResultM;
	
	
	assign ResultSrcE0 = ResultSrcE[0];
	
	
	TractE tracte (.RegWriteE1(RegWriteE1),
						.MemWriteE1(MemWriteE1),
						.ResultSrcE1(ResultSrcE1),
						.JumpE(JumpE),
						.BranchE(BranchE),
						.ALUSrcAE(ALUSrcAE),
						.ALUSrcE(ALUSrcE),
						.ALUControlE(ALUControlE),
						.StoreSrcE1(StoreSrcE1),
						.TypeBranchE(TypeBranchE),
						.LoadSrcE1(LoadSrcE1),
						.RdE1(RdE1),
						.SumSrcE(SumSrcE),
						.Rs1E1(Rs1E1),
						.Rs2E1(Rs2E1),
						.PCPlus4E1(PCPlus4E1),
						.PCE(PCE),
						.ImmExtE(ImmExtE),
						.ResultW(ResultW),
						.ALUResultM(ALUResultM),
						.RD1E(RD1E),
						.RD2E(RD2E),
						.ForwardAE(ForwardAE),
						.ForwardBE(ForwardBE),
						.RegWriteE(RegWriteE),
						.RdE(RdE),
						.ResultSrcE(ResultSrcE),
						.ALUResultE(ALUResultE),
						.WriteDataE(WriteDataE),
						.PCPlus4E(PCPlus4E),
						.PCSrcE(PCSrcE),
						.Rs2E(Rs2E),
						.Rs1E(Rs1E),
						.MemWriteE(MemWriteE),
						.StoreSrcE(StoreSrcE),
						.LoadSrcE(LoadSrcE),
						.PCTargetE(PCTargetE));
						
	always_ff @(posedge clk) begin
		StoreSrcM <= StoreSrcE;
		LoadSrcM <= LoadSrcE;
		RegWriteM1 <= RegWriteE;
		MemWriteM <= MemWriteE;
		ResultSrcM <= ResultSrcE;
		ALUResultM <= ALUResultE;
		WriteDataM <= WriteDataE;
		RdM <= RdE;
		PCPlus4M <= PCPlus4E;
	end
		
						
	logic RegWriteM1, MemWriteM;
	logic [1:0] ResultSrcM1;
	logic [31:0] WriteDataM, PCPlus4M1, PCPlus4M;
	logic [31:0] ReadPartDataM, ALUResultMW;
	logic [2:0] StoreSrcM, LoadSrcM;
	logic [1:0] ResultSrcM;
	
	TractM tractm (.RegWriteM1(RegWriteM1),
						.MemWriteM(MemWriteM),
						.ResultSrcM1(ResultSrcM1),
						.ALUResultM(ALUResultM),
						.WriteDataM(WriteDataM),
						.clk(clk),
						.PCPlus4M1(PCPlus4M1),
						.StoreSrcM(StoreSrcM),
						.LoadSrcM(LoadSrcM),
						.ReadPartDataM(ReadPartDataM),
						.RdM(RdM),
						.ALUResultMW(ALUResultMW),
						.ResultSrcM(ResultSrcM),
						.RegWriteM(RegWriteM));
						
	always_ff @(posedge clk) begin
	RegWriteW <= RegWriteM;
	ResultSrcW <= ResultSrcM;
	ReadPartDataW <= ReadPartDataM;
	ALUResultW <= ALUResultMW;
	RdW <= RdM;
	PCPlus4W <= PCPlus4M;
	end
						
	logic RegWriteW1, RdW1;
	logic [1:0] ResultSrcW;
	logic [31:0] ALUResultW, ReadPartDataW, PCPlus4W;
	
	TractW tractw (.RegWriteW1(RegWriteW1),
						.RdW1(RdW1),
						.ResultSrcW(ResultSrcW),
						.ALUResultW(ALUResultW),
						.ReadPartDataW(ReadPartDataW),
						.PCPlus4W(PCPlus4W),
						.RegWriteW(RegWriteW),
						.RdW(RdW),
						.ResultW(ResultW));
	
endmodule