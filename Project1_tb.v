`timescale 1ns/1ps

module Project1_tb;

  reg clk, rst, start; // reset = active HIGH
  integer  x_in, u_in, y_in;
  wire [7:0] x_out, u_out, y_out;
  
  Project1 uut(
    .clk(clk), .rst(rst), .start(start),
	 .x_in(x_in), .u_in(u_in), .y_in(y_in),
	 .x_out(x_out), .u_out(u_out), .y_out(y_out)
  );
  
	initial begin   
		clk = 0;  
		forever #50 clk = ~clk;  
	end 

	initial begin
		#100;
		start = 0;
		x_in = 8'b00000010;
		u_in = 8'b00000100;
		y_in = 8'b00000100;
		rst = 1;
		#100;
		rst = 0;
		#100;
		start = 1;
		#100; 
	end

endmodule
