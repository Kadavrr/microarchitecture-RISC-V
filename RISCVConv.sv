`ifndef RISCVCONV
`define RISCVCONV
`include "Tract.sv"
`include "ConflictPreventionUnit.sv"
module RISCVConv(
	input logic clk,
	input logic [31:0] WD,
	input logic ControlSignal);
	
	logic StallF, StallD, FlushD, FlushE;
	logic ForwardAE, ForwardBE;
	logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE;
	logic	RegWriteM;
	logic PCSrcE, ResultSrcE0, RdM, RdW, RegWriteW;
	
	Tract tract(.clk(clk),
          .WD(WD),
          .StallF(StallF),
          .StallD(StallD),
          .FlushD(FlushD),
          .FlushE(FlushE),
          .ForwardAE(ForwardAE),
          .ForwardBE(ForwardBE),
          .Rs1D(Rs1D),
          .Rs2D(Rs2D),
          .Rs1E(Rs1E),
          .Rs2E(Rs2E),
          .RdE(RdE),
          .RegWriteM(RegWriteM),
          .PCSrcE(PCSrcE),
          .ResultSrcE0(ResultSrcE0),
          .RdM(RdM),
          .RdW(RdW),
          .RegWriteW(RegWriteW),
			 .ControlSignal(ControlSignal));
			 
	ConflictPreventionUnit confpu (.Rs1D(Rs1D),
											 .Rs2D(Rs2D),
											 .Rs1E(Rs1E),
											 .Rs2E(Rs2E),
											 .PCSrcE(PCSrcE),
											 .ResultSrcE0(ResultSrcE0),
											 .RdE(RdE),
											 .RdM(RdM),
											 .RdW(RdW),
											 .RegWriteW(RegWriteW),
											 .RegWriteM(RegWriteM),
											 .StallF(StallF),
											 .StallD(StallD),
											 .FlushD(FlushD),
											 .FlushE(FlushE),
											 .ForwardAE(ForwardAE),
											 .ForwardBE(ForwardBE));
	
endmodule
`endif 