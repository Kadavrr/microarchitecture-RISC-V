`ifndef TRACTE
`define TRACTE
`include "ALU.sv"
`include "BranchUnit.sv"
module TractE( 
	input logic RegWriteE1, MemWriteE1,
	input logic [2:0] ResultSrcE1,
	input logic JumpE, BranchE, ALUSrcE,
	input logic [3:0] ALUControlE, 
	input logic [1:0] StoreSrcE1, 
	input logic [2:0] TypeBranchE,
	input logic ALUSrcAE, 
	input logic [2:0] SumSrcE, 
	input logic [2:0] LoadSrcE1,
	input logic [4:0] Rs1E1, Rs2E1,
	input logic [31:0] PCPlus4E1,
	input logic [31:0] PCE,
	input logic [31:0] ImmExtE,
	input logic [31:0] ResultW,
	input logic [31:0] ALUResultM,
	input logic [31:0] RD1E, RD2E,
	input logic [4:0] RdE1, 
	input logic [1:0] ForwardAE, ForwardBE,
	output logic RegWriteE,
	output logic [4:0] RdE,
	output logic [2:0] ResultSrcE,
	output logic [31:0] ALUResultE,
	output logic [31:0] WriteDataE,
	output logic [31:0] PCPlus4E,
	output logic PCSrcE,
	output logic [4:0] Rs2E, Rs1E,
	output logic MemWriteE,
	output logic [2:0] StoreSrcE,
	output logic [2:0] LoadSrcE,
	output logic [31:0] PCTargetE
	);
	
	logic NeedBranchE;
	logic [3:0] Flags;
	logic [31:0] SrcAE;
	logic [31:0] SrcBE;
	logic [31:0] PreSrcBE;
	logic ZeroE;
	logic [31:0] SrcAE1;
	
	always_comb begin
	
	RegWriteE = RegWriteE1;
	ResultSrcE = ResultSrcE1;
	MemWriteE = MemWriteE1;
	//
	PCTargetE = SumSrcE ? RD2E : (PCE + ImmExtE);
	WriteDataE = PreSrcBE;
	PCPlus4E = PCPlus4E1;
	RdE = RdE1;
	Rs1E = Rs1E1; 
	Rs2E = Rs2E1;
	ZeroE = Flags[2];
	StoreSrcE = StoreSrcE1;
	LoadSrcE = LoadSrcE1;
	
	case (ForwardAE)
		2'b00: SrcAE1 = RD1E;
		2'b01: SrcAE1 = ResultW;
		2'b10: SrcAE1 = ALUResultM;
		default: SrcAE1 = 32'bx;
	endcase
	
	case (ForwardBE)
		2'b00: PreSrcBE = RD2E;
		2'b01: PreSrcBE = ResultW;
		2'b10: PreSrcBE = ALUResultM;
		default: PreSrcBE = 32'bx;
	endcase
	
	SrcBE = ALUSrcE ? ImmExtE : PreSrcBE;
	SrcAE = ALUSrcAE ? PCE : SrcAE1;
	
	end
	
	ALU alu (.ALUControl(ALUControlE),
				.A(SrcAE),
				.B(SrcBE),
				.Result(ALUResultE),
				.Flags(Flags));
	
	BranchUnit bu(.TypeBranchE(TypeBranchE),
					  .BranchE(BranchE),
					  .ZeroE(ZeroE),
					  .ALUResultE(ALUResultE),
					  .NeedBranchE(NeedBranchE));
					  
	or (PCSrcE, NeedBranchE, JumpE);
	
	 
endmodule
`endif 