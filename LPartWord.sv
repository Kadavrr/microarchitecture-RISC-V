module LPartWord#(
	parameter DATA_WIDTH = 32)
(
	input logic [2:0] LoadSrcM,
	input logic signed [DATA_WIDTH-1:0] ReadDataM,
	output logic [DATA_WIDTH-1:0] ReadPartDataM); 
	
	always_comb begin
	integer HalfWord = DATA_WIDTH/2;
	case (StoreSrcM)
		3'b001: ReadPartDataM[HalfWord-1:0] =  ReadDataM[HalfWord-1:0]; //LH
				  ReadPartDataM[DATA_WIDTH-1:HalfWord] = ReadDatam[DATA_WIDTH];
		3'b000: ReadPartDataM[7:0] = ReadData[7:0]; //LB
				  ReadPartDataM[DATA_WIDTH-1:8] = ReadDatam[DATA_WIDTH];
		3'b000: ReadPartDataM = ReadDataM; //LW
		3'b100: ReadPartDataM[7:0] = ReadData[7:0]; //LB
				  ReadPartDataM[DATA_WIDTH-1:8] = 0;
		3'b101: ReadPartDataM[HalfWord-1:0] =  ReadDataM[HalfWord-1:0]; //LHU
				  ReadPartDataM[DATA_WIDTH-1:HalfWord] = 0;
		default: ReadPartDataM = 1'x;
		endcase
	end
endmodule