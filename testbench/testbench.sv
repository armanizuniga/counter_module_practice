
module testbench();
  	
  	// Define WIDTH as a local parameter
  	localparam WIDTH = 4; // Adjust the width according to your design
    	// Define testbench inputs and outputs
	reg clk, reset, enable, preload, mode;
	reg [WIDTH-1:0] preload_data;
	wire detect;
	wire [WIDTH-1:0] result;
  
  	initial begin
  	// Provide a free-running clock in the testbench
  		clk = 0;
  		forever #5 clk = ~clk;
	end

	// Instantiate the counter module
	counter #(WIDTH) myCounter (
  	.clk(clk),
  	.reset(reset),
  	.enable(enable),
  	.preload(preload),
  	.preload_data(preload_data),
  	.mode(mode),
  	.detect(detect),
  	.result(result)
	);
  
  // Intantiate the testcase 
  testcase #(WIDTH) itestcase (
    	.clk(clk),
  	.reset(reset),
  	.enable(enable),
  	.preload(preload),
  	.preload_data(preload_data),
  	.mode(mode),
  	.detect(detect),
  	.result(result)
  );
	
endmodule