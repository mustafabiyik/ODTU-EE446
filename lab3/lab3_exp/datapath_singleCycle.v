//main code
//data memory at 178 line
//ext imm 218
//inst mem 255
//register file 296
module datapath_singleCycle(
	PCSource,
	rst,
	clk,
	MemToReg,
	MemWrite,
	RegWrite,
	ALUSrc,
	RegSrc,
	ALUControl,
	ImmSource,
	ALU_flags,
	cond,
	funct,
	instr65,
	op,
	rd,
	R1content,
	R2content
);


input wire	PCSource;
input wire	rst;
input wire	clk;
input wire	MemToReg;
input wire	MemWrite;
input wire	RegWrite;
input wire	ALUSrc;
input wire	RegSrc;
input wire	[2:0] ALUControl;
input wire	[1:0] ImmSource;
output wire	[3:0] ALU_flags;
output wire	[3:0] cond;
output wire	[5:0] funct;
output wire	[1:0] instr65;
output wire	[1:0] op;
output wire	[3:0] rd;
output 	[31:0] R1content;
output 	[31:0] R2content;

wire	[3:0] A2;
wire	[3:0] ALUflags;
wire	[31:0] I0;
wire	[31:0] Instruction;
wire	[31:0] out;
wire	[31:0] REGout;
wire	[31:0] SYNTHESIZED_WIRE_0;
wire	[31:0] SYNTHESIZED_WIRE_1;
wire	[31:0] SYNTHESIZED_WIRE_2;
wire	[31:0] SYNTHESIZED_WIRE_12;
wire	[31:0] SYNTHESIZED_WIRE_4;
wire	[31:0] SYNTHESIZED_WIRE_5;
wire	[31:0] SYNTHESIZED_WIRE_6;
wire	[31:0] SYNTHESIZED_WIRE_13;
wire	[31:0] SYNTHESIZED_WIRE_10;
wire	[31:0] SYNTHESIZED_WIRE_11;





simpleREG	b2v_inst(
	.clk(clk),
	.rst(rst),
	.DATA(SYNTHESIZED_WIRE_0),
	.REGout(REGout));
	defparam	b2v_inst.W = 32;

//(ALUcontrol,A,B,Y,N,Z,CO,OVF);
ALU	b2v_inst10(
	.A(SYNTHESIZED_WIRE_1),
	.ALUcontrol(ALUControl),
	.B(SYNTHESIZED_WIRE_2),
	.Y(I0),
	.N(ALUflags[3]),
	.Z(ALUflags[2]),
	.CO(ALUflags[1]),
	.OVF(ALUflags[0]));
	defparam	b2v_inst10.W = 32;


adder32bits	b2v_inst11(
	.A(SYNTHESIZED_WIRE_12),
	.B(SYNTHESIZED_WIRE_4),
	.Y(SYNTHESIZED_WIRE_6));


adder32bits	b2v_inst12(
	.A(REGout),
	.B(SYNTHESIZED_WIRE_5),
	.Y(SYNTHESIZED_WIRE_12));


ConstantValueGenerator	b2v_inst13(
	.Data_on_Bus(SYNTHESIZED_WIRE_5));
	defparam	b2v_inst13.BUS_DATA = 3'b100;
	defparam	b2v_inst13.DATA_WIDTH = 32;


ConstantValueGenerator	b2v_inst14(
	.Data_on_Bus(SYNTHESIZED_WIRE_4));
	defparam	b2v_inst14.BUS_DATA = 3'b100;
	defparam	b2v_inst14.DATA_WIDTH = 32;


InstructionMemory	b2v_inst2(
	.CurrentPC(REGout),
	.Instruction(Instruction));


RegisterFile	b2v_inst3(
	.clk(clk),
	.rst(rst),
	.WE(RegWrite),
	.A1(Instruction[19:16]),
	.A2(A2),
	.A3(Instruction[15:12]),
	.R15(SYNTHESIZED_WIRE_6),
	.WD3(out),
	.RD1(SYNTHESIZED_WIRE_1),
	.RD2(SYNTHESIZED_WIRE_13),
	.R1(R1content),
	.R2(R2content)
	);


dataMemory	b2v_inst4(
	.clk(clk),
	.memWE(MemWrite),
	.memA(I0),
	.memWD(SYNTHESIZED_WIRE_13),
	.memRD(SYNTHESIZED_WIRE_11));


extImm	b2v_inst5(
	.ImmSrc(ImmSource),
	.Instr110(Instruction[11:0]),
	.extendedImm(SYNTHESIZED_WIRE_10));


muxWTwoToOne	b2v_inst6(
	.s0(PCSource),
	.I0(SYNTHESIZED_WIRE_12),
	.I1(out),
	.out(SYNTHESIZED_WIRE_0));
	defparam	b2v_inst6.W = 32;


muxWTwoToOne	b2v_inst7(
	.s0(RegSrc),
	.I0(Instruction[3:0]),
	.I1(Instruction[15:12]),
	.out(A2));
	defparam	b2v_inst7.W = 4;


muxWTwoToOne	b2v_inst8(
	.s0(ALUSrc),
	.I0(SYNTHESIZED_WIRE_13),
	.I1(SYNTHESIZED_WIRE_10),
	.out(SYNTHESIZED_WIRE_2));
	defparam	b2v_inst8.W = 32;


muxWTwoToOne	b2v_inst9(
	.s0(MemToReg),
	.I0(I0),
	.I1(SYNTHESIZED_WIRE_11),
	.out(out));
	defparam	b2v_inst9.W = 32;

assign	cond[3:0] = Instruction[31:28];
assign	funct[5:0] = Instruction[25:20];
assign	instr65[1:0] = Instruction[6:5];
assign	op[1:0] = Instruction[27:26];
assign	rd[3:0] = Instruction[15:12];

endmodule


//DATA MEMORY
 module dataMemory  
 (  	// input ports
      input                 clk,  
      input     [31:0]      memA,//memory address according to the address write or read occur    
      input     [31:0]      memWD,//memory write data, it specifies the memory data which can be written  
      input                 memWE,//memory write enable  
      // output port 
      output    [31:0]      memRD  
 );  
      
      reg 		 [31:0] 		 DATAmem  [255:0]; 	
		
		
		//initialize the memory
	
		integer i;  
      initial 
		  begin  
           for(i=0;i<256;i=i+1)  
                DATAmem[i] <= i; 
		  end  
			/*	
		initial begin
		$readmemh("memory.txt",DATAmem,0,255);
		end 
					*/
    

		
      always @(posedge clk) begin  
           if (memWE)  
			  begin
                DATAmem[memA] <= memWD; 
			  end 
      end 
		
      assign memRD = DATAmem[memA]; //it provides the data which is specified by the address  
		
 endmodule  

/*EXTIMM*/
module extImm
(
//input port
input  [1:0] 	ImmSrc,
input  [11:0]	Instr110, 
//output port
output reg [31:0]  extendedImm
);


always @(*)
begin
case(ImmSrc)
	2'b00://for data processing imm8
	begin
		extendedImm= {24'b0,Instr110[7:0]};
	end
	
	2'b01://for ldr and strong0
	begin
		extendedImm= {20'b0,Instr110[11:0]};
	end

	2'b11://for lsr and lsl
	begin
		extendedImm= {27'b0,Instr110[11:7]};
	end
	default
	begin
		extendedImm={24'b0,Instr110[7:0]};
	end
endcase
end

endmodule

/*instruction memory*/
module InstructionMemory          
 (  
      input    		 [31:0]     CurrentPC,  
      output          [31:0]     Instruction  
 );  
 
 
 		wire [31:0] counterInst;
      reg [31:0] instr[15:0];  
		//if the PC 0 then implies first 32 bit instruction
		//if PC 4 then second instruction
		//PC 8 3 instruction
      //initialize the instructions
		initial  
      begin              //always/op/I/cmd/S/rn/rd/src2
					instr[1]	<=  32'b1110_0110_0001_0100_0001_0000_0010_0001;//ldr load r1
					instr[2] <=  32'b1110_0110_0001_0001_0010_0000_0000_0011;//ldr load r2
               instr[3] <=  32'b1110_0000_1000_0010_0001_0000_0000_1001; //add
					instr[4] <=  32'b1110_0000_0100_0001_0001_0000_0000_0010; //subtract
					instr[5] <=  32'b1110_0000_0000_0110_0010_0000_0000_0001; //and
					instr[6] <=  32'b1110_0001_1000_1000_0010_0000_0000_0001; //orr
					instr[7] <=  32'b1110_0100_0001_1001_0001_0000_0010_1111;//ldr load
					instr[8] <=  32'b1110_0001_1010_0001_0010_0001_1000_0000; //lsl
					instr[9] <=  32'b1110_0001_1010_0001_0010_0001_1010_0000; //lsr
					instr[10] <= 32'b1110_0001_0100_0000_0011_0000_0000_1010; //cmp
					instr[11] <= 32'b1110_0100_0000_1011_0001_0000_0000_0001; //str
					instr[12] <= 32'b1110_0100_0001_1010_0010_0000_0000_0001; //ldr 
					instr[13] <= 32'b1110_0100_0000_1011_0001_0000_0000_1010; //str
					instr[14] <= 32'b1110_0100_0001_1010_0010_0000_0000_1010; //ldr
					instr[15] <= 32'b0000_0000_0000_0000_0000_0000_0000_0000; 
					
					
				
		
		end
                
		assign counterInst={2'b00,CurrentPC[31:2]}; //it gives the instruction number because PC increases 4 by 4
      assign Instruction = instr[counterInst];  
 endmodule

 
 /*register File*/
 module RegisterFile  
 (   //input ports
      input                    clk,  
      input                    rst,  
      input                    WE,  //write enable signal
      input          [3:0]     A1,  
		input          [3:0]     A2,  
		input          [3:0]     A3,  
      input          [31:0]    WD3,  
      //output ports 
      output         [31:0]    RD1,    
      output         [31:0]    RD2,
		input 			[31:0]	 R15,
		//for the demostration purpose
		output		   [31:0]    R1,
		output		   [31:0]    R2
 );  
      
		
	reg  [31:0]   register_R [15:0]; //31 bits width and 16 bits length 
	initial
	begin
					register_R[0] = 32'b0;
					register_R[1] = 32'b0;
					register_R[2] = 32'b0;
					register_R[3] = 32'b0;
					register_R[4] = 32'b0;
					register_R[5] = 32'b0;
					register_R[6] = 32'b0;
					register_R[7] = 32'b0;
					register_R[8] = 32'b0;
					register_R[9] = 32'b0;
					register_R[10]= 32'b0;
					register_R[11] = 32'b0;
					register_R[12] = 32'b0;
					register_R[13] = 32'b0;
					register_R[14] = 32'b0;
					register_R[15] = 32'b0;
	end
   
      always @ (posedge clk or posedge rst) begin  
		
           if(rst) begin  
               register_R[0] <= 32'b0;
					register_R[1] <= 32'b0;
					register_R[2] <= 32'b0;
					register_R[3] <= 32'b0;
					register_R[4] <= 32'b0;
					register_R[5] <= 32'b0;
					register_R[6] <= 32'b0;
					register_R[7] <= 32'b0;
					register_R[8] <= 32'b0;
					register_R[9] <= 32'b0;
					register_R[10] <= 32'b0;
					register_R[11] <= 32'b0;
					register_R[12] <= 32'b0;
					register_R[13] <= 32'b0;
					register_R[14] <= 32'b0;
					register_R[15] <= 32'b0;
           end  
			  
           else 
			  begin  
                if(WE) begin  
                     register_R[A3] <= WD3;  //if WE is equal to 1 then corresponding register is written
                end  
           end  
			  
      end  
      assign RD1 = register_R[A1];  //read data 1
      assign RD2 = register_R[A2];  //read data 2
		//to demostration 
		assign R1  = register_R[1];
		assign R2  = register_R[2];
		
 endmodule   

 
 
 
 

//it creates the constant value
module ConstantValueGenerator #(parameter DATA_WIDTH = 1,parameter BUS_DATA = 0) ( 
//port declerations
output wire [DATA_WIDTH-1:0] Data_on_Bus 
);
//assign DATA_BUS to the bus
assign Data_on_Bus [DATA_WIDTH-1:0]=BUS_DATA;

endmodule

/*Arithmetic Logic Unit ALU*/
module ALU #(parameter W=32) (ALUcontrol,A,B,Y,N,Z,CO,OVF);
//negative and zero bits are affected by ALU op
//CO and OVF are affected by arithmetics
input [2:0] ALUcontrol;
input [W-1:0] A,B;
output reg [W-1:0] Y; //output
output reg CO,OVF,N,Z; //cpsr
wire [W-1:0] Bcomp=~B; //bitwise not
wire [W-1:0] Acomp=~A; //bitwise not
reg E;
always @(*)
begin
	case(ALUcontrol)
	3'b000: //add
	begin
		//update the overflow bit according to the signs
				{CO, Y} = A + B;
					if (A[W-1] ~^ B[W-1]) //if the signs are the same
						OVF = Y[W-1] ^ A[W-1];
					else
						OVF = 0;	
						
		
	end
	3'b001: //subt a-b
	begin
//update the overflow bit according to the signs
					{CO, Y} = A + Bcomp+1;
					if ((A[W-1] ^ B[W-1]))
						OVF = Y[W-1] ^ A[W-1];
					else
						OVF = 0;
	end
	3'b010: 
	begin   
			Y=A&B;   //and
			CO=0;
			OVF=0;

	end
	
		3'b011: 
	begin   
	
			Y=A|B;   //or
			CO=0;
			OVF=0;
	
			
	end
	
	3'b100:  //shift left lsr
	begin
		   Y=A>>B;
	end

	3'b101:  //shift right lsl
	begin
			Y=A<<B;
	end

	3'b110:	
	begin
			Y=A^B;   //exor
			CO=0;
			OVF=0;
	end
	
	
	3'b111:	
	begin
			Y=A&Bcomp; //bit clear	
			CO=0;
			OVF=0;
	end
	

	
	endcase
end


always @(*)
begin
		N = Y[W-1];
		Z = ~|Y;
end

endmodule




/*Simple register*/

module simpleREG #(parameter W=1) (DATA,clk,rst,REGout);
input rst,clk;
input [W-1:0] DATA;
output reg [W-1:0] REGout;
initial
begin
REGout=32'b0;
end

always @(posedge clk)
begin
	if(rst==1)
		begin
			REGout<=0;
		end
	else
		begin
		
			REGout<=DATA;
		end

end

endmodule

/*ADDER 32 BITS*/

module adder32bits(A,B,Y);

input [31:0] A;
input [31:0] B;
output [31:0] Y;
assign Y=A+B;

endmodule

/*
Implement a W-bit 2 to 1 and a W-bit 4 to 1 multiplexers, where W is a parameter specifying the
data width of the input.
*/
module muxWTwoToOne #(parameter W=1)(s0,I1,I0,out);

input [W-1:0] I1;
input [W-1:0] I0;
input s0;
output [W-1:0] out;

assign out=s0 ? I1 : I0;

endmodule


