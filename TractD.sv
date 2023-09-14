module TractD(
	input logic [31:0] InstrD,
	input logic [31:0] PCPlus4F,
	input logic [31:0] PCF,
	input logic [31:0] ResultW,
	input logic RdW,
	input logic RegWriteW,
	output logic RegWriteD, MemWriteD,
	output logic [2:0] ResultSrcD,
	output logic JumpD, BranchD, ALUSrcD,
	output logic [3:0] ALUControlD, 
	output logic [1:0] StoreSrcD, 
	output logic [2:0] TypeBranchD,
	output logic [2:0] LoadPartD,
	output logic ALUSrcAD, SumSrcD,
	output logic Rs1D, Rs2D,
	output logic [31:0] PCPlus4D,
	output logic [31:0] PCD,
	output logic [31:0] ImmExtD,
	output logic RdD
	);
	
	logic [2:0] ImmSrcD;
	
	ControlUnit cu(.op(InstrD[6:0]),
						.funct3(InstrD[14:12]),
						.funct7(InstrD[31:25]),
						.RegWriteD(RegWriteD),
						.ResultSrcD(ResultSrcD),
						.MemWriteD(MemWriteD),
						.JumpD(JumpD),
						.BranchD(BranchD),
						.ALUSrcD(ALUSrcD),
						.ALUControlD(ALUControlD),
						.StoreSrcD(StoreSrcD),
						.TypeBranchD(TypeBranchD),
						.LoadPartD(LoadPartD),
						.ALUSrcAD(ALUSrcAD),
						.SumSrcD(SumSrcD));
	
	assign PCPlus4D = PCPlus4F;
	assign PCD = PCF;
	
	
	ImmediateExtension ie(.SrcExt(),
								 .Imm(InstrD[31:7]),
								 .ImmExt(ImmExtD));
	always_comb begin
	Rs1D = InstrD[19:15];
	Rs2D = InstrD[24:20];
	RdD = InstrD[11:7];
	
	end
						
	
endmodule