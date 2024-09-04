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
  
  initial begin
      $monitor("t=%3t: result = %d, detect=%b", $time, result, detect);
      
      reset = 1;
      enable = 0;
      preload = 0;
      preload_data = 5;
      mode = 0;
     
      @(posedge clk) reset = 0;
      
      @(posedge clk);
      enable = 1;
     
      repeat(15) @(posedge clk);
        if (!detect && (result == (2**WIDTH - 1))) begin
          $display("Error: Detect signal asserted when counter reached its MAX value.");
          error_detected = 1;
      end
      enable = 0;
      
      repeat(5) @(posedge clk) $finish;
  end
  
  final begin
    	if (error_detected) begin
      		$display("Test Failed: Error detected during simulation.");
    	end else begin
      		$display("Test Passed: No errors detected during simulation.");
    		end
  		end
  

endprogram