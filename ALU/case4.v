// case 4: Output 8'b1110000 if exactly 1 bit of the A switches is 1, and exactly 2 bits of the B switches are 1
module exact1or2(A,B,C);
	input [3:0]A, B;
	output reg [7:0]C;
	always @(*)
	begin
		if((A[0]+A[1]+A[2]+A[3])==1 && (B!=4'b0000 && B!=4'b1111) && ~^B )
		begin
			C = 8'b01110000;
		end
		else
		begin
			C = 8'b00000000;
		end
	end
endmodule


module case4(SW, B, ALUOut);
	input [7:0]SW;
	input [3:0]B;
	output [7:0]ALUOut;
	
	exact1or2 C4(.A(SW[3:0]), .B(SW[7:4]), .C(ALUOut));
endmodule
