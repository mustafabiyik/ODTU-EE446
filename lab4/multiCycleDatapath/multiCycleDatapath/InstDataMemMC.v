//DATA MEMORY

 module InstDataMemMC  
 (  	// input ports
      input                clk,  
      input     [7:0]      memA,//memory address according to the address write or read occur    
      input     [7:0]      memWD,//memory write data, it specifies the memory data which can be written  
      input                memWE,//memory write enable  
      // output port 
      output    [15:0]      memRD  
 );  
      
		
      reg 		 [15:0] 		 DATAmem  [255:0]; 	
		
		//also maximum PC value is 252
		//however PC values are 0-4-8...252
		//memWD values are extended to 16 bits 
		//initialize the memory
	
		integer i;  
      initial 
		  begin  
//instructionMemory initialization
//we have 16 bits in the memORY it is used instruction
//instructions
					DATAmem[0]	<=  16'b0000_0000_0000_0000;
					DATAmem[4]	<=  16'b0000_0000_0000_0000;
					DATAmem[8]	<=  16'b0000_0000_0000_0000;
					DATAmem[12]	<=  16'b0000_0000_0000_0000;
					DATAmem[16]	<=  16'b0000_0000_0000_0000;
					DATAmem[20]	<=  16'b0000_0000_0000_0000;
					DATAmem[24]	<=  16'b0000_0000_0000_0000;
					DATAmem[28]	<=  16'b0000_0000_0000_0000;
					DATAmem[32]	<=  16'b0000_0000_0000_0000;
					DATAmem[36]	<=  16'b0000_0000_0000_0000;
					DATAmem[40]	<=  16'b0000_0000_0000_0000;
					DATAmem[44]	<=  16'b0000_0000_0000_0000;
					DATAmem[48]	<=  16'b0000_0000_0000_0000;
					DATAmem[52]	<=  16'b0000_0000_0000_0000;
					DATAmem[56]	<=  16'b0000_0000_0000_0000;
					DATAmem[60]	<=  16'b0000_0000_0000_0000;
					DATAmem[64]	<=  16'b0000_0000_0000_0000;
					DATAmem[68]	<=  16'b0000_0000_0000_0000;
					DATAmem[72]	<=  16'b0000_0000_0000_0000;
					DATAmem[76]	<=  16'b0000_0000_0000_0000;
					DATAmem[80]	<=  16'b0000_0000_0000_0000;
					DATAmem[84]	<=  16'b0000_0000_0000_0000;
					DATAmem[88]	<=  16'b0000_0000_0000_0000;
					DATAmem[92]	<=  16'b0000_0000_0000_0000;
					DATAmem[96]	<=  16'b0000_0000_0000_0000;
					DATAmem[100]	<=  16'b0000_0000_0000_0000;
					DATAmem[104]	<=  16'b0000_0000_0000_0000;
					DATAmem[108]	<=  16'b0000_0000_0000_0000;
					DATAmem[112]	<=  16'b0000_0000_0000_0000;
					DATAmem[116]	<=  16'b0000_0000_0000_0000;
					DATAmem[120]	<=  16'b0000_0000_0000_0000;
					DATAmem[124]	<=  16'b0000_0000_0000_0000;
					DATAmem[128]	<=  16'b0000_0000_0000_0000;
					DATAmem[132]	<=  16'b0000_0000_0000_0000;
					DATAmem[136]	<=  16'b0000_0000_0000_0000;
					DATAmem[140]	<=  16'b0000_0000_0000_0000;
					DATAmem[100]	<=  16'b0000_0000_0000_0000;
					DATAmem[104]	<=  16'b0000_0000_0000_0000;
					DATAmem[108]	<=  16'b0000_0000_0000_0000;
					DATAmem[112]	<=  16'b0000_0000_0000_0000;
					DATAmem[116]	<=  16'b0000_0000_0000_0000;
					DATAmem[120]	<=  16'b0000_0000_0000_0000;
					DATAmem[124]	<=  16'b0000_0000_0000_0000;
					DATAmem[128]	<=  16'b0000_0000_0000_0000;
					DATAmem[132]	<=  16'b0000_0000_0000_0000;
					DATAmem[136]	<=  16'b0000_0000_0000_0000;
					DATAmem[140]	<=  16'b0000_0000_0000_0000;
					DATAmem[100]	<=  16'b0000_0000_0000_0000;
					DATAmem[104]	<=  16'b0000_0000_0000_0000;
					DATAmem[108]	<=  16'b0000_0000_0000_0000;
					DATAmem[112]	<=  16'b0000_0000_0000_0000;
					DATAmem[116]	<=  16'b0000_0000_0000_0000;
					DATAmem[120]	<=  16'b0000_0000_0000_0000;
					DATAmem[124]	<=  16'b0000_0000_0000_0000;
					DATAmem[128]	<=  16'b0000_0000_0000_0000;
					DATAmem[132]	<=  16'b0000_0000_0000_0000;
					DATAmem[136]	<=  16'b0000_0000_0000_0000;
					DATAmem[140]	<=  16'b0000_0000_0000_0000;
					DATAmem[144]	<=  16'b0000_0000_0000_0000;
					DATAmem[148]	<=  16'b0000_0000_0000_0000;
					DATAmem[152]	<=  16'b0000_0000_0000_0000;
					DATAmem[156]	<=  16'b0000_0000_0000_0000;
					DATAmem[160]	<=  16'b0000_0000_0000_0000;
					DATAmem[164]	<=  16'b0000_0000_0000_0000;
					DATAmem[168]	<=  16'b0000_0000_0000_0000;
					DATAmem[172]	<=  16'b0000_0000_0000_0000;
					DATAmem[176]	<=  16'b0000_0000_0000_0000;
					DATAmem[180]	<=  16'b0000_0000_0000_0000;
					DATAmem[184]	<=  16'b0000_0000_0000_0000;
					DATAmem[188]	<=  16'b0000_0000_0000_0000;
					DATAmem[192]	<=  16'b0000_0000_0000_0000;
					DATAmem[196]	<=  16'b0000_0000_0000_0000;
					DATAmem[200]	<=  16'b0000_0000_0000_0000;
					DATAmem[204]	<=  16'b0000_0000_0000_0000;
					DATAmem[208]	<=  16'b0000_0000_0000_0000;
					DATAmem[212]	<=  16'b0000_0000_0000_0000;
					DATAmem[216]	<=  16'b0000_0000_0000_0000;
					DATAmem[220]	<=  16'b0000_0000_0000_0000;
					DATAmem[224]	<=  16'b0000_0000_0000_0000;
					DATAmem[228]	<=  16'b0000_0000_0000_0000;
					DATAmem[232]	<=  16'b0000_0000_0000_0000;
					DATAmem[236]	<=  16'b0000_0000_0000_0000;
					DATAmem[240]	<=  16'b0000_0000_0000_0000;
					DATAmem[244]	<=  16'b0000_0000_0000_0000;
					DATAmem[248]	<=  16'b0000_0000_0000_0000;
					DATAmem[252]	<=  16'b0000_0000_0000_0000;
					
					
					
//data memory initialization
//data initialization
//instructions at the 0 4 8 12 ... 252 therefore others can be assigned randomly
           for(i=0;i<256;i=i+1)  
			  begin
					if(i%3'd4!=0)
						begin
							DATAmem[i] <= i; 
						end
			  end
                
		  end  
			/*	
		initial begin
		$readmemh("memory.txt",DATAmem,0,255);
		end 
					*/
    

		//memory write operation
      always @(posedge clk) begin  
           if (memWE)  
			  begin
                DATAmem[memA] <= {8'b0,memWD};//extended value is stored the memory 
			  end 
      end 
		
      assign memRD = DATAmem[memA]; //it provides the data which is specified by the address  
		
 endmodule  
 
 
 