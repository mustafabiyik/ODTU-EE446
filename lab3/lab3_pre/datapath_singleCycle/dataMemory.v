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
                DATAmem[i] <= 32'd0; 
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