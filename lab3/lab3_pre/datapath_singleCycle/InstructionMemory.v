module InstructionMemory          
 (  
      input    		 [31:0]     CurrentPC,  
      output wire     [31:0]     Instruction  
 );  
 
 
 		wire [31:0] counterInst;
      reg [31:0] instr[15:0];  
		//if the PC 0 then implies first 32 bit instruction
		//if PC 4 then second instruction
		//PC 8 3 instruction
      //initialize the instructions
		initial  
      begin  
               instr[0] = 32'b0000_0000_0000_0000_0000_0000_0000_0000; 
					instr[1] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[2] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[3] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[4] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[5] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[6] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[7] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[8] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[9] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[10] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[11] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[12] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[13] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[14] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
					instr[15] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;	
		
		end
                
		assign counterInst={2'b00,CurrentPC[31:2]}; //it gives the instruction number because PC increases 4 by 4
      assign Instruction = instr[counterInst];  
 endmodule