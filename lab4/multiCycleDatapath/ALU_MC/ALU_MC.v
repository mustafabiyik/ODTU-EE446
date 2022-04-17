module ALU_MC #(parameter W=8) (ALUcontrol,A,B,Y,N,Z,CO,OVF);
//negative and zero bits are affected by ALU op
//CO and OVF are affected by arithmetics
input [3:0] ALUcontrol;
input [W-1:0] A,B;
output reg [W-1:0] Y; //output
output reg CO,OVF,N,Z; //cpsr
wire [W-1:0] Bcomp=~B; //bitwise not
wire [W-1:0] Acomp=~A; //bitwise not
reg E;
always @(*)
begin
	case(ALUcontrol)
	4'b0000: //add
	begin
		//update the overflow bit according to the signs
				{CO, Y} = A + B;
					if (A[W-1] ~^ B[W-1]) //if the signs are the same
						OVF = Y[W-1] ^ A[W-1];
					else
						OVF = 0;	
						
		
	end
	4'b0001: //subt a-b
	begin
//update the overflow bit according to the signs
					{CO, Y} = A + Bcomp+1;
					if ((A[W-1] ^ B[W-1]))
						OVF = Y[W-1] ^ A[W-1];
					else
						OVF = 0;
	end
	4'b0010: 
	begin   
			Y=A&B;   //and
			CO=0;
			OVF=0;

	end
	
		4'b0011: 
	begin   
	
			Y=A|B;   //or
			CO=0;
			OVF=0;
	
			
	end
		
		4'b0100: 
	begin   
	
			Y=A^B;   //xor
			CO=0;
			OVF=0;
	
			
	end
	
	4'b0101: 
	begin   
	
			Y=0;   //clear
			CO=0;
			OVF=0;
	
			
	end
	
	4'b0110: 
	begin   
	
			Y={A[6:0],A[7]};   //rol
			CO=0;
			OVF=0;
	
			
	end
	
		4'b0111: 
	begin   
	
			Y={A[0],A[7:1]};   //ror
			CO=0;
			OVF=0;
	
			
	end
	
	
	4'b1000:  //shift left lsl
	begin
		   Y=A<<1;
			CO=0;
			OVF=0;
	end

	4'b1001:  //shift right lsr
	begin
			Y=A>>1;
			CO=0;
			OVF=0;
	end

	
	4'b1010:	
	begin
			Y={A[7],A[7:1]};   //arithmetic shift right
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


