module ram(SW, KEY, HEX0, HEX2, HEX4, HEX5);
	input [9:0]SW;
	input [1:0]KEY;
	output [6:0]HEX0, HEX2, HEX4, HEX5;
	wire [3:0]wdata;
	ram32x4 mem(SW[8:4], KEY[0], SW[3:0], SW[9], wdata);
	seg7 dispaddress1(SW[7:4], HEX4);
	seg7 dispaddress2(SW[8], HEX5);
	seg7 dispinput(SW[3:0], HEX2);
	seg7 dispoutput(wdata, HEX0);
endmodule

module seg7(input [3:0]C, output [6:0]HEX);
	assign HEX[0] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & ~C[1]  & ~C[0]) | (C[3] & ~C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & C[0]));
	assign HEX[1] = ((~C[3] & C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & C[1] & ~C[0]) | (C[3] & ~C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & ~C[0]) | (C[3] & C[2] & C[1] & ~C[0]) | (C[3] & C[2] & C[1] & C[0]));
	assign HEX[2] = ((~C[3] & ~C[2] & C[1] & ~C[0]) | (C[3] & C[2] & ~C[1] & ~C[0]) | (C[3] & C[2] & C[1] & ~C[0]) | (C[3] & C[2] & C[1] & C[0]));
	assign HEX[3] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & ~C[1] & ~C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & ~C[2] & ~C[1] & C[0]) | (C[3] & ~C[2] & C[1] & ~C[0]) | (C[3] & C[2] & C[1] & C[0]));
	assign HEX[4] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & ~C[2] & C[1] & C[0]) | (~C[3] & C[2] & ~C[1] & ~C[0]) | (~C[3] & C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & ~C[2] & ~C[1] & C[0]));
	assign HEX[5] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & ~C[2] & C[1] & ~C[0]) | (~C[3] & ~C[2] & C[1] & C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & C[0]));
	assign HEX[6] = ((~C[3] & ~C[2] & ~C[1] & ~C[0]) | (~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & ~C[0]));
endmodule