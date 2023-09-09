module ALU #(
	parameter A_WIDTH = 32)
	
(	input logic [3:0] ALUControl,
	input logic signed [A_WIDTH-1:0] A, B,
	output logic [A_WIDTH-1:0] Result, 
	output logic [3:0] Flags);
	
	always_comb begin
	logic Negative, Zero, Carry, Overflow;
	case (ALUControl)
		4'b0000: Result = A + B; //ADD
		4'b0001: Result = A - B;//SUB
		4'b0010: Result = A && B; //AND
		4'b0011: Result = A || B;//OR
		4'b0101: Result = unsigned(A) < unsigned(B); //SLT
		4'b0110: Result = A << B; //SLL
		4'b0111: Result = A >> B; //SRL
		4'b1000: Result = A ^ B; //XOR
		4'b1001: Result = A < B; //SLTU
		default: Result = 4'bxxx;
	endcase
	
	Zero = ~&Result;
	Negative = Result[A_WIDTH-1];
	if ((A>0 && B>0 && A+B<0) || (A<0 && B<0 && A+B>0)) Overflow = 1'b1;
	else Overflow = 0;
	//((A>0 && A+B<0) || (A<0 && A+B>0)) && (A * B >= 0)
	//(A>0 && B>0 && A+B<0) || (A<0 && B<0 && A+B>0)
	if (Result>32'hFFFFFFFF) Carry = 1'b1;
	else Carry = 1'b0;
	Flags = {Negative, Zero, Carry, Overflow};
	end 
 
endmodule