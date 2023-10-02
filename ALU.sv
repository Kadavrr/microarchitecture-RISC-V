`ifndef ALU
`define ALU
module ALU(	
	input logic [3:0] ALUControl,
	input logic [31:0] A, B,
	output logic [31:0] Result, 
	output logic [3:0] Flags);
	
	always_comb begin
	logic Negative, Zero, Carry, Overflow;
	case (ALUControl)
		4'b0000: Result = A + B; //ADD
		4'b0001: Result = A - B;//SUB
		4'b0010: Result = A && B; //AND
		4'b0011: Result = A || B;//OR
		4'b0101: Result = $signed(A) < $signed(B); //SLT
		4'b0110: Result = A << B; //SLL
		4'b0111: Result = A >> B; //SRL
		4'b1000: Result = A ^ B; //XOR
		4'b1001: Result = A < B; //SLTU
		4'b1010: Result = A <<< B; //SRA
		4'b1011: Result = B << 12;//LUI
		4'b1100: Result = A + (B << 12); //AUIPC
		default: Result = 4'bxxx;
	endcase
	
	Zero = ~&Result;
	
	Negative = Result[31];
	
	if ((A>0 && B>0 && A+B<0) || (A<0 && B<0 && A+B>0)) Overflow = 1'b1; //((A>0 && A+B<0) || (A<0 && A+B>0)) && (A * B >= 0)
		else Overflow = 0;
	
	
	if (Result>32'hFFFFFFFF) Carry = 1'b1;
		else Carry = 1'b0;
		
		
	Flags = {Negative, Zero,  Carry, Overflow};
	
	end 
 
endmodule
`endif