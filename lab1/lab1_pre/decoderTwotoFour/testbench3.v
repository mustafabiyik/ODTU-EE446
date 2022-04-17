//vector table testbench

module testbench3();
//inputs are reg 
//outputs are wire
reg in0,in1,en,clk;
reg [3:0] outExpected;
wire out0,out1,out2,out3;


reg [6:0] vectornum, errors; // bookkeeping variables
reg [6:0] testvectors[8:0]; // array of testvectors 9 elements with 7 bits wide

// instantiate device under test
decoderTwotoFour DUT(in0,in1,en,out0,out1,out2,out3);
// generate clock
always // no sensitivity list, so it always executes
	begin
	clk = 1; #5; clk = 0; #5;
	end
	
// at start of test, load vectors and pulse reset
	initial
	begin
		$readmemb("testfile.tv", testvectors);
		
		vectornum = 0; errors = 0;
		
	end
	
// apply test vectors on rising edge of clk
always @(posedge clk)
	begin
	#1; {in0,in1,en,outExpected[3:0]}= testvectors[vectornum];
	end
	
// check results on falling edge of clk
always @(negedge clk)
	begin 
				if ({out0,out1,out2,out3}!= outExpected[3:0]) 
			begin 
				$display("Error: inputs = %b", {in0,in1,en});
				$display(" outputs = %b (%b expected)",{out0,out1,out2,out3},outExpected[3:0]);
				errors = errors + 1;
			end

	// increment array index and read next testvector
	vectornum = vectornum + 1;
			if (testvectors[vectornum] === 7'b1111111)
			begin 
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
	end
endmodule