/*//cond logic verilog code
 module controller_singleCycle_condLogic(
input [3:0] cond,
input [3:0] ALUFLa,
input [1:0] FlagW,
input  PCs,
input  RegW,
input  MemW,

output  PCSrc,
output  RegWrite,
output  MemWrite,
output  [3:0] ALUFLAGS,
input clk
);
//condex assumed as 1
reg [3:0] flagG;
reg condex;
always @(posedge clk)
begin
	if(condex==1)
		begin
		 if(FlagW[1]==1)
			begin
				flagG[3:2]=ALUFLa[3:2];
			end
			
		else if(FlagW[0]==1)
			begin
				flagG[1:0]=ALUFLa[1:0];
			end
		else
		 begin
			   flagG=flagG;
		 end		
	end
		else
		begin
			flagG=flagG;
		end
	
end

assign ALUFLAGS=flagG;
always @(*)
begin
		case(cond)//nzcv aluflags[3:0]
		//z
		4'b0000: condex= ALUFLAGS[2];//equal
		4'b0001: condex= ~ALUFLAGS[2]; //not equal
		//c
		4'b0010: condex= ALUFLAGS[1]; //carry set
		4'b0011: condex= ~ALUFLAGS[1];
		//n
		4'b0100: condex= ALUFLAGS[3];
		4'b0101: condex= ~ALUFLAGS[3];
		//v
		4'b0110: condex= ALUFLAGS[0];
		4'b0111: condex= ~ALUFLAGS[0];

		4'b1000: condex= ~ALUFLAGS[2] & ALUFLAGS[1];
		4'b1001: condex= ~ALUFLAGS[1] | ALUFLAGS[2];

		4'b1010: condex= ~(ALUFLAGS[3] ^ ALUFLAGS[0]);
		4'b1011: condex= ALUFLAGS[3] ^ ALUFLAGS[0];

		4'b1100: condex= (~(ALUFLAGS[3] ^ ALUFLAGS[0])) & ~ALUFLAGS[2];
		4'b1101: condex= ((ALUFLAGS[3] ^ ALUFLAGS[0])) | ALUFLAGS[2];
		4'b1110: condex= 1 ;

		endcase


end
assign  PCSrc= condex & PCs;
assign RegWrite= condex & RegW;
assign MemWrite= condex & MemW;



endmodule


//decoder
module controller_singleCycle_decoder(

//input ports
input [1:0] op,
input [5:0] funct,
input [3:0] rd,
input [1:0] instr65,

//output ports
output reg [1:0] FlagW,
output reg PCs,
output reg RegW,
output reg MemW,
output reg [1:0] ImmSrc,
output reg MemToReg,
output reg ALUSrc,
output reg RegSrc,
output reg [2:0] ALUControl
);

always @(*)
begin
	case(op)
	2'b00://data processing
	begin //funct25=I
			//funct20=S
		PCs=0;
		MemToReg=0;
		MemW=0;
		RegSrc=0;
		
		if(funct[4:1]==4'b1010)//cmp 
			begin
			RegW=0;
			end
		else //otherwise
			begin
			RegW=1;
			end
			
		if(funct[4:1]==4'b1101)//shift 
			begin
			ImmSrc=2'b11;
			ALUSrc=1'b1;
			end
		else //otherwise
			begin
			ImmSrc=2'b00;
			ALUSrc=funct[5];
			end
	
	
		case(funct[4:1])
				4'b0100://add
				begin
						ALUControl=3'b000;
						//S control
							if(funct[0])
								begin
									FlagW=2'b11;
								end
							else
								begin
									FlagW=2'b00;
								end
				end
						
				4'b0010://sub
				begin
						ALUControl=3'b001;
						//S control
							if(funct[0])
								begin
									FlagW=2'b11;
								end
							else
								begin
									FlagW=2'b00;
								end
				end
				
				4'b0000://and
				begin
						ALUControl=3'b010;
						//S control
							if(funct[0])
								begin
									FlagW=2'b10;
								end
							else
								begin
									FlagW=2'b00;
								end
				end
				
				4'b1100://orr
				begin
					ALUControl=3'b011;
						//S control
							if(funct[0])
								begin
									FlagW=2'b10;
								end
							else
								begin
									FlagW=2'b00;
								end
				end
				
				4'b1010://cmp
				begin
					ALUControl=3'b001;
						//S control
							if(funct[0])
								begin
									FlagW=2'b11;
								end
							else
								begin
									FlagW=2'b00;
								end
				end
				
				4'b1101://shift
				begin
				FlagW=2'b00;
					case(instr65)
						2'b00://shift left and I=0
						begin
						ALUControl=3'b101;
						end
						2'b01://shift right and I=0
						begin
						ALUControl=3'b100;
						end
					endcase
						
				end
			
				
		endcase
	end
	
	2'b01://memory
	begin
	FlagW=2'b00;
	PCs=0;
	ALUControl=3'b000;
	ALUSrc=1;
	ImmSrc=op;
	RegW=funct[0];
	MemW=~funct[0];
	RegSrc=~funct[0];
	
		case(funct[0])
			1'b1://load
			 begin
				MemToReg=1;
			 end
			1'b0://store
			 begin
			 end
		endcase
		
	end
	endcase
end




endmodule

module controller_singleCycle
	( 
	//input ports
   	input [1:0] OP,  
      input [5:0] Funct50,
		input [3:0] cond,
		input [3:0] ALUFlagsIn,
		input [3:0] Rd,
		input [1:0] instr65,
		input clk,
	//output ports
      output  [1:0] ImmSrc,  
      output  PCSrc,
		output  RegWrite,
		output  MemWrite,
		output  MemToReg,
		output  ALUSrc,
		output  RegSrc,
		output  [2:0] ALUControl,
		output  [3:0] ALUFLAGSout
	);  
	wire [1:0] w_FlagW;
	wire w_PCS;
	wire w_regW;
	wire w_memW;
	
//combine the controller submodules into one module
	controller_singleCycle_decoder my_decoder(.op(OP),.funct(Funct50),.rd(Rd),.instr65(instr65),.FlagW(w_FlagW),.PCs(w_PCS),.RegW(w_regW),.MemW(w_memW),.ImmSrc(ImmSrc),.MemToReg(MemToReg),.ALUSrc(ALUSrc),.RegSrc(RegSrc),.ALUControl(ALUControl));
	
	
	controller_singleCycle_condLogic my_condlog(.cond(cond),.ALUFLa(ALUFlagsIn),.FlagW(w_FlagW),.PCs(w_PCS),.RegW(w_regW),.MemW(w_memW),.PCSrc(PCSrc),.RegWrite(RegWrite),.MemWrite(MemWrite),.ALUFLAGS(ALUFLAGSout),.clk(clk));
	
	
 endmodule  */
 module controller_singleCycle
	( 
	//input ports
		input [1:0] OP,  
		input [5:0] Funct50,
		input [3:0] cond,
		input [3:0] ALUFlagsIn,
		input [3:0] Rd,
		input [1:0] instr65,
		input clk,
	//output ports
		output  reg [1:0] ImmSrc,  
		output  reg PCSrc,
		output  reg RegWrite,
		output  reg MemWrite,
		output  reg MemToReg,
		output  reg ALUSrc,
		output  reg RegSrc,
		output  reg [2:0] ALUControl,
		output  reg [3:0] ALUFLAGSout
	);  
	reg [1:0] FlagW;
	always @(posedge clk)
begin
		if(FlagW==2'b10)
			begin
				ALUFLAGSout[3:2]=ALUFlagsIn[3:2];
			end
			
		else if(FlagW==2'b01)
			begin
				ALUFLAGSout[1:0]=ALUFlagsIn[1:0];
			end
			
		else if(FlagW==2'b11)
			begin
				ALUFLAGSout=ALUFlagsIn;
			end
	
end
	
	
	
	always @(*)
	begin
	case(OP)
	2'b00://data processing
	begin //funct25=I
			//funct20=S
		PCSrc=0;
		MemToReg=0;
		MemWrite=0;
		RegSrc=0;
		
		if(Funct50[4:1]==4'b1010)//cmp 
			begin
			RegWrite=0;
			end
		else //otherwise
			begin
			RegWrite=1;
			end
			
		if(Funct50[4:1]==4'b1101)//shift 
			begin
			ImmSrc=2'b11;
			ALUSrc=1'b1;
			end
		else //otherwise
			begin
			ImmSrc=2'b00;
			ALUSrc=Funct50[5];
			end
	
	
		case(Funct50[4:1])
				4'b0100://add
				begin
						ALUControl=3'b000;
						//S control
							if(Funct50[0])
								begin
									FlagW=2'b11;
								end
							else
								begin
									FlagW=2'b00;
								end
				end
						
				4'b0010://sub
				begin
						ALUControl=3'b001;
						//S control
							if(Funct50[0])
								begin
									FlagW=2'b11;
								end
							else
								begin
									FlagW=2'b00;
								end
				end
				
				4'b0000://and
				begin
						ALUControl=3'b010;
						//S control
							if(Funct50[0])
								begin
									FlagW=2'b10;
								end
							else
								begin
									FlagW=2'b00;
								end
				end
				
				4'b1100://orr
				begin
					ALUControl=3'b011;
						//S control
							if(Funct50[0])
								begin
									FlagW=2'b10;
								end
							else
								begin
									FlagW=2'b00;
								end
				end
				
				4'b1010://cmp
				begin
					ALUControl=3'b001;
					FlagW=2'b11;
						
				end
				
				4'b1101://shift
				begin
				FlagW=2'b00;
					case(instr65)
						2'b00://shift left and I=0
						begin
						ALUControl=3'b101;
						end
						2'b01://shift right and I=0
						begin
						ALUControl=3'b100;
						end
					endcase
						
				end
			
				
		endcase
	end
	
	2'b01://memory
	begin
	FlagW=2'b00;
	PCSrc=0;
	ALUControl=3'b000;
	ALUSrc=1;
	ImmSrc=OP;
	RegWrite=Funct50[0];
	MemWrite=~Funct50[0];
	RegSrc=~Funct50[0];
	
		case(Funct50[0])
			1'b1://load
			 begin
				MemToReg=1;
			 end
			1'b0://store
			 begin
				MemToReg=0;
			 end
		endcase
		
	end
	endcase
end


	
	
 endmodule  
 
 
 
 