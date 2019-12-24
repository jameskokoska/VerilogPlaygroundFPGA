//Defines the seg7 display and the logic for when each led should be lit based on the input\s
module seg7(input [3:0]C, output [6:0]HEX);
	assign HEX[0] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & ~C[1]  & ~C[0]) | (C[3] & ~C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & C[0]));
	assign HEX[1] = ((~C[3] & C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & C[1] & ~C[0]) | (C[3] & ~C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & ~C[0]) | (C[3] & C[2] & C[1] & ~C[0]) | (C[3] & C[2] & C[1] & C[0]));
	assign HEX[2] = ((~C[3] & ~C[2] & C[1] & ~C[0]) | (C[3] & C[2] & ~C[1] & ~C[0]) | (C[3] & C[2] & C[1] & ~C[0]) | (C[3] & C[2] & C[1] & C[0]));
	assign HEX[3] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & ~C[1] & ~C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & ~C[2] & ~C[1] & C[0]) | (C[3] & ~C[2] & C[1] & ~C[0]) | (C[3] & C[2] & C[1] & C[0]));
	assign HEX[4] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & ~C[2] & C[1] & C[0]) | (~C[3] & C[2] & ~C[1] & ~C[0]) | (~C[3] & C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & ~C[2] & ~C[1] & C[0]));
	assign HEX[5] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & ~C[2] & C[1] & ~C[0]) | (~C[3] & ~C[2] & C[1] & C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & C[0]));
	assign HEX[6] = ((~C[3] & ~C[2] & ~C[1] & ~C[0]) | (~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & ~C[0]));
endmodule

module seg7display(SW, ALUOut, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
	input [9:0]SW;
	input [7:0]ALUOut;
	output [6:0]HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [7:0]LEDR;

	seg7 hex0(.C(SW[3:0]), .HEX(HEX0[6:0]));
	seg7 hex1(.C(4'b0000), .HEX(HEX1[6:0]));
	seg7 hex2(.C(4'b0000), .HEX(HEX2[6:0]));
	seg7 hex3(.C(4'b0000), .HEX(HEX3[6:0]));
	seg7 hex4(.C(ALUOut[3:0]), .HEX(HEX4[6:0]));
	seg7 hex5(.C(ALUOut[7:4]), .HEX(HEX5[6:0]));
	assign LEDR=ALUOut;
endmodule
