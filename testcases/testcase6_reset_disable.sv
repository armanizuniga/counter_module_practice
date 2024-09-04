program testcase #(parameter WIDTH=4)
  			   (//Inputs
               input clk,
               output reg reset,
               output reg enable,
               output reg preload,
               output reg [WIDTH-1:0] preload_data,
               output reg mode,

               //Outputs
               input detect,
               input [WIDTH-1:0] result);
  
  reg error_detected;
  int arb_value = $urandom_range(0,15);
  int iteration_count = 0;
  
  initial begin
      $monitor("t=%3t: result = %d, detect=%b", $time, result, detect);
      $display("Arbitrary value: %d", arb_value);
      reset = 1;
      enable = 0;
      preload = 0;
      preload_data = 5;
      mode = 0;
     
      @(posedge clk) reset = 0;
      
      @(posedge clk);
      enable = 1;
     
	  for (iteration_count = 0; iteration_count < 15; iteration_count++) begin
    	@(posedge clk);
    		if (result == arb_value) begin
        		fork
                  #1 reset = 1;
                  #1 enable = 0;
                join
              	#1 reset = 0;
    		end
		end
 
    repeat(10) @(posedge clk) $finish;
  end

endprogram