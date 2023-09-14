module TractE( 
	input logic RegWriteE1, MemWriteE1,
	input logic [2:0] ResultSrcE1,
	input logic JumpE, BranchE, ALUSrcE,
	input logic [3:0] ALUControlE, 
	input logic [1:0] StoreSrcE, 
	input logic [2:0] TypeBranchE,
	input logic [2:0] LoadPartE,
	input logic ALUSrcAE, SumSrcE, 
	input logic Rs1E1, Rs2E1,
	input logic [31:0] PCPlus4E1,
	input logic [31:0] PCE,
	input logic [31:0] ImmExtE,
	input logic [31:0] ResultW,
	input logic [31:0] ALUResultM,
	input logic Rd1E, ALUSrcEALUSrcE, Rd2E, RdE1,
	output logic ForwardAE, ForwardBE,
	output logic RegWriteE, MemwriteE, RdE,
	output logic [2:0] ResultSrcE,
	output logic [31:0] ALUResultE,
	output logic [31:0] WriteDataE,
	output logic PCPlus4E,
	output logic PCSrcE, Rs2E, Rs1E,
	output logic MemWriteE,
	output logic [31:0] PCTargetE
	);
	
	always_comb begin
	logic NeedBranchE;
	logic [3:0] Flags;
	logic [31:0] SrcAE;
	logic [31:0] SrcBE;
	logic [31:0] PreSrcBE;
	
	RegWriteE = RegWriteE1;
	ResultSrcE = ResultSrcE1;
	MemWriteE = MemWriteE1;
	PCTargetE = PCE + ImmExtE;
	WriteDataE = PreSrcBE;
	PCPlus4E = PCPlus4E1;
	RdE = RdE1;
	Rs1E = Rs1E1; 
	Rs2E = Rs2E1;
	
	case (ForwardAE)
		2'b00: SrcAE = Rd1E;
		2'b01: SrcAE = ResultW;
		2'b10: SrcAE = ALUResultM;
	endcase
	
	case (ForwardBE)
		2'b00: PreSrcBE = Rd2E;
		2'b01: PreSrcBE = ResultW;
		2'b10: PreSrcBE = ALUResultM;
	endcase
	
	SrcBE = ALUSrcE ? ImmExtE : PreSrcBE;
	
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