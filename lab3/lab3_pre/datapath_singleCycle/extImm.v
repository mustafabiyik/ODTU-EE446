module extImm
(
//input port
input  [1:0] 	ImmSrc,
input  [11:0]	Instr110, 
//output port
output reg [31:0]  extendedImm
);


always @(*)
begin
case(ImmSrc)
	2'b00://for data processing imm8
	begin
		extendedImm= {24'b0,Instr110[7:0]};
	end
	
	2'b01://for ldr and strong0
	begin
		extendedImm= {20'b0,Instr110[11:0]};
	end

	2'b11://for lsr and lsl
	begin
		extendedImm= {27'b0,Instr110[11:7]};
	end
	default
	begin
		extendedImm={24'b0,Instr110[7:0]};
	end
endcase
end

endmodule