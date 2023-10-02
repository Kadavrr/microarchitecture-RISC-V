`ifndef REGFILE
`define REGFILE
module RegisterFile #(
	parameter ADDR_WIDTH = 5,
	parameter DATA_WIDTH = 32)
(
	input logic [ADDR_WIDTH-1:0] ADDR1, ADDR2, ADDR3,
	input logic [ADDR_WIDTH-1:0] ADDR4, ADDR5, ADDR6,
	input logic [DATA_WIDTH-1:0] WD3, WD6,
	input logic clk,
	input logic WE3, WE6,
	output logic [DATA_WIDTH-1:0] RD1, RD2, RD4, RD5);
	
logic [DATA_WIDTH-1:0] memory [2**ADDR_WIDTH];
logic [DATA_WIDTH-1:0] read_data1;
logic [DATA_WIDTH-1:0] read_data2;
logic [DATA_WIDTH-1:0] read_data4;
logic [DATA_WIDTH-1:0] read_data5;

always_ff @(posedge clk) begin
	read_data1 <= memory[ADDR1];
	read_data2 <= memory[ADDR2];
	read_data4 <= memory[ADDR4];
	read_data5 <= memory[ADDR5];
	end

always_ff @ (negedge clk) begin
	if (WE3 && ADDR3 != 0) begin
		memory[ADDR3] <= WD3;
		end
	else if (WE6 && ADDR6 != 0) begin
		memory[ADDR6] <= WD6;
		end
	end
	
assign RD1 = read_data1;
assign RD2 = read_data2;
assign RD4 = read_data4;
assign RD5 = read_data5;

endmodule
`endif	