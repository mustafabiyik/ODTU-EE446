module simpleREG #(parameter W=1) (DATA,clk,rst,REG);
input rst,clk;
input [W-1:0] DATA;
output reg [W-1:0] REG;


always @(posedge clk)
begin
	if(rst==1)
		begin
			REG<=0;
		end
	else
		begin
		
			REG<=DATA;
		end

end

endmodule