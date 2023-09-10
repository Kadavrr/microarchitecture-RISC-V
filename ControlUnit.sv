module ControlUnit
(	input logic [6:0] op, [14:12] funct3, [31:25] funct7,
	output logic RegWriteD, ResultSrcD, MemWriteD,
	output logic JumpD, BranchD, [3:0] ALUControlD, ALUSrcD, ImmSrcD
	output logic [1:0] StoreSrcD, [2:0] TypeBranchD, [2:0] LoadPartD
	output logic ALUSrcAD, SumSrcD);
	//DataSrcD is needed to indicate a part of the word

	always_comb
	AllControlSignals = {RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, [2:0] ALUControlD, ALUSrcD, ImmSrcD,
								[1:0] StoreSrcD, [2:0] TypeBranchD, [2:0] LoadPartD, ALUSrcAD, SumSrcD};
	case(op)
		7'b0110011: ALUSrcD = 0; //R-Instructions
					   ResultSrcD = 00;
						RegWriteD = 1;
						MemwriteD = 0;
						JumpD = 0;
						BranchD = 0;
						ImmSrcD = 0;
						StoreSrcD = 00;	
						LoadPartD = 3'b000;
						ALUSrcAD = 0;
						SumSrcD = 0;
						case(func7) 
							7'b0:	case(func3):
										3'b000: ALUControlD = 4'b0000; //ADD
										3'b001: ALUControlD = 4'b0110; //SLL
										3'b010: ALUControlD = 4'b0101; //SLT
										3'b011: ALUControlD = 4'b1001; //SLTU
										3'b100: ALUControlD = 4'b1000; //XOR
										3'b101: ALUControlD = 4'b0111; //SRL
										3'b110: ALUControlD = 4'b0011; //OR
										3'b111: ALUControlD = 4'b0010; //AND
										default: AllControlSignals = 17'bx;
										endcase
							7'b0100000: case(funct3)
											   3'b000: ALUControlD = 4'b0001; //SUB
												3'b101: ALUControlD = 4'b1010; //SRA
												default: AllControlSignals = 17'bx;
											endcase
							endcase
		7'b0010011: ImmSrcD = 3'b001; //I-Instructions
						ALUSrcD = 1;
					   ResultSrcD = 00;
						RegWriteD = 1;
						MemwriteD = 0;
						JumpD = 0;
						BranchD = 0;
						StoreSrcD = 00;
						LoadPartD = 3'b000;
						ALUSrcAD = 0;
						SumSrcD = 0;
						case(funct3) 
							3'b000: ALUControlD = 4'b0000; //ADDI
							3'b001: ALUControlD = 4'b0110; //SLLI
							3'b010: ALUControlD = 4'b0101; //SLTI
							3'b011: ALUControlD = 4'b1001; //SLTIU
							3'b100: ALUControlD = 4'b1000; //XORI
							3'b101: case(funct7)
										  7'b0100000: ALUControlD = 4'b1010; //SRAI
										  7'b0000000: ALUControlD = 4'b0111; //SRLI
										  default: AllControlSignals = 17'bx;
									  endcase
							3'b110: ALUControlD = 4'b0011; //ORI
							3'b111: ALUControlD = 4'b0010; //ANDI
							default: AllControlSignals = 17'bx;
							endcase
		7'b0100011: ImmSrcD = 3'b010; //S-Instructions
						ALUSrcD = 1;
						ResultSrcD = 00;
						RegWriteD = 0;
						MemWriteD = 1;
						JumpD = 0;
						BranchD = 0;
						ALUControlD = 4'b0000;
						LoadPartD = 3'b000;
						ALUSrcAD = 0;
						SumSrcD = 0;
					   case(funct3) 
					      3'b000: StoreSrcD = 2'b10; //SB
						   3'b001: StoreSrcD = 2'b01;//SH
						   3'b010: StoreSrcD = 2'b00;//SW
						   default: AllControlSignals = 17'bx;
					   endcase
		7'b1100011: ImmSrcD = 3'b011; //B-Instructions
						ALUSrcD = 1;
						ResultSrcD = 00;
						RegWriteD = 0;
						MemWriteD = 0;
						JumpD = 0;
						BranchD = 1;
						StoreSrcD = 2'b00;
						LoadPartD = 3'b000;
						ALUSrcAD = 0;
						SumSrcD = 0;
						case(funct3) 
							3'b000: TypeBranchD = 3'b000; //BEQ
									  ALUControlD = 4'b0000;
							3'b001: TypeBranchD = 3'b001; //BNE
									  ALUControlD = 4'b0000;
							3'b100: TypeBranchD = 3'b100; //BLT
									  ALUControlD = 4'b0101;
							3'b101: TypeBranchD = 3'b101; //BGE
									  ALUControlD = 4'b0101;
							3'b110: TypeBranchD = 3'b110; //BLTU
									  ALUControlD = 4'b1001;
							3'b111: TypeBranchD = 3'b111; //BGEU
									  ALUControlD = 4'b1001;
							default: AllControlSignals = 17'bx;
						endcase
		7'b0000011: ImmSrcD = 3'b001; //I-Instructions
						ALUSrcD = 1;
						ALUControlD = 4'b0000;
						ResultSrcD = 01;
						MemWriteD = 0;
						RegWrite = 1;
						JumpD = 0;
						BranchD = 0;
						StoreSrcD = 2'b00;
						TypeBranchD = 3'b000;
						ALUSrcAD = 0;
						SumSrcD = 0;
						case(funct3)
							3'b000: LoadPartD = 3'b000; //LB
							3'b001: LoadPartD = 3'b001; //LH
							3'b010: LoadPartD = 3'b010; //LW
							3'b100: LoadPartD = 3'b100; //LBU
							3'b101: LoadPartD = 3'b101; //LHU
							default: AllControlSignals = 17'bx;
						endcase
		7'b0110111: ImmSrcD = 3'b100; //LUI U-Instruction
						ALUControlD = 4'b1011;
						ALUSrcD = 1;
						ResultSrcD = 00;
						MemWriteD = 0;
						RegWrite = 1;
						JumpD = 0;
						BranchD = 0;
						StoreSrcD = 2'b00;
						TypeBranchD = 3'b000;
						LoadPartD = 3'b000;
						ALUSrcAD = 0;
						SumSrcD = 0;
		7'b0010111: ImmSrcD = 3'b100; //AUIPC U-Instruction
						ALUSrcAD = 1;
						ALUControlD = 4'b1100;
						ResultSrcD = 00;
						MemWriteD = 0;
						RegWrite = 1;
						JumpD = 0;
						BranchD = 0;
						StoreSrcD = 2'b00;
						TypeBranchD = 3'b000;
						LoadPartD = 3'b000;
						SumSrcD = 0;
		7'b1101111: ImmSrcD = 3'b101; //JAL J-Instruction
						JumpD = 1;
						ALUControlD = 4'b0000;
						ALUSrcD = 1;
						ALUSrcAD = 0;
						ResultSrcD = 10;
						MemWriteD = 0;
						RegWrite = 1;
						BranchD = 0;
						StoreSrcD = 00;
						TypeBranchD = 3'b000;
						LoadPartD = 3'b000;
						SumSrcD = 0;
		7'b1100111: ImmSrcD = 3'b001; //JALR I-Instruction
						JumpD = 1;
						ALUControlD = 4'b0000;
						ALUSrcD = 1;
						ALUSrcAD = 0;
						ResultSrcD = 10;
						MemWriteD = 0;
						RegWrite = 1;
						BranchD = 0;
						StoreSrcD = 00;
						TypeBranchD = 3'b000;
						LoadPartD = 3'b000;
						SumSrcD = 1;
		default: AllControlSignals = 17'bx; //all control signals must be X
		endcase
					
						
						
endmodule