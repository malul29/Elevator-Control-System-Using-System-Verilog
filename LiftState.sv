// Submodule: Lift State Management
module LiftState(
  input clk, reset,
  input logic [7:0] requests,
  input logic [2:0] max_request, min_request,
  output logic [2:0] current_floor,
  output logic [1:0] Up, Down, idle
);
  initial begin
    current_floor = 0;
    Up = 2'b01;
    Down = 2'b00;
    idle = 2'b00;
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_floor <= 0;
      Up <= 2'b01;
      Down <= 2'b00;
      idle <= 2'b00;
    end else if (requests == 8'b0) begin
      idle <= 2'b01;
    end else begin
      if (max_request > current_floor) begin
        current_floor <= current_floor + 1;
        Up <= 2'b01;
        Down <= 2'b00;
        idle <= 2'b00;
      end else if (min_request < current_floor) begin
        current_floor <= current_floor - 1;
        Up <= 2'b00;
        Down <= 2'b01;
        idle <= 2'b00;
      end
    end
  end
endmodule
