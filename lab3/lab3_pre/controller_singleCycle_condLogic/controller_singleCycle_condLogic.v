module controller_singleCycle_condLogic(
input [3:0] cond,
input [3:0] ALUFLa,
input [1:0] FlagW,
input  PCs,
input  RegW,
input  MemW,

output reg PCSrc,
output reg RegWrite,
output reg MemWrite,
output reg [3:0] ALUFLAGS,
input clk
);
//condex assumed as 1
reg condex;
always @(posedge clk)
begin
	if(condex==1)
		begin
		 if(FlagW[1]==1)
			begin
				ALUFLAGS[3:2]=ALUFLa[3:2];
			end
			
		else if(FlagW[0]==1)
			begin
				ALUFLAGS[1:0]=ALUFLa[1:0];
			end
		else
		 begin
			   ALUFLAGS=ALUFLAGS;
		 end		
	end
		else
		begin
			ALUFLAGS=ALUFLAGS;
		end
	
end
	
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

 PCSrc= condex & PCs;
 RegWrite= condex & RegW;
 MemWrite= condex & MemW;
end



endmodule


