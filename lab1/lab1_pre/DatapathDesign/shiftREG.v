// Shift register with parallel and serial load
//: W-bit parallel input, 1-bit serial input left and 1-bit serial input righ
module shiftREG #(parameter W=4)(clk,rst,PS,RL,SIR,SIL,DATA,outREG); 
input clk,rst,PS,RL,SIR,SIL;
input [W-1:0] DATA;
output reg [W-1:0] outREG;
 
  always @(posedge clk) 
  begin 
    if (rst==1)
		begin
			outREG<=0;
		end
	else if(rst==0)
		begin
		
			if(PS==0)
				begin
					if(RL==0)//shift left
						begin
						
							outREG[W-1:0]<={outREG[W-2:0],SIR};
						end
					else if(RL==1)//shift right
						begin
							outREG[W-1:0]<={SIL,outREG[W-1:1]};
						end
				end
				
			else if(PS==1)//parallel input
				begin
					outREG<=DATA;//load is occurred
				end
		end
  end     
endmodule