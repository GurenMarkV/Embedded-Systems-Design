`timescale 1ns/1ps

module testbench;

  reg clk;
  
  Assign3_104002276 uut(
    .clk(clk), .PC(pc), .ALUOut(aluout)
  );
  
	initial begin   
		clk = 0;  
		forever #50 clk = ~clk;  
	end 

	initial begin
		#100;
		
	end

endmodule
