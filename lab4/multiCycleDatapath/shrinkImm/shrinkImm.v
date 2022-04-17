module shrinkImm
(

input  	 [15:0]	Instr150, 
//output port
output    [7:0]  instr70
);

assign instr70=Instr150[7:0];


endmodule