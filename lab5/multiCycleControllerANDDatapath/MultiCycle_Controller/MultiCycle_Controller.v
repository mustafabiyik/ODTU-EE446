module MultiCycle_Controller(
//inputs
input [1:0]  cond,
input [1:0]  OP,
input [2:0]  type,
input [3:0]  flags,
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
output reg [1:0] ResultSrc
);

reg [2:0] state_counter=3'b000;
reg [3:0] FLAG_REG;

always @(posedge clk)
			begin
			
				if(RUN==1)
					 begin
						//fetch
						if(state_counter==3'b000)
							begin
								PCWrite=1;
								IRWrite=1;
								ALUSrcA=1;
								AdrSrc=2'b00;
								RegWrite=0;
								ALUControl=4'b0000;
								ALUSrcB=2'b10;
								ResultSrc=2'b10;
								state_counter=state_counter+3'b001;
							end
							
						//decode	
						else if(state_counter==3'b001)
							begin
								PCWrite=0;
								MemWrite=0;
								IRWrite=0;
								RegWrite=0;
								ALUSrcA=1;
								ALUControl=4'b0000;
								ALUSrcB=2'b10;
								//regSrc assignment
								if(OP==2'b11) //branch
									begin
										if(type==3'b000)//b
										begin
											RegSrc=3'b000;
										end
										
										else if(type==3'b001)//bl
										begin
											RegSrc=3'b001;
										end
										
										else if(type==3'b011)//beq
										begin
											RegSrc=3'b000;
										end
										
										else if(type==3'b100)//bne
										begin
											RegSrc=3'b000;
										end
										
										else if(type==3'b101)//bc
										begin
											RegSrc=3'b000;
										end
										else if(type==3'b110)//bnc
										begin
											RegSrc=3'b000;
										end
										else if(type==3'b010)//bi
										begin
											RegSrc=3'b101;
										end
									end
									
								else if(OP==2'b00) //data
									begin
										RegSrc=3'b100;
									end
								else if(OP==2'b01) //shift
									begin
										RegSrc=3'b100;
									end
									
								else if(OP==2'b10) //memory
									begin
									if(type[2:1]==2'b10)//str
										begin
										RegSrc=3'b110;
										end
									else // ldr/i
										begin
										RegSrc=3'b100;
										end
									end	
								
									
								state_counter=state_counter+3'b001;
							end
							
							//execution phase
						else if(state_counter==3'b010) //cycle 3
							begin
							
							if(OP==2'b00)//data
								begin
									ALUSrcA=0;
									
									case(type)
											3'b000: ALUControl=4'b0000; //add
											3'b010: ALUControl=4'b0001; //sub
											3'b100: ALUControl=4'b0010; //and
											3'b101: ALUControl=4'b0011; //orr
											3'b110: ALUControl=4'b0100; //xor
											3'b111: ALUControl=4'b0101; //clr
									endcase
									ALUSrcB=2'b00;
									RegSrc=3'b100;
									ResultSrc=2'b10;
									RegWrite=0;
									FLAG_REG=flags; //update the flags for data processing
									state_counter=state_counter+3'b001;
								end
							else if(OP==2'b01)//shift
								begin
									ALUSrcA=0;
									
									case(type)
											3'b000: ALUControl=4'b0110; //rol
											3'b001: ALUControl=4'b0111; //ror
											3'b010: ALUControl=4'b1000; //lsl
											3'b011: ALUControl=4'b1010; //asr
											3'b100: ALUControl=4'b1001; //lsr
									endcase
									ALUSrcB=2'b00;
									RegSrc=3'b100;
									ResultSrc=2'b10;
									RegWrite=0;
									FLAG_REG=flags;
									state_counter=state_counter+3'b001;
								end
							else if(OP==2'b10)//memory
								begin
									
									case(type[2:1])
									2'b00://ldr cycle 3 
										begin
											ImmSrc=0;
											ALUSrcB=2'b01;
											ALUSrcA=0;
											ALUControl=4'b0000;
											
											state_counter=state_counter+3'b001;
										end
									2'b01://ldi last cycle
										begin
											ImmSrc=1;
											ALUSrcB=2'b01;
											ResultSrc=2'b11;
											RegWrite=1;
											
											state_counter=3'b000;//go to next cycle
										end
									2'b10://str cycle 3
										begin
											ImmSrc=0;
											ALUSrcB=2'b01;
											ALUSrcA=0;
											ALUControl=4'b0000;
											
											state_counter=state_counter+3'b001;
										end
									endcase
								end
								
							else if(OP==2'b11)//branch cycle 3 last cycle
									begin
										case(type)
										3'b000: //und. branch
										begin
											PCWrite=1;
											ALUSrcA=0;
											ALUControl=4'b0000;
											ALUSrcB=2'b01;
											ResultSrc=2'b10;
											state_counter=3'b000;
										end
										
										3'b001: // branch link
										begin
											PCWrite=1;
											ALUSrcA=0;
											ALUControl=4'b0000;
											ALUSrcB=2'b01;
											ResultSrc=2'b10;
											RegWrite=1;
											state_counter=3'b000;
										
										end
										
										3'b011: //beq
										begin
										//branch cycle 3 equal means Z=1 nzcv
										//look at the FLAG_REG register value to decide execue or not
										if(FLAG_REG[2]==1)
										begin
											PCWrite=1;
										end
										else
										begin
										PCWrite=0;
										end

										ALUSrcA=0;
										ALUControl=4'b0000;
										ALUSrcB=2'b01;
										ResultSrc=2'b10;
										state_counter=3'b000;
										
										end
										
										3'b100: //bne
										//branch cycle 3 not equal means Z=0 nzcv
										begin
										if(FLAG_REG[2]==0)
										begin
											PCWrite=1;
										end
										else
										begin
										PCWrite=0;
										end

										ALUSrcA=0;
										ALUControl=4'b0000;
										ALUSrcB=2'b01;
										ResultSrc=2'b10;
										state_counter=3'b000;
										
										end
										
										3'b101: //bc
										begin
										//branch cycle 3 carry set means c=1 nzcv
										if(FLAG_REG[1]==1)
												begin
													PCWrite=1;
												end
										else
												begin
													PCWrite=0;
												end

										ALUSrcA=0;
										ALUControl=4'b0000;
										ALUSrcB=2'b01;
										ResultSrc=2'b10;
										state_counter=3'b000;
										end
										
										3'b110: //bnc
										begin
										//branch cycle 3 not carry set means c=0 nzcv
										if(FLAG_REG[1]==0)
												begin
													PCWrite=1;
												end
										else
												begin
													PCWrite=0;
												end

											ALUSrcA=0;
											ALUControl=4'b0000;
											ALUSrcB=2'b01;
											ResultSrc=2'b10;
											state_counter=3'b000;
										
										end
										
										3'b010: //bi
										begin
											ALUSrcB=2'b00;
											ResultSrc=2'b11;
											PCWrite=1;
											state_counter=3'b000;
										end
										
										3'b111: //end
										begin
											//RUN=0; //end of the instructions
											state_counter=3'b000;
										end
										endcase
									end
									
							end//cycle 3 ends
							
							//execution phase
							else if(state_counter==3'b011) //cycle 4
							begin
							
								if(OP[1]==1'b0)
								begin
									ResultSrc=2'b00;
									RegWrite=1;
									state_counter=3'b000;//data and shift end
								end
								else if(OP==2'b10)
								begin
									if(type[2:1]==2'b10)//str
											begin
											ResultSrc=2'b00;
											AdrSrc=2'b01;
											MemWrite=1;
											state_counter=3'b000; //end store 
											end
									else if(type[2:1]==2'b00) //ldr
											begin
												ResultSrc=2'b00;
												AdrSrc=2'b01;
												MemWrite=0;
												state_counter=state_counter+3'b001;//cycle 4 for the ldr
											end
									
								end
							end
							
							else if(state_counter==3'b100) //cycle 5
							begin
							ResultSrc=2'b01;
							RegWrite=1;
							state_counter=3'b000; //end ldr
							end
							
							
						
					 end//run
			
	
	end//always


endmodule


 
 
 
 