module part2(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;

    mux2to1 u0(
        .x(SW[0]),
        .y(SW[1]),
        .s(SW[9]),
        .m(LEDR[0])
        );
endmodule

module mux2to1(x, y, s, m);
	input x;
	input y;
	input s;
	output m;
	
	wire w1;
	wire w2;
	wire w3;
	  
   v7404 u0(  // NOT for s
        .pin1(s), 
		  .pin2(w1)
        );
	v7408 u1( // 2 AND operations for x, ~s and y, s
		.pin1(w1),
		.pin2(x),
		.pin3(w2),
		.pin4(y),
		.pin5(s),
		.pin6(w3)
		);
		
	v7432 u2( // Final OR operation
		.pin1(w2),
		.pin2(w3),
		.pin3(m)
		);

endmodule

module v7404 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8,
     pin10, pin12);  //NOT gate
	  
	  input pin1;
	  input pin3;
	  input pin5;
	  input pin13;
	  input pin11;
	  input pin9;
	  
	  output pin2;
	  output pin4;
	  output pin6;
	  output pin12;
	  output pin10;
	  output pin8;
	  
	  assign pin2 = ~pin1;
	  assign pin4 = ~pin3;
	  assign pin6 = ~pin5;
	  assign pin12 = ~pin13;
	  assign pin10 = ~pin11;
	  assign pin8 = ~pin9;
	  
endmodule

module v7408 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8,
     pin10, pin12); // AND Gate
	  
	  input pin1;
	  input pin2;
	  input pin4;
	  input pin5;
	  input pin9;
	  input pin10;
	  input pin12;
	  input pin13;
		
	  output pin3;
	  output pin6;
	  output pin8;
	  output pin11;
	  
	  assign pin3 = pin1 & pin2;
	  assign pin6 = pin4&pin5;
	  assign pin8 = pin9&pin10;
	  assign pin11 = pin12&pin13;
	  
endmodule

module v7432 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8,
     pin10, pin12); // OR Gate
	  
	  input pin1;
	  input pin2;
	  input pin4;
	  input pin5;
	  input pin9;
	  input pin10;
	  input pin12;
	  input pin13;
		
	  output pin3;
	  output pin6;
	  output pin8;
	  output pin11;
	  
	  assign pin3 = pin1 | pin2;
	  assign pin6 = pin4 | pin5;
	  assign pin8 = pin9 | pin10;
	  assign pin11 = pin12 | pin13;
	  
endmodule
