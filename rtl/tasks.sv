// Task to initialize the counter and handle reset
task automatic init(output reg reset, input reg detect, output reg enable, 
          output reg preload, output reg [3:0] preload_data, output reg mode);
   reset = 1;
   reset = 0;
   detect = 1'b0;
   reset = 1;
   enable = 0;
   preload = 0;
   preload_data = 5;
   mode = 0;
endtask