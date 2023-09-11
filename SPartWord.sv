module SPartWord#(
	parameter DATA_WIDTH = 32)
(
	input logic [1:0] StoreSrcM,
	input logic [DATA_WIDTH-1:0] WriteDataM,
	output logic [DATA_WIDTH-1:0] WritePartDataM); 
	
	always_comb begin
	integer HalfWord = DATA_WIDTH/2;
	case (StoreSrcM)
		2'b10: WritePartDataM[HalfWord-1:0] =  WriteDataM[HalfWord-1:0]; //SH
				 WritePartDataM[DATA_WIDTH-1:HalfWord] = 0;
		2'b01: WritePartDataM[7:0] = WriteData[7:0]; //SB
				 WritePartDataM[DATA_WIDTH-1:8] = 0;
		2'b00: WritePartDataM = WriteDataM; //SW
		default: WritePartDataM = 1'x;
		endcase
	end
endmodule