//Defines the seg7 display and the logic for when each led should be lit based on the input\s
module seg7(input C0, C1, C2, C3, output LED0, LED1, LED2, LED3, LED4, LED5, LED6);
	assign LED0 = ((~C3 & ~C2 & ~C1 & C0) | (~C3 & C2 & ~C1  & ~C0) | (C3 & ~C2 & C1 & C0) | (C3 & C2 & ~C1 & C0));
	assign LED1 = ((~C3 & C2 & ~C1 & C0) | (~C3 & C2 & C1 & ~C0) | (C3 & ~C2 & C1 & C0) | (C3 & C2 & ~C1 & ~C0) | (C3 & C2 & C1 & ~C0) | (C3 & C2 & C1 & C0));
	assign LED2 = ((~C3 & ~C2 & C1 & ~C0) | (C3 & C2 & ~C1 & ~C0) | (C3 & C2 & C1 & ~C0) | (C3 & C2 & C1 & C0));
	assign LED3 = ((~C3 & ~C2 & ~C1 & C0) | (~C3 & C2 & ~C1 & ~C0) | (~C3 & C2 & C1 & C0) | (C3 & ~C2 & ~C1 & C0) | (C3 & ~C2 & C1 & ~C0) | (C3 & C2 & C1 & C0));
	assign LED4 = ((~C3 & ~C2 & ~C1 & C0) | (~C3 & ~C2 & C1 & C0) | (~C3 & C2 & ~C1 & ~C0) | (~C3 & C2 & ~C1 & C0) | (~C3 & C2 & C1 & C0) | (C3 & ~C2 & ~C1 & C0));
	assign LED5 = ((~C3 & ~C2 & ~C1 & C0) | (~C3 & ~C2 & C1 & ~C0) | (~C3 & ~C2 & C1 & C0) | (~C3 & C2 & C1 & C0) | (C3 & C2 & ~C1 & C0));
	assign LED6 = ((~C3 & ~C2 & ~C1 & ~C0) | (~C3 & ~C2 & ~C1 & C0) | (~C3 & C2 & C1 & C0) | (C3 & C2 & ~C1 & ~C0));
endmodule

//assign FPGA board switches and LEDs to our variables
module seg7Display (HEX0, SW);
	input [3:0]SW;
	output [6:0]HEX0;
	
	seg7 display(.C0(SW[3]), .C1(SW[2]), .C2(SW[1]), .C3(SW[0]), .LED0(HEX0[0]), .LED1(HEX0[1]), .LED2(HEX0[2]), .LED3(HEX0[3]), .LED4(HEX0[4]), .LED5(HEX0[5]), .LED6(HEX0[6]));
endmodule	
	
