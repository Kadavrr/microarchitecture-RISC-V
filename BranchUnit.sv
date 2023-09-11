module BranchUnit(
		input logic [2:0] TypeBranchE,
		input logic BranchE,
		input logic ZeroE,
		input logic ALUResultE,
		output logic NeedBranchE);
		
		always_comb begin
		logic ConditionIsMet;
		case (TypeBranchE)
			3'b000: if(ZeroE == 1) NeedBranchE = 1;
						else NeedBranchE = 0;
			3'b001:if(ZeroE == 0) NeedBranchE = 1;
						else NeedBranchE = 0;
			3'b100:if(ALUResultE == 1) NeedBranchE = 1;
						else NeedBranchE = 0;
			3'b101:if(ALUResultE == 0) NeedBranchE = 1;
						else NeedBranchE = 0;
			3'b110:if(ALUResultE == 1) NeedBranchE = 1;
						else NeedBranchE = 0;
			3'b111:if(ALUResultE == 0) NeedBranchE = 1;
						else NeedBranchE = 0;
			default: NeedBranchE = 1'bx;
		
		endcase
		AND(NeedBranchE, ConditionIsMet, BranchE);
		end
	
		
			
		
endmodule