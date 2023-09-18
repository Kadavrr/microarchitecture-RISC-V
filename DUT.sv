module DUT(
	input clk,
	input [31:0] WD);
	RISCVConv cpu(.clk(clk),
					  .WD(WD));
endmodule