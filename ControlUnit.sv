`ifndef CONTUNIT
`define CONTUNIT
module ControlUnit
(	input logic [6:0] op,
	input logic [14:12] funct3, 
	input logic [31:25] funct7,
	output logic RegWriteD, MemWriteD,
	output logic [1:0] ResultSrcD,
	output logic JumpD, BranchD, ALUSrcD,
	output logic [2:0] ImmSrcD,
	output logic [3:0] ALUControlD, 
	output logic [1:0] StoreSrcD, 
	output logic [2:0] TypeBranchD,
	output logic [2:0] LoadSrcD,
	output logic ALUSrcAD, SumSrcD, ControlSignal);
	//StoreSrcD and LoadSrcD is needed to indicate a part of the word
	
	always_comb
	case(op)
		7'b0110011: begin
						ALUSrcD = 0; //R-Instructions
					   ResultSrcD = 00;
						RegWriteD = 1;
						MemWriteD = 0;
						JumpD = 0;
						BranchD = 0;
						ImmSrcD = 0;
						StoreSrcD = 00;	
						LoadSrcD = 3'b000;
						ALUSrcAD = 0;
						SumSrcD = 0;
						TypeBranchD = 3'b000;
						case(funct7) 
							7'b0:	case(funct3)
										3'b000: begin
												  ALUControlD = 4'b0000; //ADD
												  ControlSignal = 1'b0;
												  end
										3'b001: begin 
												  ALUControlD = 4'b0110; //SLL
												  ControlSignal = 1'b0;
												  end
										3'b010: begin
												  ALUControlD = 4'b0101; //SLT
												  ControlSignal = 1'b0;
												  end
										3'b011: begin
												  ALUControlD = 4'b1001; //SLTU
												  ControlSignal = 1'b0;
												  end
										3'b100: begin
												  ALUControlD = 4'b1000; //XOR
												  ControlSignal = 1'b0;
												  end
										3'b101: begin
												  ALUControlD = 4'b0111; //SRL
												  ControlSignal = 1'b0;
												  end
										3'b110: begin
												  ALUControlD = 4'b0011; //OR
												  ControlSignal = 1'b0;
												  end
										3'b111: begin
												  ALUControlD = 4'b0010; //AND
												  ControlSignal = 1'b0;
												  end
										default: begin
													ALUControlD = 4'b0000;
													ControlSignal = 1'b1;
													end
										endcase
							7'b0100000: case(funct3)
											   3'b000: begin
														  ALUControlD = 4'b0001; //SUB
														  ControlSignal = 1'b0;
														  end
												3'b101: begin
														  ALUControlD = 4'b1010; //SRA
														  ControlSignal = 1'b0;
														  end
												default: begin
															ALUControlD = 4'b0000;
															ControlSignal = 1'b1;
															end
											endcase
							default: begin
										ALUControlD = 4'b0;
										ControlSignal = 1'b1;
										end
							endcase
						end
		7'b0010011: begin
						ImmSrcD = 3'b001; //I-Instructions
						ALUSrcD = 1;
					   ResultSrcD = 00;
						RegWriteD = 1;
						MemWriteD = 0;
						JumpD = 0;
						BranchD = 0;
						StoreSrcD = 00;
						LoadSrcD = 3'b000;
						ALUSrcAD = 0;
						SumSrcD = 0;
						TypeBranchD = 3'b000;
						case(funct3) 
							3'b000: begin
									  ALUControlD = 4'b0000; //ADDI
									  ControlSignal = 1'b0;
									  end
							3'b001: begin
									  ALUControlD = 4'b0110; //SLLI
									  ControlSignal = 1'b0;
									  end
							3'b010: begin
									  ALUControlD = 4'b0101; //SLTI
									  ControlSignal = 1'b0;
									  end
							3'b011: begin
									  ALUControlD = 4'b1001; //SLTIU
									  ControlSignal = 1'b0;
									  end
							3'b100: begin
									  ALUControlD = 4'b1000; //XORI
									  ControlSignal = 1'b0;
									  end
							3'b101: case(funct7)
										  7'b0100000: begin
														  ALUControlD = 4'b1010; //SRAI
														  ControlSignal = 1'b0;
														  end
										  7'b0000000: begin
														  ALUControlD = 4'b0111; //SRLI
														  ControlSignal = 1'b0;
														  end
										  default: begin
													  ALUControlD = 4'b0;
													  ControlSignal = 1'b1;
													  end
									  endcase
							3'b110: begin
									  ALUControlD = 4'b0011; //ORI
									  ControlSignal = 1'b0;
									  end
							3'b111: begin
									  ALUControlD = 4'b0010; //ANDI
									  ControlSignal = 1'b0;
									  end
							default: begin
										ALUControlD = 4'b0000;
										ControlSignal = 1'b1;
										end
							endcase
						end
		7'b0100011: begin
						ImmSrcD = 3'b010; //S-Instructions
						ALUSrcD = 1;
						ResultSrcD = 00;
						RegWriteD = 0;
						MemWriteD = 1;
						JumpD = 0;
						BranchD = 0;
						ALUControlD = 4'b0000;
						LoadSrcD = 3'b000;
						ALUSrcAD = 0;
						SumSrcD = 0;
						TypeBranchD = 3'b000;
					   case(funct3) 
					      3'b000: begin
									  StoreSrcD = 2'b10; //SB
									  ControlSignal = 1'b0;
									  end
						   3'b001: begin
									  StoreSrcD = 2'b01;//SH
									  ControlSignal = 1'b0;
									  end
						   3'b010: begin
									  StoreSrcD = 2'b00;//SW
									  ControlSignal = 1'b0;
									  end
						   default: begin
									   ControlSignal = 1'b1;
										StoreSrcD = 2'b00;
										end
					   endcase
						end
		7'b1100011: begin
						ImmSrcD = 3'b011; //B-Instructions
						ALUSrcD = 1;
						ResultSrcD = 00;
						RegWriteD = 0;
						MemWriteD = 0;
						JumpD = 0;
						BranchD = 1;
						StoreSrcD = 2'b00;
						LoadSrcD = 3'b000;
						ALUSrcAD = 0;
						SumSrcD = 0;
						case(funct3) 
							3'b000: begin
									  TypeBranchD = 3'b000; //BEQ
									  ALUControlD = 4'b0000;
									  ControlSignal = 1'b0;
									  end
							3'b001: begin
									  TypeBranchD = 3'b001; //BNE
									  ALUControlD = 4'b0000;
									  ControlSignal = 1'b0;
									  end
							3'b100: begin
									  TypeBranchD = 3'b100; //BLT
									  ALUControlD = 4'b0101;
									  ControlSignal = 1'b0;
									  end
							3'b101: begin
									  TypeBranchD = 3'b101; //BGE
									  ALUControlD = 4'b0101;
									  ControlSignal = 1'b0;
									  end
							3'b110: begin
									  TypeBranchD = 3'b110; //BLTU
									  ALUControlD = 4'b1001;
									  ControlSignal = 1'b0;
									  end
							3'b111: begin
									  TypeBranchD = 3'b111; //BGEU
									  ALUControlD = 4'b1001;
									  ControlSignal = 1'b0;
									  end
							default: begin
										TypeBranchD = 3'b000; 
									   ALUControlD = 4'b0000;
										ControlSignal = 1'b1;
										end
						endcase
						end
		7'b0000011: begin
						ImmSrcD = 3'b001; //I-Instructions
						ALUSrcD = 1;
						ALUControlD = 4'b0000;
						ResultSrcD = 01;
						MemWriteD = 0;
						RegWriteD = 1;
						JumpD = 0;
						BranchD = 0;
						StoreSrcD = 2'b00;
						TypeBranchD = 3'b000;
						ALUSrcAD = 0;
						SumSrcD = 0;
						case(funct3)
							3'b000: begin
									  LoadSrcD = 3'b000; //LB
									  ControlSignal = 1'b0;
									  end
							3'b001: begin
									  LoadSrcD = 3'b001; //LH
									  ControlSignal = 1'b0;
									  end
							3'b010: begin
									  LoadSrcD = 3'b010; //LW
									  ControlSignal = 1'b0;
									  end
							3'b100: begin
									  LoadSrcD = 3'b100; //LBU
									  ControlSignal = 1'b0;
									  end
							3'b101: begin
									  LoadSrcD = 3'b101; //LHU
									  ControlSignal = 1'b0;
									  end
							default: begin
										LoadSrcD = 3'bx;
										ControlSignal = 1'bx;
										end
						endcase
						end
		7'b0110111: begin
						ImmSrcD = 3'b100; //LUI U-Instruction
						ALUControlD = 4'b1011;
						ALUSrcD = 1;
						ResultSrcD = 00;
						MemWriteD = 0;
						RegWriteD = 1;
						JumpD = 0;
						BranchD = 0;
						StoreSrcD = 2'b00;
						TypeBranchD = 3'b000;
						LoadSrcD = 3'b000;
						ALUSrcAD = 0;
						SumSrcD = 0;
						ControlSignal = 0;
						end
		7'b0010111: begin
						ImmSrcD = 3'b100; //AUIPC U-Instruction
						ALUSrcAD = 1;
						ALUControlD = 4'b1100;
						ALUSrcD = 1;
						ResultSrcD = 00;
						MemWriteD = 0;
						RegWriteD = 1;
						JumpD = 0;
						BranchD = 0;
						StoreSrcD = 2'b00;
						TypeBranchD = 3'b000;
						LoadSrcD = 3'b000;
						SumSrcD = 0;
						ControlSignal = 0;
						end
		7'b1101111: begin
						ImmSrcD = 3'b101; //JAL J-Instruction
						JumpD = 1;
						ALUControlD = 4'b0000;
						ALUSrcD = 1;
						ALUSrcAD = 0;
						ResultSrcD = 2'b10;
						MemWriteD = 0;
						RegWriteD = 1;
						BranchD = 0;
						StoreSrcD = 00;
						TypeBranchD = 3'b000;
						LoadSrcD = 3'b000;
						SumSrcD = 0;
						ControlSignal = 0;
						end
		7'b1100111: begin 
						ImmSrcD = 3'b001; //JALR I-Instruction
						JumpD = 1;
						ALUControlD = 4'b0000;
						ALUSrcD = 1;
						ALUSrcAD = 0;
						ResultSrcD = 2'b10;
						MemWriteD = 0;
						RegWriteD = 1;
						BranchD = 0;
						StoreSrcD = 00;
						TypeBranchD = 3'b000;
						LoadSrcD = 3'b000;
						SumSrcD = 1;
						ControlSignal = 0;
						end
		default: begin
					ControlSignal = 1'bx; //all control signals must be X
					ImmSrcD = 3'bxxx; //JALR I-Instruction
					JumpD = 1'bx;
					ALUControlD = 4'bxxxx;
					ALUSrcD = 1'bx;
					ALUSrcAD = 1'bx;
					ResultSrcD = 2'bxx;
					MemWriteD = 1'bx;
					RegWriteD = 1'bx;
					BranchD = 1'bx;
					StoreSrcD = 2'bx;
					TypeBranchD = 3'bx;
					LoadSrcD = 3'bx;
					SumSrcD = 1'bx;
					end
		endcase
					
						
endmodule
`endif