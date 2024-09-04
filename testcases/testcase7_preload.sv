`include "tasks.sv"

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
  int condition_met = 0;
  
  initial begin
    $monitor("t=%3t: result = %d, detect=%b", $time, result, detect);
      $display("arb_value: %d", arb_value);
      init(reset, detect, enable, preload, preload_data, mode);
     
      @(posedge clk) reset = 0;
      
      @(posedge clk);
      enable = 1;
     
    for (iteration_count = 0; iteration_count < 15; iteration_count++) begin
    	@(posedge clk);
        if (result == arb_value) begin
            $display("Counter reached arb_value at t=%3t", $time);
            
            // Trigger preload
            preload = 1;
            @(posedge clk); // Wait for one clock cycle
            preload = 0;
            
            // Check if preload occurred correctly
            @(negedge clk); // Check after the clock edge
            if (result != preload_data) begin
                $display("Error: Preload failed. Expected %d, got %d", preload_data, result);
                error_detected = 1;
            end
            else
                $display("Preload successful. Counter value: %d", result);
            end
    	end
    
    enable = 0;
 
    repeat(10) @(posedge clk)$finish;
   
    end
  
    final begin
    	if (error_detected) begin
      		$display("Test Failed: Error detected during simulation.");
    	end else begin
      		$display("Test Passed: No errors detected during simulation.");
    		end
  		end
  

endprogram