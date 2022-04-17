//vector table testbench
/*
input rst,clk,DATA;
output reg [W-1:0] REG;

*/
module testbenchWE();
//inputs are reg 
//outputs are wire
//assume that bus width is 2 to test the result
reg clk,rst,WE;
reg [2:0] DATA;
wire [2:0] out;
reg [2:0] outExpected;


//DATA,clk,rst,REG
reg [7:0] vectornum, errors; // bookkeeping variables
reg [7:0] testvectors[9:0]; // array of testvectors 10 elements with 8 bits wide

// instantiate device under test
writeEnableREG #(3) DUT(DATA,clk,rst,out,WE);

// generate clock
always // no sensitivity list, so it always executes
	begin
	clk = 1; #5; clk = 0; #5;
	end
	
// at start of test, load vectors and pulse reset
	initial
	begin
		$readmemb("testWE.tv", testvectors);
		
		vectornum = 0; errors = 0;
		
	end
	
// apply test vectors on rising edge of clk
always @(posedge clk)
	begin
	#1; {DATA,rst,outExpected,WE}= testvectors[vectornum];
	end
	
// check results on falling edge of clk
always @(negedge clk)
	begin 
				if (out!= outExpected) 
			begin 
				$display("Error: inputs = %b",{DATA,rst,WE});
				$display(" outputs = %b (%b expected)",out,outExpected);
				errors = errors + 1;
			end

	// increment array index and read next testvector
	vectornum = vectornum + 1;
			if (testvectors[vectornum] === 8'b0000_0000) //stop line in the testvector
			begin 
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
	end
endmodule