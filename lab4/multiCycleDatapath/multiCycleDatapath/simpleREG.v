module simpleREG #(parameter W=1) (DATA,clk,rst,SREGout);
input rst,clk;
input [W-1:0] DATA;
output reg [W-1:0] SREGout;


always @(posedge clk)
begin
	if(rst==1)
		begin
			SREGout<=0;
		end
	else
		begin
		
			SREGout<=DATA;
		end

end

endmodule