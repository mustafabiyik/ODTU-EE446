module RegisterFileMC
 (   //input ports
      input                    clk,  
      input                    rst,  
      input                    WE,  //write enable signal
      input          [2:0]     A1 ,  
		input          [2:0]     A2,  
		input          [2:0]     A3,  
      input          [7:0]    WD3,  
      //output ports 
      output         [7:0]    RD1,    
      output         [7:0]    RD2,
		
		//demostration purposes
		output         [7:0]    R1,    
      output         [7:0]    R2,
		
		input 			[7:0]	   R6
 );  
      
		
		reg     			[7:0]    register_R [7:0]; //8 bits width and 8 bits length  
   
      always @ (posedge clk or posedge rst) begin  
		
           if(rst) begin  
			      //general purpose registers
               register_R[0] <= 8'b0;
					register_R[1] <= 8'b0;
					register_R[2] <= 8'b0;
					register_R[3] <= 8'b0;
					register_R[4] <= 8'b0;
					register_R[5] <= 8'b0;
					
					
					//link register
					register_R[7] <= 8'b0;
					
					//pc represent the r6
					
           end  
			  
           else 
			  begin  
                if(WE) 
					 begin
                     register_R[A3] <= WD3;  //if WE is equal to 1 then corresponding register is written
                end  
           end  
			  
      end  
      assign RD1 = (A1==3'b110) ? R6:register_R[A1];  //read data 1
      assign RD2 = register_R[A2];  //read data 2
		assign R1 = register_R[1]; 
      assign R2 = register_R[2]; 
 endmodule   
