module seg7(input [3:0]C, output [6:0]HEX);
	assign HEX[0] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & ~C[1]  & ~C[0]) | (C[3] & ~C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & C[0]));
	assign HEX[1] = ((~C[3] & C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & C[1] & ~C[0]) | (C[3] & ~C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & ~C[0]) | (C[3] & C[2] & C[1] & ~C[0]) | (C[3] & C[2] & C[1] & C[0]));
	assign HEX[2] = ((~C[3] & ~C[2] & C[1] & ~C[0]) | (C[3] & C[2] & ~C[1] & ~C[0]) | (C[3] & C[2] & C[1] & ~C[0]) | (C[3] & C[2] & C[1] & C[0]));
	assign HEX[3] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & ~C[1] & ~C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & ~C[2] & ~C[1] & C[0]) | (C[3] & ~C[2] & C[1] & ~C[0]) | (C[3] & C[2] & C[1] & C[0]));
	assign HEX[4] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & ~C[2] & C[1] & C[0]) | (~C[3] & C[2] & ~C[1] & ~C[0]) | (~C[3] & C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & ~C[2] & ~C[1] & C[0]));
	assign HEX[5] = ((~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & ~C[2] & C[1] & ~C[0]) | (~C[3] & ~C[2] & C[1] & C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & C[0]));
	assign HEX[6] = ((~C[3] & ~C[2] & ~C[1] & ~C[0]) | (~C[3] & ~C[2] & ~C[1] & C[0]) | (~C[3] & C[2] & C[1] & C[0]) | (C[3] & C[2] & ~C[1] & ~C[0]));
endmodule

module countern(clock, enable, q, reset);
	parameter n=4;
	input clock, enable, reset;
	output reg [n-1:0] q;			
	always @(posedge clock, negedge reset)
		begin	
			if (!reset)
				q <= 0;
			else if (enable) 
				q <= q + 1;
		end
endmodule

module counterRateDivider(clock, r, q, reset);
	parameter n=27;
	input clock;
	input [n-1:0]r;
	input reset;
	output reg [n-1:0] q;
	always @(posedge clock, negedge reset)
		begin
			if (!reset)
				q <= 0;
			else if (q == 27'b000000000000000000000000000)		
				q <= r;
			else 
				q <= q - 1;				
		end
endmodule

module muxey(switch, speedOut);
	input [1:0]switch;
	wire [26:0]speed1 = 27'b000000000000000000000000001;
	wire [26:0]speed2 = 27'b001011111010111100000111111;
	wire [26:0]speed3 = 27'b010111110101111000001111111;
	wire [26:0]speed4 = 27'b101111101011110000011111111;
	output reg [26:0]speedOut;
	always @(*)
		begin
			case (switch[1:0])
				2'b00: speedOut = speed1;
				2'b01: speedOut = speed2;
				2'b10: speedOut = speed3;
				2'b11: speedOut = speed4;
			endcase
	end
endmodule

module variableAutoCount(HEX0, SW, CLOCK_50);
	input CLOCK_50;
	wire [26:0]q;
	wire [3:0]counterOut;
	output [6:0]HEX0;
	input [2:0]SW;
	wire [26:0]speedOut;
	
	muxey u1(SW, speedOut);
	counterRateDivider dcount(CLOCK_50,speedOut,q,SW[2]);
	assign enable = (q == 0)?1:0;
	countern ucount(CLOCK_50, enable, counterOut,SW[2]);
	seg7 display(counterOut, HEX0);
	
endmodule