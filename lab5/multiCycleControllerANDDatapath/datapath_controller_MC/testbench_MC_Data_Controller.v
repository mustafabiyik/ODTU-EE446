/*

datapath_controller_MC(
input clk,
input RESET,
input RUN,
output wire [7:0] R1reg,
output wire [7:0] R2reg
);
*/
module testbench_MC_Data_Controller();
//inputs are reg 
//outputs are wire
//assume that bus width is 3 to test the result
//inputs

reg clk;
reg RESET;
reg RUN;
wire [7:0] R1reg;
wire [7:0] R2reg;




// instantiate device under test
datapath_controller_MC DUT(
clk,
RESET,
RUN,
R1reg,
R2reg
);



initial
begin
RESET=1;
#100;
RESET=0;
RUN=1;


end

// generate clock
always // no sensitivity list, so it always executes
	begin
	clk = 0; #50; clk = 1; #50;
	end
	



	
endmodule