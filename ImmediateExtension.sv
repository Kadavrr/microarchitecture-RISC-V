`ifndef IMMEXT
`define IMMEXT
module ImmediateExtension(
	input logic [2:0] SrcExt,
	input logic [31:7] Imm, 
	output logic [31:0] ImmExt);
	
always_comb begin 
	case(SrcExt)
		3'b001: begin
					ImmExt[31:12] = Imm[31];
					ImmExt[11:0] = Imm[31:20]; // I-Instructions
				  end
			
		3'b010: begin
					ImmExt[31:12] = Imm[31];
					ImmExt[11:0] = {Imm[31:25], Imm[11:7]}; //S-Instructions
			     end
		3'b011: begin
					ImmExt[31:13] = Imm[31];
					ImmExt[12:0] = {Imm[31], Imm[7], Imm[30:25], Imm[11:8], 1'b0}; //B-Instructions
			     end
			  
		3'b100: ImmExt[31:0] = {Imm[31:12], 12'b0};	//U-Instructions
		3'b101: begin
					ImmExt[31:21] = Imm[20];
					ImmExt[20:0] = {Imm[30:21], Imm[20], Imm[19:12], Imm[31]};//J-Instruction
				end
		3'b110: begin
					ImmExt[31:12] = Imm[31];
					ImmExt[11:0] = {7'b0, Imm[24:20]};    //I-Instructions (slli, srli, srai)
				  end
		default: ImmExt[31:0] = 32'bx;
	endcase
end

endmodule
`endif