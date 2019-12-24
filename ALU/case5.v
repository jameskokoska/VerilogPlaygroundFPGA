// case 5: Display the A switches in the most significant four bits of ALUout and the complement of the B 
// switches in the least-significant four bits without complementing the bits individually
module displaySwitch(A,B,C);
	input [3:0]A, B;
	output [7:0]C;
	assign C = {A,~B};
endmodule


module case5(SW, B, ALUOut);
	input [7:0]SW;
	input [7:0]B;
	output [7:0]ALUOut;
	
	displaySwitch C5(.A(SW[3:0]), .B(B[3:0]), .C(ALUOut));
endmodule
