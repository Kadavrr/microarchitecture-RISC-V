`ifndef BRANUNIT
`define BRANUNIT
module BranchUnit(
		input logic [2:0] TypeBranchE,
		input logic BranchE,
		input logic ZeroE,
		input logic [31:0] ALUResultE,
		output logic NeedBranchE);
		
		logic ConditionIsMet;
		always_comb
		case (TypeBranchE)
			3'b000: if(ZeroE == 1) ConditionIsMet = 1;
						else ConditionIsMet = 0;
			3'b001:if(ZeroE == 0) ConditionIsMet = 1;
						else ConditionIsMet = 0;
			3'b100:if(ALUResultE == 1) ConditionIsMet = 1;
						else ConditionIsMet = 0;
			3'b101:if(ALUResultE == 0) ConditionIsMet = 1;
						else ConditionIsMet = 0;
			3'b110:if(ALUResultE == 1) ConditionIsMet = 1;
						else ConditionIsMet = 0;
			3'b111:if(ALUResultE == 0) ConditionIsMet = 1;
						else ConditionIsMet = 0;
			default: ConditionIsMet = 1'bx;
		
		endcase
		and(NeedBranchE, ConditionIsMet, BranchE);
	
		
			
		
endmodule
`endif