module fullALU(SW, KEY, ALUOut, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
	input [7:0]SW;
	input [2:0]KEY;
	output [6:0]HEX0;
	output [6:0]HEX1;
	output [6:0]HEX2;
	output [6:0]HEX3;
	output [6:0]HEX4;
	output [6:0]HEX5;
	output [7:0]LEDR;
	
	output reg [7:0]ALUOut;
	wire [7:0]w0, w1, w2, w3, w4, w5;
	
	case0 ALU0(SW, w0);
	case1 ALU1(SW, w1);
	case2 ALU2(SW, w2);
	case3 ALU3(SW, w3);
	case4 ALU4(SW, w4);
	case5 ALU5(SW, w5);
	
	always @(*) // declare always block
	begin
		case (KEY[2:0]) // start case statement
			3'b000: ALUOut = w0;// case 0 A + B using the adder from Part II of this Lab (ripple-carry adder)
			3'b001: ALUOut = w1;// case 1 A + B using the Verilog ‘+’ operator
			3'b010: ALUOut = w2;// case 2: A XNOR B in the lower four bits of ALUout and A NAND B in the upper four bits
			3'b011: ALUOut = w3;// case 3: Output 8’b0001111 if at least 1 of the 8 bits in the two inputs is 1 (use a single OR operation)
			3'b100: ALUOut = w4; // case 4: Output 8’b1110000 if exactly 1 bit of the A switches is 1, and exactly 2 bits of the B switches are 1
			3'b101: ALUOut = w5; // case 5: Display the A switches in the most significant four bits of ALUout and the complement of the B switches in the least-significant four bits without complementing the bits individually
			default: ALUOut = w0; // default case
		endcase
	end
	seg7display dispout(SW, ALUOut, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
endmodule