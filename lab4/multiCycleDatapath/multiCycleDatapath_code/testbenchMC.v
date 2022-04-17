/*

input wire	clk;
input wire	rst;
input wire	PCWrite;
input wire	MemWrite;
input wire	IRWrite;
input wire	ImmSrc;
input wire	RegWrite;
input wire	ALUSrcA;
input wire	[1:0] AdrSrc;
input wire	[3:0] ALUControl;
input wire	[1:0] ALUSrcB;
input wire	[2:0] RegSrc;
input wire	[1:0] ResultSrc;

*/
module testbenchMC();
//inputs are reg 
//outputs are wire
//assume that bus width is 3 to test the result
//inputs
reg	clk;
reg	rst;
reg	PCWrite;
reg	MemWrite;
reg	IRWrite;
reg	ImmSrc;
reg	RegWrite;
reg	ALUSrcA;
reg	[1:0] AdrSrc;
reg   [3:0] ALUControl;
reg	[1:0] ALUSrcB;
reg	[2:0] RegSrc;
reg	[1:0] ResultSrc;


//outputs
 wire	[3:0] ALU_flags;
 wire	[7:0] R1out;
 wire	[7:0] R2out;





// instantiate device under test
multiCycleDatapath_code DUT(
	clk,
	rst,
	PCWrite,
	MemWrite,
	IRWrite,
	ImmSrc,
	RegWrite,
	ALUSrcA,
	AdrSrc,
	ALUControl,
	ALUSrcB,
	RegSrc,
	ResultSrc,
	ALU_flags,
	R1out,
	R2out
);


initial
begin
rst=1;
#100;
rst=0;
PCWrite=0;
MemWrite=0;
IRWrite=0;
ImmSrc=1;
RegWrite=0;
ALUSrcA=1;
AdrSrc=2'b11;
ALUControl=4'b0000;
ALUSrcB=2'b11;
RegSrc=3'b000;
ResultSrc=2'b00;
end

// generate clock
always // no sensitivity list, so it always executes
	begin
	clk = 0; #50; clk = 1; #50;
	end
	
//change the input signals according to the instructions 
initial // no sensitivity list, so it always executes
	begin
//ADD instruction
//fetch
#100;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//execute
#100;
ALUSrcA=0;
ALUControl=4'b0000;
ALUSrcB=2'b00;
RegSrc=3'b100;
ResultSrc=2'b10;
RegWrite=0;

//alu write back
#100;
ResultSrc=2'b00;
RegWrite=1;


//SUB instruction
//fetch
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//execute
#100;
ALUSrcA=0;
ALUControl=4'b0001;
ALUSrcB=2'b00;
RegSrc=3'b100;
ResultSrc=2'b10;
RegWrite=0;

//alu write back
#100;
ResultSrc=2'b00;
RegWrite=1;


//AND instruction
//fetch
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//execute
#100;
ALUSrcA=0;
ALUControl=4'b0010;
ALUSrcB=2'b00;
RegSrc=3'b100;
ResultSrc=2'b10;
RegWrite=0;

//alu write back
#100;
ResultSrc=2'b00;
RegWrite=1;


//ORR instruction
//fetch
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//execute
#100;
ALUSrcA=0;
ALUControl=4'b0011;
ALUSrcB=2'b00;
RegSrc=3'b100;
ResultSrc=2'b10;
RegWrite=0;

//alu write back
#100;
ResultSrc=2'b00;
RegWrite=1;


//XOR instruction
//fetch
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//execute
#100;
ALUSrcA=0;
ALUControl=4'b0100;
ALUSrcB=2'b00;
RegSrc=3'b100;
ResultSrc=2'b10;
RegWrite=0;

//alu write back
#100;
ResultSrc=2'b00;
RegWrite=1;


//CLR instruction
//fetch
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//execute
#100;
ALUSrcA=0;
ALUControl=4'b0101;
ALUSrcB=2'b00;
RegSrc=3'b100;
ResultSrc=2'b10;
RegWrite=0;

//alu write back
#100;
ResultSrc=2'b00;
RegWrite=1;


//ROL instruction
//fetch
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//execute
#100;
ALUSrcA=0;
ALUControl=4'b0110;
ALUSrcB=2'b00;
RegSrc=3'b100;
ResultSrc=2'b10;
RegWrite=0;

//alu write back
#100;
ResultSrc=2'b00;
RegWrite=1;


//ROR instruction
//fetch
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//execute
#100;
ALUSrcA=0;
ALUControl=4'b0111;
ALUSrcB=2'b00;
RegSrc=3'b100;
ResultSrc=2'b10;
RegWrite=0;

//alu write back
#100;
ResultSrc=2'b00;
RegWrite=1;


//LSL instruction
//fetch
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//execute
#100;
ALUSrcA=0;
ALUControl=4'b1000;
ALUSrcB=2'b00;
RegSrc=3'b100;
ResultSrc=2'b10;
RegWrite=0;

//alu write back
#100;
ResultSrc=2'b00;
RegWrite=1;


//ASR instruction
//fetch
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//execute
#100;
ALUSrcA=0;
ALUControl=4'b1010;
ALUSrcB=2'b00;
RegSrc=3'b100;
ResultSrc=2'b10;
RegWrite=0;

//alu write back
#100;
ResultSrc=2'b00;
RegWrite=1;


//LSR instruction
//fetch
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//execute
#100;
ALUSrcA=0;
ALUControl=4'b1001;
ALUSrcB=2'b00;
RegSrc=3'b100;
ResultSrc=2'b10;
RegWrite=0;

//alu write back
#100;
ResultSrc=2'b00;
RegWrite=1;
//shift and data processing operations are completed


//LDR instruction
//fetch-Cycle 1
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode Cycle 2
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//memADR Cycle 3
#100;
ImmSrc=0;
ALUSrcB=2'b01;
ALUSrcA=0;
ALUControl=4'b0000;

//memREAD Cycle 4
#100;
ResultSrc=2'b00;
AdrSrc=2'b01;
MemWrite=0;

//memWriteBack Cycle 5
#100;
ResultSrc=2'b01;
RegWrite=1;


//LDI instruction
//fetch-Cycle 1
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode Cycle 2
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//ALU write back for LDI cycle 3
#100;
ImmSrc=1;
ALUSrcB=2'b01;
ResultSrc=2'b11;
RegWrite=1;


//STR instruction
//fetch-Cycle 1
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode Cycle 2
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b110;
ResultSrc=2'b10;

//memADR Cycle 3
#100;
ImmSrc=0;
ALUSrcB=2'b01;
ALUSrcA=0;
ALUControl=4'b0000;

//memWrite
#100;
ResultSrc=2'b00;
AdrSrc=2'b01;
MemWrite=1;


//LDR instruction
//fetch-Cycle 1
#100;
RegWrite=0;
MemWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode Cycle 2
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//memADR Cycle 3
#100;
ImmSrc=0;
ALUSrcB=2'b01;
ALUSrcA=0;
ALUControl=4'b0000;

//memREAD Cycle 4
#100;
ResultSrc=2'b00;
AdrSrc=2'b01;
MemWrite=0;

//memWriteBack Cycle 5
#100;
ResultSrc=2'b01;
RegWrite=1;


//LDR and STR instructions are done 
//after that branch instructions 


//B instruction
//fetch-Cycle 1
#100;
RegWrite=0;
MemWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode Cycle 2
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b000;
ResultSrc=2'b10;


//branch cycle 3
#100;
PCWrite=1;
ALUSrcA=0;
ALUControl=4'b0000;
ALUSrcB=2'b01;
ResultSrc=2'b10;


//LDI instruction
//fetch-Cycle 1
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode Cycle 2
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//ALU write back for LDI cycle 3
#100;
ImmSrc=1;
ALUSrcB=2'b01;
ResultSrc=2'b11;
RegWrite=1;



//BL instruction
//fetch-Cycle 1
#100;
RegWrite=0;
MemWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode Cycle 2
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b001;
ResultSrc=2'b10;

//branch cycle 3
#100;
PCWrite=1;
ALUSrcA=0;
ALUControl=4'b0000;
ALUSrcB=2'b01;
ResultSrc=2'b10;
RegWrite=1;


//LDI instruction
//fetch-Cycle 1
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode Cycle 2
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//ALU write back for LDI cycle 3
#100;
ImmSrc=1;
ALUSrcB=2'b01;
ResultSrc=2'b11;
RegWrite=1;


//B instruction
//fetch-Cycle 1
#100;
RegWrite=0;
MemWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode Cycle 2
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b000;
ResultSrc=2'b10;


//branch cycle 3
#100;
PCWrite=1;
ALUSrcA=0;
ALUControl=4'b0000;
ALUSrcB=2'b01;
ResultSrc=2'b10;


//LDI instruction
//fetch-Cycle 1
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode Cycle 2
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//ALU write back for LDI cycle 3
#100;
ImmSrc=1;
ALUSrcB=2'b01;
ResultSrc=2'b11;
RegWrite=1;



//BI instruction
//fetch-Cycle 1
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode Cycle 2
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b101;
ResultSrc=2'b10;

//bi pc write
#100; 
ALUSrcB=2'b00;
ResultSrc=2'b11;
PCWrite=1;




//LDI instruction
//fetch-Cycle 1
#100;
RegWrite=0;
PCWrite=1;
IRWrite=1;
ALUSrcA=1;
AdrSrc=2'b00;
ALUControl=4'b0000;
ALUSrcB=2'b10;
ResultSrc=2'b10;

//decode Cycle 2
#100;
PCWrite=0;
MemWrite=0;
IRWrite=0;
RegWrite=0;
ALUSrcA=1;
ALUControl=4'b0000;
ALUSrcB=2'b10;
RegSrc=3'b100;
ResultSrc=2'b10;

//ALU write back for LDI cycle 3
#100;
ImmSrc=1;
ALUSrcB=2'b01;
ResultSrc=2'b11;
RegWrite=1;

end
	
endmodule