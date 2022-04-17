module ALU #(parameter W=4) (ALUcontrol,A,B,Y,N,Z,CO,OVF);
//negative and zero bits are affected by ALU op
//CO and OVF are affected by arithmetics
input [2:0] ALUcontrol;
input [W-1:0] A,B;
output reg [W-1:0] Y; //output
output reg CO,OVF,N,Z; //cpsr
wire [W-1:0] Bcomp=~B; //bitwise not
wire [W-1:0] Acomp=~A; //bitwise not
reg E;
always @(*)
begin
	case(ALUcontrol)
	3'b000: //add
	begin
		//update the overflow bit according to the signs
				{CO, Y} = A + B;
					if (A[W-1] ~^ B[W-1]) //if the signs are the same
						OVF = Y[W-1] ^ A[W-1];
					else
						OVF = 0;	
						
		/*if(A[W-1]^B[W-1]==1)
			begin
				{E,Y[W-2:0]}=A[W-2:0]+Bcomp[W-2:0]+1;
				OVF=0;
				if(E==0)
					begin
					Y[W-2:0]=~Y[W-2:0];
					Y[W-2:0]=Y[W-2:0]+1;
					Y[W-1]=~Y[W-1];
					end
				else if(E==1)
					begin
						if(Y[W-2:0]==0)
						begin
							Y[W-1]=0;
						end
					end
			end
			
		else if(A[W-1]^B[W-1]==0)
			begin
			   {E,Y[W-2:0]}=A[W-2:0]+B[W-2:0];
				Y[W-1]=A[W-1];
				OVF=E;
			end*/
	end
	3'b001: //subt a-b
	begin
//update the overflow bit according to the signs
					{CO, Y} = A - B;
					if ((A[W-1] ^ B[W-1]))
						OVF = Y[W-1] ^ A[W-1];
					else
						OVF = 0;
	end
	3'b010: 
	begin   //subt b-a
	//update the overflow bit according to the signs
	
				{CO, Y} = B - A;
					if ((A[W-1] ^ B[W-1]))
						OVF = Y[W-1] ^ B[W-1];
					else
						OVF = 0;
	end
	3'b011:	
	begin
			Y=A&Bcomp; //bit clear	
			CO=0;
			OVF=0;
	end
	3'b100:  
	begin
			Y=A&B;   //and
			CO=0;
			OVF=0;
	end

	3'b101:  
	begin
			Y=A|B;   //or
			CO=0;
			OVF=0;
	end

	3'b110:	
	begin
			Y=A^B;   //exor
			CO=0;
			OVF=0;
	end

	3'b111:  
	begin
			Y=~(A^B);//exnor
			CO=0;
			OVF=0;
	end
	endcase
end


always @(*)
begin
		N = Y[W-1];
		Z = ~|Y;
end

endmodule


