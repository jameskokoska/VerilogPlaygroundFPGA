module counterDown(clock, enable, q, reset);
	parameter n=25;
	input clock, enable, reset;
	output reg [n-1:0] q;
	always @(posedge clock, negedge reset)
		begin
			if (reset==0)
				q<=0;
			else if (q == 25'b0000000000000000000000000)		
				q <= 25'b1011111010111100000111111;
			else if(!reset) 
				q <= 25'b1011111010111100000111111;
			else if(enable)
				q<=q-1;
		end
endmodule
	

module shift13bit(d, clock, reset, load, shift, out);

	input [12:0]d;
	input clock, reset, load, shift;
	output out;
	reg [12:0]q;
	
	always @ (posedge clock,negedge reset)
	begin
		if(reset==0)
			q<=0;
		else if(!load)
			q<=d;
		else if(shift == 1) begin
			q[12]<=q[11];
			q[11]<=q[10];
			q[10]<=q[9];
			q[9]<=q[8];
			q[8]<=q[7];
			q[7]<=q[6];
			q[6]<=q[5];
			q[5]<=q[4];
			q[4]<=q[3];
			q[3]<=q[2];
			q[2]<=q[1];
			q[1]<=q[0];
			q[0]<=0;
		end
	end
		assign out=q[12];
endmodule


module muxey(switch, letterOut);
	input [2:0]switch;
	wire [12:0]letter1 = 13'b1010000000000;
	wire [12:0]letter2 = 13'b1011101110111;
	wire [12:0]letter3 = 13'b1110101110000;
	wire [12:0]letter4 = 13'b1011101010000;
	wire [12:0]letter5 = 13'b1110111000000;
	wire [12:0]letter6 = 13'b1110100000000;
	wire [12:0]letter7 = 13'b1110111011100;
	wire [12:0]letter8 = 13'b1011101110100;
	
	output reg [12:0]letterOut;
	always @(*)
		begin
			case (switch[2:0])
				3'b000: letterOut = letter1;
				3'b001: letterOut = letter2;
				3'b010: letterOut = letter3;
				3'b011: letterOut = letter4;
				3'b100: letterOut = letter5;
				3'b101: letterOut = letter6;
				3'b110: letterOut = letter7;
				3'b111: letterOut = letter8;
				default: letterOut = letter1;
			endcase
	end
endmodule

module morseCode(LEDR, SW, CLOCK_50, KEY);
	input CLOCK_50;
	output [9:0]LEDR;
	input [2:0]SW;
	wire [12:0]letterOut;
	input [1:0]KEY;
	wire [24:0]downout;
	wire q;
	muxey u1(SW,letterOut);
	counterDown u2(CLOCK_50, KEY[1], downout, KEY[0]);
	assign enable = (downout == 0)?1:0;
	shift13bit u3(letterOut, CLOCK_50, KEY[0], KEY[1], enable, q);
	assign LEDR[0] = q;
endmodule