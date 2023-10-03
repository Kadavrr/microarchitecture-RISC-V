`ifndef SPART
`define SPART
module SPartWord#(
	parameter DATA_WIDTH = 32)
(
	input logic [1:0] StoreSrcM,
	input logic [DATA_WIDTH-1:0] WriteDataM,
	output logic [DATA_WIDTH-1:0] WritePartDataM); 
	
	
	always_comb begin
	case (StoreSrcM)
		2'b10: begin
				 WritePartDataM[(DATA_WIDTH/2)-1:0] =  WriteDataM[(DATA_WIDTH/2)-1:0]; //SH
				 WritePartDataM[DATA_WIDTH-1:(DATA_WIDTH/2)] = 0;
				 end
		2'b01: begin
				 WritePartDataM[7:0] = WriteDataM[7:0]; //SB
				 WritePartDataM[DATA_WIDTH-1:8] = 0;
				 end
		2'b00: WritePartDataM = WriteDataM; //SW
		default: WritePartDataM = 1'bx;
		endcase
	end
endmodule
`endif