// case 1 A + B using the Verilog ‘+’ operator
module operatoradd(A,B,C);
	input [3:0]A, B;
	output [7:0]C;
	assign C = {3'b000, (A+B)};
endmodule


module case1(SW, ALUOut);
	input [7:0]SW;
	output [7:0]ALUOut;
	
	operatoradd add1(.A(SW[3:0]), .B(SW[7:4]), .C(ALUOut));
endmodule
