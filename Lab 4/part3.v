module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	input clock;
	input reset;
	input ParallelLoadn;
	input RotateRight;
	input ASRight;
	input [7:0] Data_IN;
	output [7:0] Q; 
	reg [7:0] w3; 
	always@(*)
	begin
		if(ASRight == 1'b0)
		w3[7] = Q[0];
		else
		w3[7] = Q[7];
		w3[6] = Q[7];
		w3[5] = Q[6];
		w3[4] = Q[5];
		w3[3] = Q[4];
		w3[2] = Q[3];
		w3[1] = Q[2];
		w3[0] = Q[1];
	end
	flipmux F0(.left(w3[0]), 
				  .right(Q[7]),
				  .LoadLeft(RotateRight),
				  .D(Data_IN[0]), 
				  .loadn(ParallelLoadn), 
				  .clock(clock), 
				  .reset(reset), 
				  .Q(Q[0]));
	flipmux F1(.left(w3[1]), 
				  .right(Q[0]),
				  .LoadLeft(RotateRight),
				  .D(Data_IN[1]), 
				  .loadn(ParallelLoadn), 
				  .clock(clock), 
				  .reset(reset), 
				  .Q(Q[1]));
	flipmux F2(.left(w3[2]), 
				  .right(Q[1]),
				  .LoadLeft(RotateRight),
				  .D(Data_IN[2]), 
				  .loadn(ParallelLoadn), 
				  .clock(clock), 
				  .reset(reset), 
				  .Q(Q[2]));
   flipmux F3(.left(w3[3]), 
				  .right(Q[2]),
				  .LoadLeft(RotateRight),
				  .D(Data_IN[3]), 
				  .loadn(ParallelLoadn), 
				  .clock(clock), 
				  .reset(reset), 
				  .Q(Q[3]));
	flipmux F4(.left(w3[4]), 
				  .right(Q[3]),
				  .LoadLeft(RotateRight),
				  .D(Data_IN[4]), 
				  .loadn(ParallelLoadn), 
				  .clock(clock), 
				  .reset(reset), 
				  .Q(Q[4]));
	flipmux F5(.left(w3[5]), 
				  .right(Q[4]),
				  .LoadLeft(RotateRight),
				  .D(Data_IN[5]), 
				  .loadn(ParallelLoadn), 
				  .clock(clock), 
				  .reset(reset), 
				  .Q(Q[5]));
	flipmux F6(.left(w3[6]), 
				  .right(Q[5]),
				  .LoadLeft(RotateRight),
				  .D(Data_IN[6]), 
				  .loadn(ParallelLoadn), 
				  .clock(clock), 
				  .reset(reset), 
				  .Q(Q[6]));
	flipmux F7(.left(w3[7]), 
				  .right(Q[6]),
				  .LoadLeft(RotateRight),
				  .D(Data_IN[7]), 
				  .loadn(ParallelLoadn), 
				  .clock(clock), 
				  .reset(reset), 
				  .Q(Q[7]));
	
endmodule



module mux(x, y, s, out);
    input x, y, s;
    output out;
    assign out = s ? y : x;
endmodule

module flipflop(d, q, clock, reset);
	input d;
	input clock;
	input reset;
	output reg q;
	always@(posedge clock)
	begin
		if(reset == 1'b1)
			q <= 1'b0;
		else
			q <= d;	
	end
endmodule

module flipmux(left, right, LoadLeft, D, loadn, clock, reset, Q);
	input left;
	input right;
	input LoadLeft;
	input D;
	input loadn;
	input clock;
	input reset;
	output Q;
	wire w1;
	wire w2;
	mux M0(.x(right),  
			 .y(left), 
			 .s(LoadLeft),
			 .out(w1));
	mux M1(.x(D),  
			 .y(w1), 
			 .s(loadn),
			 .out(w2));
	flipflop F0(.d(w2),
					.q(Q),
					.clock(clock),
					.reset(reset));
endmodule


