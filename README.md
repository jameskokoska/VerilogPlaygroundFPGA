# VerilogPlaygroundFPGA
* Collection of simple projects used as introductory practice for verilog and working with FPGAs
## Usage
* Made for the DE1-SoC FPGA board
* `DE1_SoC.qsf` contains all necessary pin assignments
## 2to1Mux.v
* A simple 2 to 1 mux created with verilog and a 2 to 1 mux created with individual gates
# seg7Display.v
* A simple 7 segment display module that outputs necesarry signals to display numbers given a 4 bit binary number
## caseStatement.v
* A simple 6 to 1 mux using case statements
## fullAdder.v
* A simple full adder module capable of adding 4 bit numbers together
## /ALU/fullALU.v
* A simple arithmetic logic unit that performs various functions shown below in pseudo code format
`0: A + B using the adder from Part II of this Lab (ripple-carry adder)`
`1: A + B using the Verilog ‘+’ operator `
`2: A XNOR B in the lower four bits of ALUout and A NAND B in the upper four bits `
`3: Output 8’b0001111 if at least 1 of the 8 bits in the two inputs is 1 (use a single OR operation) `
`4: Output 8’b1110000 if exactly 1 bit of the A switches is 1, and exactly 2 bits of the B switches are 1 `
`5: Display the A switches in the most significant four bits of ALUout and the complement of the B switches in the least-significant four bits without complementing the bits individually`
`6: Hold the current value of the Register, i.e., the Register value does not change`
## rotatingRegister.v
* A simple rotating register, or shift register, with parallel load and arithmetic shift options
