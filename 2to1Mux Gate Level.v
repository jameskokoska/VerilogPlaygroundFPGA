`timescale 1ns / 1ns // `timescale time_unit/time_precision

//OR gate, output pin assigned 1 if one of 2 inputs is 1
module V7432 (input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13, output pin3, pin6, pin8, pin11);
	
	assign pin3= pin1 | pin2;
	assign pin6= pin4 | pin5;
	assign pin8= pin9 | pin10;
	assign pin11= pin12 | pin13;
	
endmodule

//AND gate, output pin is 1 if both inputs are 1
module V7408 (input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13, output pin3, pin6, pin8, pin11);
	
	assign pin3=pin1 & pin2;
	assign pin6=pin4 & pin5;
	assign pin8=pin9 & pin10;
	assign pin11=pin12 & pin13;
	
endmodule

//Output is the inversion of the input
module V7404 (input pin1, pin3, pin5, pin9, pin11, pin13, output pin2, pin4, pin6, pin8, pin10, pin12);
	
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;
	
endmodule

module muxGates(SW, LEDR);
	input [2:0] SW;
	output [9:0] LEDR;
	wire w1, w2, w3;
	
	V7404 U1(.pin1(SW[2]), .pin2(w1));
	V7408 U2(.pin1(SW[0]), .pin2(w1), .pin3(w2));
	V7408 U3(.pin4(SW[2]), .pin5(SW[1]), .pin6(w3));
	V7432 U4(.pin1(w2), .pin2(w3), .pin3(LEDR[0]));
	
endmodule