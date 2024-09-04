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
  reg [WIDTH-1:0] last_result; //used to hold the value when counter is stopped 
  int arb_value = $urandom_range(0,15);
  
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
     
    repeat(15) @(posedge clk) begin
    if (result == (arb_value)) begin
        enable = 0;
      	last_result = result;
        error_detected = 0;
      end
    end
      enable = 0;
    repeat(10) @(posedge clk) begin
      	$display("t=%3t: result = %d, detect=%b", $time, result, detect);
          if (result != last_result) begin
              $display("Error: Counter continued to count after being disabled");
              error_detected = 1;
          end
    end
    
    $finish;
  end
  
    final begin
    	if (error_detected) begin
      		$display("Test Failed: Error detected during simulation.");
    	end else begin
      		$display("Test Passed: No errors detected during simulation.");
    		end
  		end
  

endprogram