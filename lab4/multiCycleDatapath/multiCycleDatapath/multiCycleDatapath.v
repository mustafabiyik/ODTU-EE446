module multiCycleDatapath(
	clk,
	rst,
	PCWrite,
	MemWrite,
	IRWrite,
	ImmSrc,
	RegWrite,
	ALUSrcA,
	AdrSrc,
	ALUControl,
	ALUSrcB,
	RegSrc,
	ResultSrc,
	ALU_flags,
	R1out,
	R2out
);


input wire	clk;
input wire	rst;
input wire	PCWrite;
input wire	MemWrite;
input wire	IRWrite;
input wire	ImmSrc;
input wire	RegWrite;
input wire	ALUSrcA;
input wire	[1:0] AdrSrc;
input wire	[3:0] ALUControl;
input wire	[1:0] ALUSrcB;
input wire	[2:0] RegSrc;
input wire	[1:0] ResultSrc;
output wire	[3:0] ALU_flags;
output wire	[7:0] R1out;
output wire	[7:0] R2out;

wire	[15:0] WREGout;
wire	[3:0] X;
wire	[7:0] SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_31;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	[7:0] SYNTHESIZED_WIRE_3;
wire	[7:0] SYNTHESIZED_WIRE_32;
wire	[2:0] SYNTHESIZED_WIRE_5;
wire	[2:0] SYNTHESIZED_WIRE_6;
wire	[7:0] SYNTHESIZED_WIRE_33;
wire	[7:0] SYNTHESIZED_WIRE_34;
wire	[7:0] SYNTHESIZED_WIRE_9;
wire	[15:0] SYNTHESIZED_WIRE_11;
wire	[2:0] SYNTHESIZED_WIRE_12;
wire	[2:0] SYNTHESIZED_WIRE_13;
wire	[2:0] SYNTHESIZED_WIRE_14;
wire	[7:0] SYNTHESIZED_WIRE_16;
wire	[7:0] SYNTHESIZED_WIRE_17;
wire	[7:0] SYNTHESIZED_WIRE_35;
wire	[7:0] SYNTHESIZED_WIRE_22;
wire	[7:0] SYNTHESIZED_WIRE_23;
wire	[7:0] SYNTHESIZED_WIRE_24;
wire	[7:0] SYNTHESIZED_WIRE_25;
wire	[15:0] SYNTHESIZED_WIRE_36;





InstDataMemMC	b2v_inst(
	.clk(clk),
	.memWE(MemWrite),
	.memA(SYNTHESIZED_WIRE_0),
	.memWD(SYNTHESIZED_WIRE_31),
	.memRD(SYNTHESIZED_WIRE_36));


simpleREG	b2v_inst10(
	.clk(clk),
	.rst(rst),
	.DATA(SYNTHESIZED_WIRE_2),
	.SREGout(SYNTHESIZED_WIRE_9));
	defparam	b2v_inst10.W = 8;


simpleREG	b2v_inst11(
	.clk(clk),
	.rst(rst),
	.DATA(SYNTHESIZED_WIRE_3),
	.SREGout(SYNTHESIZED_WIRE_31));
	defparam	b2v_inst11.W = 8;


simpleREG	b2v_inst12(
	.clk(clk),
	.rst(rst),
	.DATA(SYNTHESIZED_WIRE_32),
	.SREGout(SYNTHESIZED_WIRE_24));
	defparam	b2v_inst12.W = 8;


muxWTwoToOne	b2v_inst13(
	.s0(RegSrc[2]),
	.I0(SYNTHESIZED_WIRE_5),
	.I1(WREGout[7:5]),
	.out(SYNTHESIZED_WIRE_12));
	defparam	b2v_inst13.W = 3;


muxWTwoToOne	b2v_inst14(
	.s0(RegSrc[1]),
	.I0(WREGout[4:2]),
	.I1(WREGout[10:8]),
	.out(SYNTHESIZED_WIRE_13));
	defparam	b2v_inst14.W = 3;


muxWTwoToOne	b2v_inst15(
	.s0(RegSrc[0]),
	.I0(WREGout[10:8]),
	.I1(SYNTHESIZED_WIRE_6),
	.out(SYNTHESIZED_WIRE_14));
	defparam	b2v_inst15.W = 3;


muxWTwoToOne	b2v_inst16(
	.s0(RegSrc[0]),
	.I0(SYNTHESIZED_WIRE_33),
	.I1(SYNTHESIZED_WIRE_34),
	.out(SYNTHESIZED_WIRE_16));
	defparam	b2v_inst16.W = 8;


extendImm	b2v_inst17(
	.ImmSrc(ImmSrc),
	.Instr70(WREGout[7:0]),
	.extendedImm(SYNTHESIZED_WIRE_22));


muxWTwoToOne	b2v_inst18(
	.s0(ALUSrcA),
	.I0(SYNTHESIZED_WIRE_9),
	.I1(SYNTHESIZED_WIRE_34),
	.out(SYNTHESIZED_WIRE_17));
	defparam	b2v_inst18.W = 8;


shrinkImm	b2v_inst19(
	.Instr150(SYNTHESIZED_WIRE_11),
	.instr70(SYNTHESIZED_WIRE_25));


RegisterFileMC	b2v_inst2(
	.clk(clk),
	.rst(rst),
	.WE(RegWrite),
	.A1(SYNTHESIZED_WIRE_12),
	.A2(SYNTHESIZED_WIRE_13),
	.A3(SYNTHESIZED_WIRE_14),
	.R6(SYNTHESIZED_WIRE_33),
	.WD3(SYNTHESIZED_WIRE_16),
	.R1(R1out),
	.R2(R2out),
	.RD1(SYNTHESIZED_WIRE_2),
	.RD2(SYNTHESIZED_WIRE_3));


ConstantValueGenerator	b2v_inst20(
	.Data_on_Bus(SYNTHESIZED_WIRE_5));
	defparam	b2v_inst20.BUS_DATA = 3'b110;
	defparam	b2v_inst20.DATA_WIDTH = 3;


ConstantValueGenerator	b2v_inst21(
	.Data_on_Bus(SYNTHESIZED_WIRE_6));
	defparam	b2v_inst21.BUS_DATA = 3'b111;
	defparam	b2v_inst21.DATA_WIDTH = 3;


ConstantValueGenerator	b2v_inst22(
	.Data_on_Bus(SYNTHESIZED_WIRE_23));
	defparam	b2v_inst22.BUS_DATA = 3'b100;
	defparam	b2v_inst22.DATA_WIDTH = 8;


ALU_MC	b2v_inst3(
	.A(SYNTHESIZED_WIRE_17),
	.ALUcontrol(ALUControl),
	.B(SYNTHESIZED_WIRE_35),
	.N(X[3]),
	.Z(X[2]),
	.CO(X[1]),
	.OVF(X[0]),
	.Y(SYNTHESIZED_WIRE_32));
	defparam	b2v_inst3.W = 8;


muxWFourToOne	b2v_inst4(
	.s0(AdrSrc[0]),
	.s1(AdrSrc[1]),
	.I0(SYNTHESIZED_WIRE_34),
	.I1(SYNTHESIZED_WIRE_33),
	
	
	.out(SYNTHESIZED_WIRE_0));
	defparam	b2v_inst4.W = 8;


muxWFourToOne	b2v_inst5(
	.s0(ALUSrcB[0]),
	.s1(ALUSrcB[1]),
	.I0(SYNTHESIZED_WIRE_31),
	.I1(SYNTHESIZED_WIRE_22),
	.I2(SYNTHESIZED_WIRE_23),
	
	.out(SYNTHESIZED_WIRE_35));
	defparam	b2v_inst5.W = 8;


muxWFourToOne	b2v_inst6(
	.s0(ResultSrc[0]),
	.s1(ResultSrc[1]),
	.I0(SYNTHESIZED_WIRE_24),
	.I1(SYNTHESIZED_WIRE_25),
	.I2(SYNTHESIZED_WIRE_32),
	.I3(SYNTHESIZED_WIRE_35),
	.out(SYNTHESIZED_WIRE_33));
	defparam	b2v_inst6.W = 8;


writeEnableREG	b2v_inst7(
	.clk(clk),
	.rst(rst),
	.WE(IRWrite),
	.DATA(SYNTHESIZED_WIRE_36),
	.WREGout(WREGout));
	defparam	b2v_inst7.W = 16;


simpleREG	b2v_inst9(
	.clk(clk),
	.rst(rst),
	.DATA(SYNTHESIZED_WIRE_36),
	.SREGout(SYNTHESIZED_WIRE_11));
	defparam	b2v_inst9.W = 16;


writeEnableREG	b2v_PCregister(
	.clk(clk),
	.rst(rst),
	.WE(PCWrite),
	.DATA(SYNTHESIZED_WIRE_33),
	.WREGout(SYNTHESIZED_WIRE_34));
	defparam	b2v_PCregister.W = 8;

assign	ALU_flags = X;

endmodule
