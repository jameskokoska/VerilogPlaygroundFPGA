// case 2: A XNOR B in the lower four bits of ALUout and A NAND B in the upper four bits
module XNORNAND(A,B,C);
	input [3:0]A, B;
	output [7:0]C;
	assign C = {~(A&B), ~(A^B)};
endmodule

module case2(SW, B, ALUOut);
	input [7:0]SW;
	input [3:0]B;
	output [7:0]ALUOut;
		
	XNORNAND c3(.A(SW[3:0]), .B(B[3:0]), .C(ALUOut));
endmodule
