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
      $monitor("t=%3t: result = %d, detect=%b", $time, result, detect);
      
      reset = 1;
      enable = 0;
      preload = 0;
      preload_data = 5;
      mode = 0;
     
      @(posedge clk) reset = 0;
      @(posedge clk);
    
      enable = 1;
     
      repeat(15) @(posedge clk); // allow counter to run for 15 clock cycles to count up to MAX
    
      enable = 0;
      
      repeat(5) @(posedge clk) $finish;
  end
  
endprogram