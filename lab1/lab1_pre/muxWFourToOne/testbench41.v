//vector table testbench
/*
input  [W-1:0] I1;
input  [W-1:0] I0;
input  s0;
output [W-1:0] out;

*/
//s0,s1,I0,I1,I2,I3,out
module testbench41();
//inputs are reg 
//outputs are wire
//assume that bus width is 3 to test the result
reg clk;
reg s0,s1;
reg [2:0] I0;
reg [2:0] I1;
reg [2:0] I2;
reg [2:0] I3;
wire [2:0] out;

reg [2:0] outExpected;


//////////////////////////////////////////////////////////////
reg [16:0] vectornum, errors; // bookkeeping variables
reg [16:0] testvectors[8:0]; // array of testvectors 9 elements with 7 bits wide

// instantiate device under test
muxWFourToOne #(3) DUT(s0,s1,I0,I1,I2,I3,out);

// generate clock
always // no sensitivity list, so it always executes
	begin
	clk = 1; #5; clk = 0; #5;
	end
	
// at start of test, load vectors and pulse reset
	initial
	begin
		$readmemb("textfile41.tv", testvectors);
		
		vectornum = 0; errors = 0;
		
	end
	
// apply test vectors on rising edge of clk
always @(posedge clk)
	begin
	#1; {s0,s1,I0,I1,I2,I3,outExpected}= testvectors[vectornum];
	end
	
// check results on falling edge of clk
always @(negedge clk)
	begin 
				if (out!= outExpected) 
			begin 
				$display("Error: inputs = %b",{s0,s1,I0,I1,I2,I3});
				$display(" outputs = %b (%b expected)",out,outExpected);
				errors = errors + 1;
			end

	// increment array index and read next testvector
	vectornum = vectornum + 1;
			if (testvectors[vectornum] === 17'b11000000000000011) //stop line in the testvector
			begin 
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
	end
endmodule