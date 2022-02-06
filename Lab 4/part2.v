module part2(Clock, Reset_b, Data, Function, ALUout);
	input Clock;
	input Reset_b;
	input [3:0] Data;
	input [2:0] Function;
	wire [4:0] sum;
	output reg [7:0] ALUout;
	reg [7:0] q;
	wire [3:0]B;
	wire [3:0]A;
	assign B = ALUout[3:0];
	assign A = Data[3:0];
	wire [3:0] coutput;
	
	bitadder u0(
		.a(Data),
		.b(B),
		.c_in(1'b0),
		.s(sum[3:0]),
		.c_out(coutput)
	);
	assign sum[4] = coutput[3];
	
	always@(posedge Clock)
	begin
		if(Reset_b == 1'b0)
			ALUout <= 8'b00000000;
		else
			ALUout <= q;	
	end
	always@(*)
	begin
		case(Function)
			3'b000: q = 8'b00000000 + sum;
			3'b001: q = 8'b00000000 + A + B;
			3'b010: q = {{4 {B[3]}}, B};
			3'b011: q = 8'b00000000 + |{A, B};
			3'b100: q = 8'b00000000 + &{A, B};
			3'b101: q = 8'b00000000 + B << A;
			3'b110: q = 8'b00000000 +  A * B;
			3'b111: q = q;
			default: q = q;
		endcase
	end
endmodule

module bitadder(a, b, c_in, s, c_out);
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
    input a, b, c_in;
    output c_out, s;


    wire w;
    mux u0(
        .x(b),
        .y(c_in),
        .s(w),
        .out(c_out)
    );

    assign w = a ^ b;
    assign s = w ^ c_in;
endmodule

module mux(x, y, s, out);
    input x, y, s;
    output out;

    assign out = s ? y : x;
endmodule
