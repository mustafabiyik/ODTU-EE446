module lab3_exp(
input clk,
input rst,
output wire [3:0] Flag_outputs,
output wire [31:0] R1reg,
output wire [31:0] R2reg
);
 wire	w_PCSource;
 wire	w_MemToReg;
 wire	w_MemWrite;
 wire	w_RegWrite;
 wire	w_ALUSrc;
 wire	w_RegSrc;
 wire	[2:0] w_ALUControl;
 wire	[1:0] w_ImmSource;
 wire	[3:0] w_ALU_flags;
 wire	[3:0] w_cond;
 wire	[5:0] w_funct;
 wire	[1:0] w_instr65;
 wire	[1:0] w_op;
 wire	[3:0] w_rd;

controller_singleCycle my_controller( 
   	.OP(w_op),  
      .Funct50(w_funct),
		.cond(w_cond),
		.ALUFlagsIn(w_ALU_flags),
		.Rd(w_rd),
		.instr65(w_instr65),
		.clk(clk),
      .ImmSrc(w_ImmSource),  
      .PCSrc(w_PCSource),
		.RegWrite(w_RegWrite),
		.MemWrite(w_MemWrite),
		.MemToReg(w_MemToReg),
		.ALUSrc(w_ALUSrc),
		.RegSrc(w_RegSrc),
		.ALUControl(w_ALUControl),
		.ALUFLAGSout(Flag_outputs)
	); 
	
datapath_singleCycle my_datapath(
	.PCSource(w_PCSource),
	.rst(rst),
	.clk(clk),
	.MemToReg(w_MemToReg),
	.MemWrite(w_MemWrite),
	.RegWrite(w_RegWrite),
	.ALUSrc(w_ALUSrc),
	.RegSrc(w_RegSrc),
	.ALUControl(w_ALUControl),
	.ImmSource(w_ImmSource),
	.ALU_flags(w_ALU_flags),
	.cond(w_cond),
	.funct(w_funct),
	.instr65(w_instr65),
	.op(w_op),
	.rd(w_rd),
	.R1content(R1reg),
	.R2content(R2reg)
);
endmodule