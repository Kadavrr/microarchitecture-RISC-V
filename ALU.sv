module ALU #(
	parameter A_WIDTH = 32)
	
(	input logic [2:0] ALUControl,
	input logic [A_WIDTH-1:0] A, B,
	output logic [A_WIDTH-1:0] Result, 
	output logic [3:0] Flags);
	
	case (ALUControl)
	3'b000: Result = A + B; //add
	3'b001: Result = A - B;//sub
	3'b010: Result = A && B; //AND
	3'b011: Result = A || B;//OR
	3'b101: Result = //SLT
	
	defalut: Result = 3'bxxx
	
endmodule