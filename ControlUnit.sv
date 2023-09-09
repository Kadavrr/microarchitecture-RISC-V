module ControlUnit
(	input logic [6:0] op, [14:12] funct3, [31:25] funct7,
	output logic RegWriteD, ResultSrcD, MemWriteD,
	output logic JumpD, BranchD, [3:0] ALUControlD, ALUSrcD, ImmSrcD);

	always_comb
	AllControlSignals = {RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, [2:0] ALUControlD, ALUSrcD, ImmSrcD};
	case(op)
		7'b0110011: 
						case(func7) //R-Instructions
							7'b0: case(func3):
										3'b000: ALUControlD = 4'b0000; //ADD
										        ALUSrcD = 0;
												  ResultSrcD = 00;
												  RegWriteD = 1; 
										3'b001: ALUControlD = 4'b0110; //SLL
										3'b010: ALUControlD = 4'b0101; //SLT
										3'b011: ALUControlD = 4'b1001; //SLTU
										3'b100: ALUControlD = 4'b1000; //XOR
										3'b101: ALUControlD = 4'b0111; //SRL
										3'b110: ALUControlD = 4'b0011; //OR
										3'b111: ALUControlD = 4'b0010; //AND
										default: AllControlSignals = 10'bx;
										endcase
							7'b0100000: case(funct3)
											   3'b000: ALUControlD = 4'b0001; //SUB
												3'b101: ALUControlD = 4'b0000; //SRA
												default: AllControlSignals = 10'bx;
											endcase
							endcase
		7'b0010011: ImmSrcD = 3'b001;
						case(funct3) //I-Instructions
							3'b000: //ADDI
							3'b001: //SLLI
							3'b010: //SLTI
							3'b011: //SLTIU
							3'b100: //XORI
							3'b101: case(funct7)
										  7'b0100000: //SRAI
										  7'b0000000: //SRLI
										  default: AllControlSignals = 10'bx;
										endcase
							3'b110: //ORI
							3'b111: //ANDI
							default: AllControlSignals = 10'bx;
							endcase
		7'b0100011:ImmSrcD = 3'b010;
						case(funct3) //S-Instructions
							3'b000: //SB
							3'b001: //SH
							3'b010: //SW
							default: AllControlSignals = 10'bx;
						endcase
		7'b1100011: ImmSrcD = 3'b011;
						case(funct3) //B-Instructions
							3'b000: //BEQ
							3'b001: //BNE
							3'b100: //BLT
							3'b101: //BGE
							3'b110: //BLTU
							3'b111: //BGEU
							default: AllControlSignals = 10'bx;
						endcase
		7'b0000011: ImmSrcD = 3'b001; //I-Instructions
						case(funct3)
							3'b000: //LB
							3'b001: //LH
							3'b100: //LBU
							3'b101: //LHU
							default: AllControlSignals = 10'bx;
						endcase
		7'b0110111: ImmSrcD = 3'b100; //LUI U-Instruction
		7'b0010111: ImmSrcD = 3'b100; //AUIPC U-Instruction
		7'b1101111: ImmSrcD = 3'b101; //JAL J-Instruction
		7'b1100111: ImmSrcD = 3'b001; //JALR I-Instruction
		default: AllControlSignals = 10'bx; //all control signals must be X
		endcase
					
						
						
endmodule