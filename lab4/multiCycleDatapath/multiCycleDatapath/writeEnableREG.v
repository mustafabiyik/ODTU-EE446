module writeEnableREG #(parameter W=1) (DATA,clk,rst,WREGout,WE);
input rst,clk,WE;
input [W-1:0] DATA;
output reg [W-1:0] WREGout;


always @(posedge clk)//due to sync reset issue
begin
	if(rst==1)
		begin
			WREGout<=0;
		end
	else
		begin
		
			if(WE==1)
				begin
					WREGout<=DATA;
				end
			
		end

end

endmodule