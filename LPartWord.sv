`ifndef LPART
`define LPART
module LPartWord#(
	parameter DATA_WIDTH = 32)
(
	input logic [2:0] LoadSrcM,
	input logic signed [DATA_WIDTH-1:0] ReadDataM,
	output logic [DATA_WIDTH-1:0] ReadPartDataM); 
	
	always_comb begin
	case (LoadSrcM)
		3'b001: begin
				  ReadPartDataM[(DATA_WIDTH/2)-1:0] =  ReadDataM[(DATA_WIDTH/2)-1:0]; //LH
				  ReadPartDataM[DATA_WIDTH-1:(DATA_WIDTH/2)] = ReadDataM[DATA_WIDTH-1];
				  end
		3'b000: begin
				  ReadPartDataM[7:0] = ReadDataM[7:0]; //LB
				  ReadPartDataM[DATA_WIDTH-1:8] = ReadDataM[DATA_WIDTH-1];
				  end
		3'b010: ReadPartDataM = ReadDataM; //LW
		3'b100: begin
				  ReadPartDataM[7:0] = ReadDataM[7:0]; //LB
				  ReadPartDataM[DATA_WIDTH-1:8] = 0;
				  end
		3'b101: begin
				  ReadPartDataM[(DATA_WIDTH/2)-1:0] =  ReadDataM[(DATA_WIDTH/2)-1:0]; //LHU
				  ReadPartDataM[DATA_WIDTH-1:(DATA_WIDTH/2)] = 0;
				  end
		default: ReadPartDataM = 1'bx;
		endcase
	end
endmodule
`endif