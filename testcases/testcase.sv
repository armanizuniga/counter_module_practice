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
  
  initial begin
      //Display to console when any of these signals change 
      $monitor("t=%3t: result = %d, detect=%b", $time, result, detect);
      
      reset = 1;
      enable = 0;
      preload = 0; // not preloading for sanity check
      preload_data = 5; //not used
      mode = 0; // used to decrease count and not increase 
     
      @(posedge clk) reset = 0;
      @(posedge clk); //wait a clock cycle to enable counter 
    
      enable = 1;
    
      repeat(10) @(posedge clk); // run counter for 10 clock cycles
    
      enable = 0; // disable counter
      
      repeat(5) @(posedge clk) $finish;
  end
endprogram