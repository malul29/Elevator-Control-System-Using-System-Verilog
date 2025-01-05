// Top-Level Module
module Lift8(
  input clk, reset, emergency_stop,
  input logic [2:0] req_floor,
  output logic [1:0] door,
  output logic [2:0] max_request,
  output logic [2:0] min_request,
  output logic [1:0] Up,
  output logic [1:0] Down,
  output logic [1:0] idle,
  output logic [2:0] current_floor,
  output logic [7:0] requests
);

  // Internal signals
  logic door_timer;
  logic emergency_stopped;
  logic flag;

  // Submodules
  RequestHandler req_handler(
    .req_floor(req_floor),
    .current_floor(current_floor),
    .requests(requests),
    .max_request(max_request),
    .min_request(min_request)
  );

  DoorControl door_ctrl(
    .clk(clk),
    .current_floor(current_floor),
    .requests(requests),
    .door(door),
    .door_timer(door_timer)
  );

  EmergencyControl emergency_ctrl(
    .clk(clk),
    .reset(reset),
    .emergency_stop(emergency_stop),
    .emergency_stopped(emergency_stopped),
    .flag(flag)
  );

  LiftState lift_state(
    .clk(clk),
    .reset(reset),
    .requests(requests),
    .current_floor(current_floor),
    .max_request(max_request),
    .min_request(min_request),
    .Up(Up),
    .Down(Down),
    .idle(idle)
  );

endmodule
