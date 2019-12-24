module drawBox
	(	SW,
		CLOCK_50,						//	On Board 50 MHz
		KEY,								// On Board Keys
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,					//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   							//	VGA Blue[9:0]
	);
	input [9:0]SW;
	input			CLOCK_50;				//	50 MHz
	input	[3:0]	KEY;					
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;
	assign writeEn = ~KEY[1];
	assign colour = SW[9:7];

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
				
	control con(CLOCK_50, resetn, ~KEY[3], ldx, ldy);
	datapath dp(CLOCK_50, resetn, SW[6:0], ldx, ldy, x, y);

endmodule



module datapath(
    input clk,
    input resetn,
    input [6:0] data_in,
	 input ld_x, ld_y,
    output reg [6:0] data_x, data_y
    );
	
	 reg [6:0]x, y;
    // Registers a, b, c, x with respective input logic
    always@(posedge clk) begin
        if(!resetn) begin
            x <= 0; 
            y <= 0; 
        end
        else begin
            if(ld_x)
                x <= data_in[6:0];
            if(ld_y)
                y <= data_in[6:0];
        end
    end
    
	 always @(posedge clk) begin
			if(!resetn) begin
				data_x<=0;
				data_y<=0;
			end
			else if(ld_x) begin
				data_x<=x;
			end
			else if(ld_y) begin
				data_y<=y;
			end
		end
endmodule

module control(
    input clk,
    input resetn,
    input go,
    output reg ld_x, ld_y
    );

    reg [5:0] current_state, next_state; 
    
    localparam  S_LOAD_X        = 5'd0,
                S_LOAD_X_WAIT   = 5'd1,
                S_LOAD_Y        = 5'd2,
                S_LOAD_Y_WAIT   = 5'd3;
    
    //state table
    always@(*)
    begin: state_table 
            case (current_state)
                S_LOAD_X: 
						next_state = go ? S_LOAD_X_WAIT : S_LOAD_X; // Loop in current state until value is input
                S_LOAD_X_WAIT: 
						next_state = go ? S_LOAD_X_WAIT : S_LOAD_Y; // Loop in current state until go signal goes low
                S_LOAD_Y: 
						next_state = go ? S_LOAD_Y_WAIT : S_LOAD_Y; // Loop in current state until value is input
                S_LOAD_Y_WAIT: 
						next_state = go ? S_LOAD_Y_WAIT : S_LOAD_X; // Loop in current state until go signal goes low
            default:     next_state = S_LOAD_X;
        endcase
    end // state_table
   

    //datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0 to avoid latches.
        // This is a different style from using a default statement.
        // It makes the code easier to read.  If you add other out
        // signals be sure to assign a default value for them here.
        ld_x = 1'b0;
        ld_y = 1'b0;

        case (current_state)
            S_LOAD_X: begin
                ld_x = 1'b1;
                end
            S_LOAD_Y: begin
                ld_y = 1'b1;
                end

        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
   
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_LOAD_X;
        else
            current_state <= next_state;
    end // state_FFS
endmodule