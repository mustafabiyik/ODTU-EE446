module writeEnableREG #(parameter W=1) (DATA,clk,rst,REG,WE);
input rst,clk,WE;
input [W-1:0] DATA;
output reg [W-1:0] REG;


always @(posedge clk)//due to sync reset issue
begin
	if(rst==1)
		begin
			REG<=0;
		end
	else
		begin
		
			if(WE==1)
				begin
					REG<=DATA;
				end
			
		end

end

endmodule