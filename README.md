# counter_module_practice
This SystemVerilog code represents a simple counter module with configurable width (WIDTH).

Inputs:
clk: Clock input
reset: Asynchronous reset input
enable: Counter enable signal
preload: Preload signal for initializing the counter to a specific value
preload_data: Data to be loaded into the counter when preload is active
mode: Counter mode (direction) control (0 for up-count, 1 for down-count)

Outputs:
detect: Output indicating when the counter reaches its maximum value (wraps around in up-count mode or reaches zero in down-count mode)
result: The counter value, which is an WIDTH-bit wide vector

Behavior:
The counter increments (result increases) on each positive clock edge when enable is active.
If preload is active, the counter is loaded with the value specified by preload_data on the next clock edge.
The counter can operate in two modes based on the value of mode:
When mode is 0 (up-count), the counter increments until it reaches its maximum value ({WIDTH{1'b1}}), at which point it wraps around to zero.
When mode is 1 (down-count), the counter decrements until it reaches zero, at which point it wraps around to its maximum value.

Detect Output:
The detect output is asserted (1'b1) when the counter reaches its maximum value (wraps around in up-count mode or reaches zero in down-count mode) and enable is active.

Reset:
The counter is asynchronously reset to zero when the reset signal is asserted.
This counter module provides a basic configurable-width counter with options for up-count or down-count modes, preload capability, and a detect signal to indicate when the counter has reached its maximum value.

Testcase 1: counter sanity check

Testcase 2: count to max value and see if detect goes HIGH (there is intentional bug)

Testcase 3: add code to detect bug and raise an error

Testcase 4: generate random number between 0:MAX and then disable the counter when that random number is reached

Testcase 5: resets the counter in the middle of counting

Testcase 6: reset and disable the counter simultaneously

Testcase 7: use init() task.sv file to intialize counter module and then count to random number to preload value 
