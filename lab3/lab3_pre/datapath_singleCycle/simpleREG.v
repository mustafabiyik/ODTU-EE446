module simpleREG #(parameter W=1) (DATA,clk,rst,REGout);
input rst,clk;
input [W-1:0] DATA;
output reg [W-1:0] REGout;
initial
begin
REGout=32'b0;
end

always @(posedge clk)
begin
	if(rst==1)
		begin
			REGout<=0;
		end
	else
		begin
		
			REGout<=DATA;
		end

end

endmodule