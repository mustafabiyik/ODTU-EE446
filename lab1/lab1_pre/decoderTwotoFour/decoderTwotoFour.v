/*
2 to 4 Decoder
1. Implement a 2 to 4 decoder.
*/

module decoderTwotoFour(in0,in1,en,out0,out1,out2,out3);
//port declaretions
input in0,in1,en;
output out0,out1,out2,out3;

assign out0= (~in1) & (~in0) & en;
assign out1= (~in1) & in0 & en;
assign out2= in1 & (~ in0) & en;
assign out3= in1 & in0 & en;

endmodule

//2. Write a test bench module to test your implementation
/*
module decoder_2to4_tb;
//inputs are reg 
//outputs are wire
reg in0,in1,en;
wire out0,out1,out2,out3;

decoder_2to4 DUT(in0,in1,en,out0,out1,out2,out3);

initial
	begin
	#10 in1=0; in0=0; en=0;
	#10 in1=0; in0=1; en=0;
	#10 in1=1; in0=0; en=0;
	#10 in1=1; in0=1; en=0;
	#10 in1=0; in0=0; en=1;
	#10 in1=0; in0=1; en=1;
	#10 in1=1; in0=0; en=1;
	#10 in1=1; in0=1; en=1;
	end
endmodule*/