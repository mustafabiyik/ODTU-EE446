module datapath_controller_MC(
input clk,
input RESET,
input RUN,
output wire [7:0] R1reg,
output wire [7:0] R2reg
);

wire [1:0]  w_cond;
wire [1:0]  w_OP;
wire [2:0]  w_type;
wire		   w_PCWrite;
wire [1:0]  w_AdrSrc;
wire		   w_MemWrite;
wire		   w_IRWrite;
wire [2:0]  w_RegSrc;
wire		   w_RegWrite;
wire	 	   w_ImmSrc;
wire		   w_ALUSrcA;
wire [1:0]  w_ALUSrcB;
wire [3:0]  w_ALUControl;
wire [1:0]  w_ResultSrc;
wire [3:0]  w_flags;
wire [2:0]  w_Rd;

MultiCycle_Controller my_MC_controller(
//inputs
.cond(w_cond),
.OP(w_OP),
.type(w_type),
.flags(w_flags),
.Rd(w_Rd),
.RUN(RUN),
.clk(clk),
.PCWrite(w_PCWrite),
.AdrSrc(w_AdrSrc),
.MemWrite(w_MemWrite),
.IRWrite(w_IRWrite),
.RegSrc(w_RegSrc),
.RegWrite(w_RegWrite),
.ImmSrc(w_ImmSrc),
.ALUSrcA(w_ALUSrcA),
.ALUSrcB(w_ALUSrcB),
.ALUControl(w_ALUControl),
.ResultSrc(w_ResultSrc)
);


 multi_cycle_datapath my_MC_datapath(
	.clk(clk),
	.rst(RESET),
	.PCWrite(w_PCWrite),
	.MemWrite(w_MemWrite),
	.IRWrite(w_IRWrite),
	.ImmSrc(w_ImmSrc),
	.RegWrite(w_RegWrite),
	.ALUSrcA(w_ALUSrcA),
	.AdrSrc(w_AdrSrc),
	.ALUControl(w_ALUControl),
	.ALUSrcB(w_ALUSrcB),
	.RegSrc(w_RegSrc),
	.ResultSrc(w_ResultSrc),
	.R1out(R1reg),
	.R2out(R2reg),
	.ALU_flags(w_flags),
	.cond(w_cond),
	.OP(w_OP),
	.type(w_type),
	.Rd(w_Rd)
	
);

endmodule