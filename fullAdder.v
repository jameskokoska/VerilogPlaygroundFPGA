module FA(a,b,cin,s,cout);
	input a,b,cin;
	output s,cout;
	assign s=cin^b^a;
	assign cout=(b&a)|(cin&b)|(cin&a);
endmodule

module fullAdder(SW, LEDR);
	input [9:0]SW;
	output [9:0]LEDR;
	wire C1, C2, C3;
	FA Bit0(SW[4],SW[0],SW[8],LEDR[0],C1);
	FA Bit1(SW[5],SW[1],C1,LEDR[1],C2);
	FA Bit2(SW[6],SW[2],C2,LEDR[2],C3);
	FA Bit3(SW[7],SW[3],C3,LEDR[3],LEDR[9]);
endmodule
