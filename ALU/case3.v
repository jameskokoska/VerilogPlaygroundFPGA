// case 3: Output 8'b0001111 if at least 1 of the 8 bits in the two inputs is 1 (use a single OR operation)
module if1of8(A,B,C);
	input [3:0]A, B;
	output reg [7:0]C;
	always @(*)
	begin
	if(A > 0 || B > 0)
		begin
		C = 8'b00001111;
		end
	else 
		C=8'b00000000;
	end
endmodule


module case3(SW, B, ALUOut);
	input [7:0]SW;
	input [3:0]B;
	output [7:0]ALUOut;
	
	if1of8 C4(.A(SW[3:0]), .B(B[3:0]), .C(ALUOut));
endmodule
