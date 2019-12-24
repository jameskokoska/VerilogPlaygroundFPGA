module seg7(input [3:0]C, output [6:0]HEX);
	assign HEX[0] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & ~C[1]  & ~C[0]) | (C[3] & ~C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & C[0]));
	assign HEX[1] = ((~C[3] & C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & C[1] & ~C[0]) | (C[3] & ~C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & ~C[0]) | (C[3] & C[2] & C[1] & ~C[0]) | (C[3] & C[2] & C[1] & C[0]));
	assign HEX[2] = ((~C[3] & ~C[2] & C[1] & ~C[0]) | (C[3] & C[2] & ~C[1] & ~C[0]) | (C[3] & C[2] & C[1] & ~C[0]) | (C[3] & C[2] & C[1] & C[0]));
	assign HEX[3] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & ~C[1] & ~C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & ~C[2] & ~C[1] & C[0]) | (C[3] & ~C[2] & C[1] & ~C[0]) | (C[3] & C[2] & C[1] & C[0]));
	assign HEX[4] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & ~C[2] & C[1] & C[0]) | (~C[3] & C[2] & ~C[1] & ~C[0]) | (~C[3] & C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & ~C[2] & ~C[1] & C[0]));
	assign HEX[5] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & ~C[2] & C[1] & ~C[0]) | (~C[3] & ~C[2] & C[1] & C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & C[0]));
	assign HEX[6] = ((~C[3] & ~C[2] & ~C[1] & ~C[0]) | (~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & ~C[0]));
endmodule

module dflipflop(d, q, clock, reset);
	input reset;
	input clock;
	input d;
	output reg q;
	always @(negedge reset, posedge clock)
	begin
		if(reset==0)
			q <= 1'b0;
		else
			q <= d;
	end
endmodule

module tflipflop(t, q, clock, reset);
	input t;
	output q;
	input clock;
	input reset;
	dflipflop dffIn(t^q, q, clock, reset);
endmodule

module counter4Bit(SW, KEY, HEX0, HEX1, LEDR);
	input [1:0]SW;
	input [1:0]KEY;
	output [6:0]HEX0, HEX1;
	output [9:0]LEDR;
	wire [7:0]numCount;
	assign enable = SW[1];
	assign clock = KEY[0];
	assign resetb = SW[0];
	wire [7:0]q;
	tflipflop u1(enable, q[0], clock, resetb);
	tflipflop u2(enable&q[0], q[1], clock, resetb);
	tflipflop u3(enable&q[0]&q[1], q[2], clock, resetb);
	tflipflop u4(enable&q[0]&q[1]&q[2], q[3], clock, resetb);
	tflipflop u5(enable&q[0]&q[1]&q[2]&q[3], q[4], clock, resetb);
	tflipflop u6(enable&q[0]&q[1]&q[2]&q[3]&q[4], q[5], clock, resetb);
	tflipflop u7(enable&q[0]&q[1]&q[2]&q[3]&q[4]&q[5], q[6], clock, resetb);
	tflipflop u8(enable&q[0]&q[1]&q[2]&q[3]&q[4]&q[5]&q[6], q[7], clock, resetb);
	
	seg7 display1(q[3:0],HEX0);
	seg7 display2(q[7:4],HEX1);
	
	assign LEDR[7:0]=q[7:0];
endmodule