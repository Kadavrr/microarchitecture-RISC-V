module ALU #(
	parameter A_WIDTH = 32)
	
(	input logic [2:0] ALUControl,
	input logic [A_WIDTH-1:0] A, B,
	output logic [A_WIDTH-1:0] Result, 
	output logic [3:0] Flags);
	
	always_comb begin
	case (ALUControl)
	3'b000: Result = A + B; //add
	3'b001: Result = A - B;//sub
	3'b010: Result = A && B; //AND
	3'b011: Result = A || B;//OR
	3'b101: Result = A < B; //SLT
	defalut: Result = 3'bxxx;
	endcase
	
	logic Negative, Zero, Carry, Overflow;
	
	Zero = ~&Result;
	Negative = Result[A_WIDTH-1];
	if (((A>0 && A+B<0) || (A<0 && A+B>0)) && (A * B >= 0)) Overflow = 1'b1;
	else Overflow = 0;
	//I dont know which option is better (probably without multiplication)
	//((A>0 && A+B<0) || (A<0 && A+B>0)) && (A * B >= 0)
	//(A>0 && B>0 && A+B<0) || (A<0 && B<0 && A+B>0)
	if (Result > 0xFFFFFFFF) Carry = 1'b1;
	else Carry = 0;
	Flag = {Negative, Zero, Carry, Overflow};
	
	end 
 
endmodule