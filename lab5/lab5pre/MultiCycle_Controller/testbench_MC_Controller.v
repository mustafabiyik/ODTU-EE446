/*

input [1:0]  cond,
input [1:0]  OP,
input [2:0]  type,
input [3:0]  flags,
input [2:0]  Rd,
input 		 RESET,
input 		 RUN,
input 		 clk,
//outputs
output reg		 PCWrite,
output reg [1:0] AdrSrc,
output reg		 MemWrite,
output reg		 IRWrite,
output reg [2:0] RegSrc,
output reg		 RegWrite,
output reg	 	 ImmSrc,
output reg		 ALUSrcA,
output reg [1:0] ALUSrcB,
output reg [3:0] ALUControl,
output reg [1:0] ResultSrc,
output reg rst

*/
module testbench_MC_Controller();
//inputs are reg 
//outputs are wire
//assume that bus width is 3 to test the result
//inputs
reg [1:0]  cond;
reg [1:0]  OP;
reg [2:0]  type;
reg [3:0]  flags;
reg 		 RUN;
reg 		 clk;


//outputs
wire		 PCWrite;
wire [1:0] AdrSrc;
wire		 MemWrite;
wire		 IRWrite;
wire [2:0] RegSrc;
wire		 RegWrite;
wire	 	 ImmSrc;
wire		 ALUSrcA;
wire [1:0] ALUSrcB;
wire [3:0] ALUControl;
wire [1:0] ResultSrc;





// instantiate device under test
MultiCycle_Controller DUT(
//inputs
cond,
OP,
type,
flags,
RUN,
clk,

//outputs
PCWrite,
AdrSrc,
MemWrite,
IRWrite,
RegSrc,
RegWrite,
ImmSrc,
ALUSrcA,
ALUSrcB,
ALUControl,
ResultSrc
);



initial
begin

RUN=1;
//inputs
cond=2'b00;
OP=2'b00;
type=3'b000;
flags=4'b0000;

end

// generate clock
always // no sensitivity list, so it always executes
	begin
	clk = 0; #50; clk = 1; #50;
	end
	
//change the input signals according to the instructions 
always // no sensitivity list, so it always executes
	begin
//fetch
OP=2'b00;
type=3'b000;

#400; //sub
flags=4'b1011;//////flag update
OP=2'b00;
type=3'b010;

#400; //and

OP=2'b00;
type=3'b100;

#400; //orr

OP=2'b00;
type=3'b101;

#400; //xor

OP=2'b00;
type=3'b110;

#400; //clr

OP=2'b00;
type=3'b111;

#400; //rol

OP=2'b01;
type=3'b000;

#400; //ror

OP=2'b01;
type=3'b001;

#400; //lsl

OP=2'b01;
type=3'b010;

#400; //asr

OP=2'b01;
type=3'b011;

#400; //lsr

OP=2'b01;
type=3'b100;

#400; //ldi

OP=2'b10;
type[2:1]=2'b01;

#300; //ldr

OP=2'b10;
type[2:1]=2'b00;

#500; //str

OP=2'b10;
type[2:1]=2'b10;

#400; //branch und.

OP=2'b11;
type=3'b000;

#300; //branch bl

OP=2'b11;
type=3'b001;

#300; //branch ind.

OP=2'b11;
type=3'b010;

#300; //branch eq

//nzcv
flags=4'b0100; //z=1 means equal case
OP=2'b11;
type=3'b011;

#300; //branch not eq

//nzcv
flags=4'b1011; //z=0 means not equal case
OP=2'b11;
type=3'b100;
#300;

//bc
flags=4'b1010; //c=1 means carry set case
OP=2'b11;
type=3'b101;
#300;

//bnc
flags=4'b1000; //c=0 means not cary set case
OP=2'b11;
type=3'b110;
#300;


//END inst
flags=4'b1000; 
OP=2'b11;
type=3'b111;
#300;



end
	
endmodule