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
		input 			[31:0]	 R15
 );  
      
		
		reg     			[31:0]    register_R [15:0]; //31 bits width and 16 bits length  
   
      always @ (posedge clk or posedge rst) begin  
		
           if(rst) begin  
               register_R[0] <= 31'b0;
					register_R[1] <= 31'b0;
					register_R[2] <= 31'b0;
					register_R[3] <= 31'b0;
					register_R[4] <= 31'b0;
					register_R[5] <= 31'b0;
					register_R[6] <= 31'b0;
					register_R[7] <= 31'b0;
					register_R[8] <= 31'b0;
					register_R[9] <= 31'b0;
					register_R[10] <= 31'b0;
					register_R[11] <= 31'b0;
					register_R[12] <= 31'b0;
					register_R[13] <= 31'b0;
					register_R[14] <= 31'b0;
					register_R[15] <= 31'b0;
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
 endmodule   
