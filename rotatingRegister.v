module rotatingRegister(SW, KEY, LEDR);
	input [9:0]SW;
	input [3:0]KEY;
	output [7:0]LEDR;
	wire out7, out6, out5, out4, out3, out2, out1, out0, asrightout;
	register reg7(.clock(KEY[0]), .reset(SW[9]), .parallelin(KEY[1]), .din(SW[7]), .rotatein(KEY[2]), .qnext(out6), .qprev(asrightout), .qout(out7));
	register reg6(.clock(KEY[0]), .reset(SW[9]), .parallelin(KEY[1]), .din(SW[6]), .rotatein(KEY[2]), .qnext(out5), .qprev(out7), .qout(out6));
	register reg5(.clock(KEY[0]), .reset(SW[9]), .parallelin(KEY[1]), .din(SW[5]), .rotatein(KEY[2]), .qnext(out4), .qprev(out6), .qout(out5));
	register reg4(.clock(KEY[0]), .reset(SW[9]), .parallelin(KEY[1]), .din(SW[4]), .rotatein(KEY[2]), .qnext(out3), .qprev(out5), .qout(out4));
	register reg3(.clock(KEY[0]), .reset(SW[9]), .parallelin(KEY[1]), .din(SW[3]), .rotatein(KEY[2]), .qnext(out2), .qprev(out4), .qout(out3));
	register reg2(.clock(KEY[0]), .reset(SW[9]), .parallelin(KEY[1]), .din(SW[2]), .rotatein(KEY[2]), .qnext(out1), .qprev(out3), .qout(out2));
	register reg1(.clock(KEY[0]), .reset(SW[9]), .parallelin(KEY[1]), .din(SW[1]), .rotatein(KEY[2]), .qnext(out0), .qprev(out2), .qout(out1));
	register reg0(.clock(KEY[0]), .reset(SW[9]), .parallelin(KEY[1]), .din(SW[0]), .rotatein(KEY[2]), .qnext(out7), .qprev(out1), .qout(out0));
	mux2to1 asright(.x(out0), .y(out7), .s(KEY[3]), .m(asrightout)); //KEY3 asright

	assign LEDR[7] = out7;
	assign LEDR[6] = out6;
	assign LEDR[5] = out5;
	assign LEDR[4] = out4;
	assign LEDR[3] = out3;
	assign LEDR[2] = out2;
	assign LEDR[1] = out1;
	assign LEDR[0] = out0;
	
endmodule

module mux2to1(x, y, s, m);
    input x; //select 0
    input y; //select 1
    input s; //select signal
    output m; //output
  
    //assign m = s & y | ~s & x;
    assign m = s ? y : x;
endmodule

module flipflop(d, q, clock, reset);
	input reset;
	input clock;
	input d;
	output reg q;
	always @(posedge clock)
	begin
		if(reset)
			q <= 1'b0;
		else
			q <= d;
	end
endmodule

module register(clock, reset, parallelin, din,rotatein, qnext, qprev, qout);
	input clock,reset,parallelin,din,rotatein,qnext,qprev;
	output qout;
	wire qoutW;
	wire parallelout, rotateout;
	
	mux2to1 rotateR(.x(qnext), .y(qprev), .s(rotatein), .m(rotateout));
	mux2to1 parallelload(.x(din), .y(rotateout), .s(parallelin), .m(parallelout));
	flipflop F1(.d(parallelout), .q(qoutW), .clock(clock), .reset(reset));
	
	assign qout = qoutW;
endmodule
