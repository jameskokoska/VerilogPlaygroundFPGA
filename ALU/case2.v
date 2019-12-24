// case 2: A XNOR B in the lower four bits of ALUout and A NAND B in the upper four bits
module XNORNAND(A,B,C);
	input [3:0]A, B;
	output [7:0]C;
	assign C = {~(A&B), ~(A^B)};
endmodule

module case2(SW, ALUOut);
	input [7:0]SW;
	output [7:0]ALUOut;
		
	XNORNAND c3(.A(SW[3:0]), .B(SW[7:4]), .C(ALUOut));
endmodule
