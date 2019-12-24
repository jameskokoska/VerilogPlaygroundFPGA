// case 6: Hold the current value of the Register, i.e., the Register value does not change 
module register(Reset,D,Clock,Q); //Q= out regist
	input Reset;
	input [7:0]D;
	input Clock;
	output reg [7:0]Q;
	always @(posedge Clock)
	begin
		if (Reset == 1'b0)
			Q <= 0;
		else
			Q <= D;
	end
endmodule