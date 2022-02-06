module part3(A, B, Function, ALUout);
	input [3:0] A;
	input [3:0] B;
	input [2:0] Function;
	output reg [7:0] ALUout;

	wire [7:0] w00; 
		
	part2 u00(
		.a(A[3:0]),
		.b(B[3:0]),
		.c_in(0),
		.s(w00[3:0]),
		.c_out(w00[7:4]) 
	);
	always@(*)
	begin
		case (Function[2:0])
			
			//0. using module 2 (connected by a wire)
			3'b000: ALUout = {{3'b000, w00[7]}, w00[3:0]}; 
			
			//1, A + B using verilog '+' operator
			3'b001: ALUout = A + B; 
			
			//2 sign extention of B to 8 bits
			3'b010: ALUout = {{4 { B[3] }} , B}; 
			
			//3 Output 8’b00000001 if at least 1 of the 8 bits is 1
			3'b011:	ALUout = (A || B) ;


			//4 true if all equal to zero
			3'b100:	ALUout = &{A, B}; 
								
			//5 use concatenate operator				
			3'b101: ALUout = {A,B}; 
			
			
			default: ALUout = {8'b00000000};
			
		endcase
	end
endmodule

module part2(a, b, c_in, s, c_out);
	input [3:0] a;
	input [3:0] b;
	input c_in;
	output [3:0] s;
	output [3:0] c_out;


	full_adder u0(
		.a(a[0]),
		.b(b[0]),
		.c_in(c_in),
		.s(s[0]),
		.c_out(c_out[0])
	);
	
	full_adder u1(
		.a(a[1]),
		.b(b[1]),
		.c_in(c_out[0]),
		.s(s[1]),
		.c_out(c_out[1])
	);
	
	full_adder u2(
		.a(a[2]),
		.b(b[2]),
		.c_in(c_out[1]),
		.s(s[2]),
		.c_out(c_out[2])
	);
	
	full_adder u3(
		.a(a[3]),
		.b(b[3]),
		.c_in(c_out[2]),
		.s(s[3]),
		.c_out(c_out[3])
	);
	
endmodule


module full_adder(a, b, c_in, s, c_out);
	input a;
	input b;
	input c_in;
	output s;
	output c_out;


	//assign s = a ^ b ^ c_in;
	assign s = (~c_in)*(~a)*b + (~c_in)*a*(~b) + c_in*(~a)*(~b) + c_in*a*b;
	assign c_out = a*b | c_in*a | c_in*b;
endmodule

module hex_decoder(c, display);
	input [3:0] c;
	output [6:0] display;
	
	//display[0]
	assign display[0] = ~((c[3]|c[2]|c[1]|~c[0]) & (c[3]|~c[2]|c[1]|c[0]) & (~c[3]|c[2]|~c[1]|~c[0]) & (~c[3]|~c[2]|c[1]|~c[0]));
	
	//display[1]
   	 assign display[1] = ~((c[3]|~c[2]|c[1]|~c[0]) & (c[3]|~c[2]|~c[1]|c[0]) &(~c[3]|c[2]|~c[1]|~c[0])
                                					& (~c[3]|~c[2]|c[1]|c[0]) & (~c[3]|~c[2]|~c[1]|c[0])
                                					& (~c[3]|~c[2]|~c[1]|~c[0]));
	
	
	//display[2]
	assign display[2] = ~((c[3]|c[2]|~c[1]|c[0]) & (~c[3]|~c[2]|c[1]|c[0])
								& (~c[3]|~c[2]|~c[1]|c[0]) & (~c[3]|~c[2]|~c[1]|~c[0]));
	
	
	//display[3]
	assign display[3] = ~((c[3]|c[2]|c[1]|~c[0]) & (c[3]|~c[2]|c[1]|c[0])
								& (c[3]|~c[2]|~c[1]|~c[0]) 
								& (~c[3]|c[2]|~c[1]|c[0]) & (~c[3]|~c[2]|~c[1]|~c[0]));

	
	//display[4]
	assign display[4] = ~((c[3]|c[2]|c[1]|~c[0]) & (c[3]|c[2]|~c[1]|~c[0])
								& (c[3]|~c[2]|c[1]|c[0]) & (c[3]|~c[2]|c[1]|~c[0])
								& (c[3]|~c[2]|~c[1]|~c[0]) & (~c[3]|c[2]|c[1]|~c[0]));
	
	
	//display[5]
	assign display[5] = ~((c[3]|c[2]|c[1]|~c[0]) & (c[3]|c[2]|~c[1]|c[0])
								& (c[3]|c[2]|~c[1]|~c[0]) & (c[3]|~c[2]|~c[1]|~c[0])
								& (~c[3]|~c[2]|c[1]|~c[0]));
	
	
	//display[6]
	assign display[6] = ~((c[3]|c[2]|c[1]|c[0]) & (c[3]|c[2]|c[1]|~c[0])
								& (c[3]|~c[2]|~c[1]|~c[0]) & (~c[3]|~c[2]|c[1]|c[0]));

endmodule