`timescale 1ns / 1ns // `timescale time_unit/time_precision

module mux6to1(input Input0,Input1,Input2,Input3,Input4,Input5,Input6,MuxSelect0,MuxSelect1,MuxSelect2, output reg Out);
	
	
	always @(*) // declare always block
	begin
		case ({MuxSelect0,MuxSelect1,MuxSelect2}) // start case statement
			3'b000: Out = Input0;// case 0
			3'b001: Out = Input1;// case 1
			3'b010: Out = Input2;// case 2
			3'b011: Out = Input3;// case 3
			3'b100: Out = Input4; // case 4
			3'b101: Out = Input5; // case 5
			default: Out = Input0; // default case
		endcase
	end
endmodule

module caseStatement(SW, LEDR);
	input [9:0]SW;
	output [9:0]LEDR;
	
	mux6to1 mux1(SW[0], SW[1], SW[2], SW[3], SW[4], SW[5], SW[6], SW[7], SW[8], SW[9], LEDR[0]);
endmodule
