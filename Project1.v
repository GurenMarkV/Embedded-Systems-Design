//Verilog module for Project
`timescale 1ns/1ps

module Project1(
    clk, rst, start,
	 x_in, u_in, y_in,
	 x_out, u_out, y_out
  );

//List the inputs and their sizes
	input clk, rst, start;
	input [7:0] x_in, u_in, y_in;

//List the outputs and their sizes 
   output integer x_out, u_out, y_out;

//Internal variables
// integer  [7:0] x_out, u_out, y_out, x_i, u_i, y_i;
//	integer  [7:0] rx4, rx2, rdx, r3, rudx, r3ux4_yx4, rux4_x4y;
//	integer  [7:0] ru_y;
	reg [7:0] min1, min2; 
	reg [15:0] tempmult;
	reg [7:0] ain1, ain2;
	reg [8:0] tempadd;
	
	//integer  x_out, u_out, y_out; 
	integer 	x_i, u_i, y_i;
	integer  rx4, rx2, rdx, r3, rudx, r3ux4_yx4, rux4_x4y;
	integer  ru_y;
	integer count = 0;
//List of Wires
	
	
// Declare state register and parameter
	reg [3:0] state;
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6;
	
//Instantiate Modules ----------------------------------------------------

//Multiplier
	lpmmult multiply(
	.clock(clk),
	.dataa(min1),
	.datab(min2),
	.result(mout));
	
//Adder
	adders adderss(
	.clock(clk),
	.data0x(ain1),
	.data1x(ain2),
	.result(aout));
	



//	always block
	always @ (posedge clk or posedge rst) begin
	
		// Determine the next state
		if (rst) begin
			rdx = 1;
			r3 = 6;
			x_i <= x_in;
			u_i <= u_in;
			y_i <= y_in;
		
			state <= S0;
		end
		else if(start) begin

		case (state)
			S0: begin
				// Multiplying using instantiated module
//				min1 <= x_i;
//				min2 <= x_i;
//				tempmult <= mout;
//				rx2 <= tempmult[15:8];
//				// Adding using instantiated module
//				ain1 <=x_i;
//				ain1 <=rdx;
//				tempadd <= aout;
//				if (tempadd[8] == 1) begin
//					x_out <= tempadd[8:1];
//				end else begin
//					x_out <= tempadd[7:0];
//				end
					
				
				rx2 <= x_i*x_i; //Multiplying using regular way
				x_out <= x_i+rdx; //Adding using regular way
				
				
					state <= S1;
					end// End State0
				
			S1: begin
				rx4 <= rx2*rx2;
				ru_y <= u_i+y_i;
//			Multiplying using instantiated module
//				min1 <= rx2;
//				min2 <= rx2;
//				tempmult <= mout;
//				rx4 <= tempmult[15:8];
//				
//			Adding using instantiated module
//				ain1 <=u_i;
//				ain1 <=y_i;
//				tempadd <= aout;
//				if (tempadd[8] == 1) begin
//					ru_y <= tempadd[8:1];
//				end else begin
//					ru_y <= tempadd[7:0];
//				end
				
					state <= S2;
					end// End State1
					
			S2: begin
				rux4_x4y <= rx4*ru_y;
				
//				min1 <= rx4;
//				min2 <= ru_y;
//				tempmult <= mout;
//				rux4_x4y <= tempmult[15:8];
					state <= S3;
					end// End State2
					
			S3: begin
				r3ux4_yx4 <= rux4_x4y*r3;
				
//				min1 <= rux4_x4y;
//				min2 <= r3;
//				tempmult <= mout;
//				r3ux4_yx4 <= tempmult[15:8];
				
					state <= S4;
					end// End State3
					
			S4: begin
				rudx <= u_i*rdx;
				u_out <= r3ux4_yx4+u_i;
				
//				min1 <= u_i;
//				min2 <= rdx;
//				tempmult <= mout;
//				rudx <= tempmult[15:8];
//				
//				// Adding using instantiated module
//				ain1 <=r3ux4_yx4;
//				ain1 <=u_i;
//				tempadd <= aout;
//				if (tempadd[8] == 1) begin
//					u_out <= tempadd[8:1];
//				end else begin
//					u_out <= tempadd[7:0];
//				end
					state <= S5;
					end// End State4
					
			S5: begin
				y_out <= rudx + y_i;
				
				// Adding using instantiated module
//				ain1 <=rudx;
//				ain1 <=y_i;
//				tempadd <= aout;
//				if (tempadd[8] == 1) begin
//					y_out <= tempadd[8:1];
//				end else begin
//					y_out <= tempadd[7:0];
//				end
					state <= S6;
					end// End State5
					
			S6: begin
				//Write output code Here
				if (count < 10) begin
					count = count + x_out;
					state <= S1;
					$display("Time %2d: x_out %1d is %2d", $time, x_out, y_out);
					#10;
				end 
					
				end// End State6
			default:
				state <= S0;
				
			endcase
		end
	
	end

endmodule

