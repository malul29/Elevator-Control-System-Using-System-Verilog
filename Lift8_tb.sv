// Testbench
module Lift8_tb;
  logic clk, reset, emergency_stop;
  logic [2:0] req_floor;
  logic [1:0] door;
  logic [2:0] max_request, min_request;
  logic [1:0] Up, Down, idle;
  logic [2:0] current_floor;
  logic [7:0] requests;

  // Instantiate the DUT (Device Under Test)
  Lift8 dut (
    .clk(clk),
    .reset(reset),
    .emergency_stop(emergency_stop),
    .req_floor(req_floor),
    .door(door),
    .max_request(max_request),
    .min_request(min_request),
    .Up(Up),
    .Down(Down),
    .idle(idle),
    .current_floor(current_floor),
    .requests(requests)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Complex test scenario
  initial begin
    // Initialize inputs
    reset = 1;
    emergency_stop = 0;
    req_floor = 0;
    #10 reset = 0;

    // Scenario 1: Multiple floor requests
    req_floor = 3; // Request floor 3
    #10 req_floor = 5; // Request floor 5
    #10 req_floor = 1; // Request floor 1
    #20 req_floor = 0; // Clear requests

    // Scenario 2: Emergency stop while moving
    #10 emergency_stop = 1; // Activate emergency stop
    #10 emergency_stop = 0; // Deactivate emergency stop

    // Scenario 3: Reset system mid-operation
    #20 reset = 1; // Trigger system reset
    #10 reset = 0; // Release reset

    // Scenario 4: Idle state with no requests
    #30;

    // Scenario 5: Rapid sequential requests
    req_floor = 7; // Request floor 7
    #5 req_floor = 2; // Request floor 2
    #5 req_floor = 6; // Request floor 6

    // Scenario 6: Emergency stop with multiple requests
    #20 emergency_stop = 1;
    #10 emergency_stop = 0;

    // Finish simulation
    #50 $finish;
  end

  // Monitor outputs
  initial begin
    $monitor("Time: %0t | Current Floor: %0d | Door: %0b | Up: %0b | Down: %0b | Idle: %0b | Requests: %0b", 
             $time, current_floor, door, Up, Down, idle, requests);
  end
endmodule
