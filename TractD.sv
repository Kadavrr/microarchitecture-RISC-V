module TractD(
	input logic [31:0] InstrD,
	input logic [31:0] PCPlus4D1,
	input logic [31:0] PCF,
	input logic [31:0] ResultW,
	input logic RdW, clk, RegWriteW,
	output logic [31:0] RD1D, RD2D,
	output logic RegWriteD, MemWriteD,
	output logic [1:0] ResultSrcD,
	output logic JumpD, BranchD, ALUSrcD,
	output logic [3:0] ALUControlD, 
	output logic [1:0] StoreSrcD, 
	output logic [2:0] TypeBranchD,
	output logic [2:0] LoadSrcD,
	output logic ALUSrcAD, SumSrcD,
	output logic [4:0] Rs1D, Rs2D, RdD,
	output logic [31:0] PCPlus4D,
	output logic [31:0] PCD,
	output logic [31:0] ImmExtD,
	output logic ControlSignal
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
						.LoadSrcD(LoadSrcD),
						.ALUSrcAD(ALUSrcAD),
						.SumSrcD(SumSrcD),
						.ControlSignal(ControlSignal));
	
	assign PCPlus4D = PCPlus4D1;
	assign PCD = PCF;
	
	RegisterFile #(.ADDR_WIDTH(5), .DATA_WIDTH(32)) regfile(.ADDR1(InstrD[19:15]),
																			  .ADDR2(InstrD[24:20]),
																			  .ADDR3(RdW),
																			  .WD3(ResultW),
																			  .WE3(RegWriteW),
																			  .clk(clk),
																			  .RD1(RD1D),
																			  .RD2(RD2D));
	
	
	ImmediateExtension ie(.SrcExt(),
								 .Imm(InstrD[31:7]),
								 .ImmExt(ImmExtD));
	always_comb begin
	Rs1D = InstrD[19:15];
	Rs2D = InstrD[24:20];
	RdD = InstrD[11:7];
	
	end
						
	
endmodule