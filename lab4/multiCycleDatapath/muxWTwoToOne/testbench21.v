//vector table testbench
/*
input  [W-1:0] I1;
input  [W-1:0] I0;
input  s0;
output [W-1:0] out;

*/
module testbench21();
//inputs are reg 
//outputs are wire
reg clk;
reg [1:0] I1;
reg [1:0] I0;
wire [1:0] out;
reg s0;

reg [1:0] outExpected;



reg [6:0] vectornum, errors; // bookkeeping variables
reg [6:0] testvectors[8:0]; // array of testvectors 9 elements with 7 bits wide

// instantiate device under test
muxWTwoToOne #(2) DUT(s0,I1,I0,out);
// generate clock
always // no sensitivity list, so it always executes
	begin
	clk = 1; #5; clk = 0; #5;
	end
	
// at start of test, load vectors and pulse reset
	initial
	begin
		$readmemb("textfile2.tv", testvectors);
		
		vectornum = 0; errors = 0;
		
	end
	
// apply test vectors on rising edge of clk
always @(posedge clk)
	begin
	#1; {s0,I1,I0,outExpected}= testvectors[vectornum];
	end
	
// check results on falling edge of clk
always @(negedge clk)
	begin 
				if (out!= outExpected) 
			begin 
				$display("Error: inputs = %b",{s0,I1,I0});
				$display(" outputs = %b (%b expected)",out,outExpected);
				errors = errors + 1;
			end

	// increment array index and read next testvector
	vectornum = vectornum + 1;
			if (testvectors[vectornum] === 7'b0000001)
			begin 
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
	end
endmodule