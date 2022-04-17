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