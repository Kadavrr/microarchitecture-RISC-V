module BranchUnit(
		input logic [2:0] TypeBranchE,
		input logic BranchE,
		input logic ZeroE,
		output logic NeedBranchE);
		
		always_comb begin
		logic ConditionIsMet;
		case (TypeBranchE)
			3'b000: if(ZeroE == 1) BranchE = 1;
						else BranchE = 0;
			3'b001:if(ZeroE == 0) BranchE = 1;
						else BranchE = 0;
			3'b100:if(ALUResultE == 1) BranchE = 1;
						else BranchE = 0;
			3'b101:if(ALUResultE == 0) BranchE = 1;
						else BranchE = 0;
			3'b110:if(ALUResultE == 1) BranchE = 1;
						else BranchE = 0;
			3'b111:if(ALUResultE == 0) BranchE = 1;
						else BranchE = 0;
			default: BranchE = 1'bx;
		
		endcase
		and(NeedBeanchE, ConditionIsMet, BranchE)
		end
			
		
endmodule