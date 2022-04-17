/*

module lab3_exp(
input clk,
input rst,
output [3:0] Flag_outputs,
output [31:0] R1reg,
output [31:0] R2reg
);

*/
module testbenchSingleCycle();
//inputs are reg 
//outputs are wire
//assume that bus width is 3 to test the result
//inputs
reg clk;
reg rst;
//outputs
wire [3:0] Flag_outputs;
wire [31:0] R1reg;
wire [31:0] R2reg;



reg [3:0] FlagExp;
reg [31:0] R1Expected;
reg [31:0] R2Expected;


reg [68:0] vectornum, errors; // bookkeeping variables
reg [68:0] testvectors[16:0]; // array of testvectors 17 elements with 69 bits wide

// instantiate device under test
lab3_exp DUT(clk,rst,Flag_outputs,R1reg,R2reg);
initial
begin
clk = 0; #5;

end

// generate clock
always // no sensitivity list, so it always executes
	begin
	clk = 1; #50; clk = 0; #50;
	end
	
// at start of test, load vectors and pulse reset
	initial
	begin
		$readmemb("SingleCycleTest.tv", testvectors);
		
		vectornum = 0; errors = 0;
		
	end
	
// apply test vectors on rising edge of clk
always @(posedge clk)
	begin
	#1; {rst,FlagExp,R1Expected,R2Expected}= testvectors[vectornum];
	end
	
// check results on falling edge of clk
always @(negedge clk)
	begin 
				if ({Flag_outputs,R1reg,R2reg}!={FlagExp,R1Expected,R2Expected}) 
			begin 
				$display("Error: inputs = %b",{rst});
				$display(" outputs = %b (%b expected)",{Flag_outputs,R1reg,R2reg},{FlagExp,R1Expected,R2Expected});
				errors = errors + 1;
			end

	// increment array index and read next testvector
	vectornum = vectornum + 1;
			if (testvectors[vectornum] === 69'b000000000000000000000000000000000000000000000000000000000000000000000) //stop line in the testvector
			begin 
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
	end
endmodule