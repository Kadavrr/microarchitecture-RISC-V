module TractM(
	input logic RegWriteM1, MemWriteM,
	input logic [1:0] ResultSrcM1,
	input logic [31:0] ALUResultM,
	input logic [31:0] WriteDataM,
	input logic RdM1, clk,
	input logic [31:0] PCPlus4M1,
	input logic [2:0] StoreSrcM,
	input logic [2:0] LoadSrcM,
	output logic [31:0] ReadPartDataM,
	output logic RdM
	);
	logic [31:0] ReadDataM;
	logic [31:0] WritePartDataM;
	
	DataMemory #(.ADDR_WIDTH(5), .DATA_WIDTH(32)) dm (.ADDR1(ALUResultM),
																	  .WD1(WritePartDataM),
																	  .clk(clk),
																	  .WE(MemWriteM),
																     .RD1(ReadDataM));
	SPartWord #(.DATA_WIDTH(32)) spw(.StoreSrcM(StoreSrcM),
												.WriteDataM(WriteDataM),
												.WritePartDataM(WritePartDataM));
												
	LPartWord #(.DATA_WIDTH(32)) lpw(.LoadSrcM(LoadSrcM),
												.ReadDataM(ReadDataM),
												.ReadPartDataM(ReadPartDataM));
	
	
	
	
endmodule