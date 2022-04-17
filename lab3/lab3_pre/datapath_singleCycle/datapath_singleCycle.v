// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"
// CREATED		"Sat May 01 16:02:22 2021"

module datapath_singleCycle(
	PCSource,
	rst,
	clk,
	MemToReg,
	MemWrite,
	RegWrite,
	ALUSrc,
	RegSrc,
	ALUControl,
	ImmSource,
	ALU_flags,
	cond,
	funct,
	instr65,
	op,
	rd
);


input wire	PCSource;
input wire	rst;
input wire	clk;
input wire	MemToReg;
input wire	MemWrite;
input wire	RegWrite;
input wire	ALUSrc;
input wire	RegSrc;
input wire	[2:0] ALUControl;
input wire	[1:0] ImmSource;
output wire	[3:0] ALU_flags;
output wire	[3:0] cond;
output wire	[5:0] funct;
output wire	[1:0] instr65;
output wire	[1:0] op;
output wire	[3:0] rd;

wire	[3:0] A2;
wire	[3:0] ALUflags;
wire	[31:0] I0;
wire	[31:0] Instruction;
wire	[31:0] out;
wire	[31:0] REGout;
wire	[31:0] SYNTHESIZED_WIRE_0;
wire	[31:0] SYNTHESIZED_WIRE_1;
wire	[31:0] SYNTHESIZED_WIRE_2;
wire	[31:0] SYNTHESIZED_WIRE_12;
wire	[31:0] SYNTHESIZED_WIRE_4;
wire	[31:0] SYNTHESIZED_WIRE_5;
wire	[31:0] SYNTHESIZED_WIRE_6;
wire	[31:0] SYNTHESIZED_WIRE_13;
wire	[31:0] SYNTHESIZED_WIRE_10;
wire	[31:0] SYNTHESIZED_WIRE_11;





simpleREG	b2v_inst(
	.clk(clk),
	.rst(rst),
	.DATA(SYNTHESIZED_WIRE_0),
	.REGout(REGout));
	defparam	b2v_inst.W = 32;


ALU	b2v_inst10(
	.A(SYNTHESIZED_WIRE_1),
	.ALUcontrol(ALUControl),
	.B(SYNTHESIZED_WIRE_2),
	
	
	
	
	.Y(I0));
	defparam	b2v_inst10.W = 32;


adder32bits	b2v_inst11(
	.A(SYNTHESIZED_WIRE_12),
	.B(SYNTHESIZED_WIRE_4),
	.Y(SYNTHESIZED_WIRE_6));


adder32bits	b2v_inst12(
	.A(REGout),
	.B(SYNTHESIZED_WIRE_5),
	.Y(SYNTHESIZED_WIRE_12));


ConstantValueGenerator	b2v_inst13(
	.Data_on_Bus(SYNTHESIZED_WIRE_5));
	defparam	b2v_inst13.BUS_DATA = 3'b100;
	defparam	b2v_inst13.DATA_WIDTH = 32;


ConstantValueGenerator	b2v_inst14(
	.Data_on_Bus(SYNTHESIZED_WIRE_4));
	defparam	b2v_inst14.BUS_DATA = 3'b100;
	defparam	b2v_inst14.DATA_WIDTH = 32;


InstructionMemory	b2v_inst2(
	.CurrentPC(REGout),
	.Instruction(Instruction));


RegisterFile	b2v_inst3(
	.clk(clk),
	.rst(rst),
	.WE(RegWrite),
	.A1(Instruction[19:16]),
	.A2(A2),
	.A3(Instruction[15:12]),
	.R15(SYNTHESIZED_WIRE_6),
	.WD3(out),
	.RD1(SYNTHESIZED_WIRE_1),
	.RD2(SYNTHESIZED_WIRE_13));


dataMemory	b2v_inst4(
	.clk(clk),
	.memWE(MemWrite),
	.memA(I0),
	.memWD(SYNTHESIZED_WIRE_13),
	.memRD(SYNTHESIZED_WIRE_11));


extImm	b2v_inst5(
	.ImmSrc(ImmSource),
	.Instr110(Instruction[11:0]),
	.extendedImm(SYNTHESIZED_WIRE_10));


muxWTwoToOne	b2v_inst6(
	.s0(PCSource),
	.I0(SYNTHESIZED_WIRE_12),
	.I1(out),
	.out(SYNTHESIZED_WIRE_0));
	defparam	b2v_inst6.W = 32;


muxWTwoToOne	b2v_inst7(
	.s0(RegSrc),
	.I0(Instruction[3:0]),
	.I1(Instruction[15:12]),
	.out(A2));
	defparam	b2v_inst7.W = 4;


muxWTwoToOne	b2v_inst8(
	.s0(ALUSrc),
	.I0(SYNTHESIZED_WIRE_13),
	.I1(SYNTHESIZED_WIRE_10),
	.out(SYNTHESIZED_WIRE_2));
	defparam	b2v_inst8.W = 32;


muxWTwoToOne	b2v_inst9(
	.s0(MemToReg),
	.I0(I0),
	.I1(SYNTHESIZED_WIRE_11),
	.out(out));
	defparam	b2v_inst9.W = 32;

assign	cond[3:0] = Instruction[31:28];
assign	funct[5:0] = Instruction[25:20];
assign	instr65[1:0] = Instruction[6:5];
assign	op[1:0] = Instruction[27:26];
assign	rd[3:0] = Instruction[15:12];

endmodule
