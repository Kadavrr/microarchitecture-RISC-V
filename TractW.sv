module TractW(
	input logic RegWriteW1, RdW1,
	input logic [1:0] ResultSrcW,
	input logic [31:0] ALUResultW,
	input logic [31:0] ReadPartDataW,
	input logic [31:0] PCPlus4W,
	output logic RegWriteW, RdW,
	output logic [31:0] ResultW
	);
	
	always_comb begin
	case (ResultSrcW)
		2'b00: ResultW = ALUResultW;
		2'b01: ResultW = ReadPartDataW;
		2'b10: ResultW = PCPlus4W;
		default: ResultW = 32'bx;
	endcase
	RegWriteW = RegWriteW1;
	RdW = RdW1;
	end
endmodule