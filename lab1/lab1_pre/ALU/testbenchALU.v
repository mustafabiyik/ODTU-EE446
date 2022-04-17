//vector table testbench
/*
module ALU #(parameter W=3) (ALUcontrol,A,B,Y,N,Z,CO,OVF);
//negative and zero bits are affected by ALU op
//CO and OVF are affected by arithmetics
input [2:0] ALUcontrol;
input [W-1:0] A,B;
output reg [W-1:0] Y; //output
output reg CO,OVF,N,Z; //cpsr

*/
module testbenchALU();
//inputs are reg 
//outputs are wire
//assume that bus width is 3 to test the result
reg clk;
reg [2:0] ALUcontrol;
reg [2:0] A,B;
wire [2:0] Y; //output
wire CO,OVF,N,Z; //cpsr

reg COexp,OVFexp,Nexp,Zexp;
reg [2:0] outExpected;

//DATA,clk,rst,REG
reg [15:0] vectornum, errors; // bookkeeping variables
reg [15:0] testvectors[19:0]; // array of testvectors 9 elements with 15 bits wide

// instantiate device under test
ALU #(3) DUT(ALUcontrol,A,B,Y,N,Z,CO,OVF);

// generate clock
always // no sensitivity list, so it always executes
	begin
	clk = 1; #5; clk = 0; #5;
	end
	
// at start of test, load vectors and pulse reset
	initial
	begin
		$readmemb("ALUtest.tv", testvectors);
		
		vectornum = 0; errors = 0;
		
	end
	
// apply test vectors on rising edge of clk
always @(posedge clk)
	begin
	#1; {ALUcontrol,A,B,outExpected,Nexp,Zexp,COexp,OVFexp}= testvectors[vectornum];
	end
	
// check results on falling edge of clk
always @(negedge clk)
	begin 
				if ({Y,N,Z,CO,OVF}!={outExpected,Nexp,Zexp,COexp,OVFexp}) 
			begin 
				$display("Error: inputs = %b",{ALUcontrol,A,B});
				$display(" outputs = %b (%b expected)",{Y,N,Z,CO,OVF},{outExpected,Nexp,Zexp,COexp,OVFexp});
				errors = errors + 1;
			end

	// increment array index and read next testvector
	vectornum = vectornum + 1;
			if (testvectors[vectornum] === 16'b0000000000000000) //stop line in the testvector
			begin 
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
	end
endmodule