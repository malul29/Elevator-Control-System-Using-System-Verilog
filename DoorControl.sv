// Submodule: Door Control
module DoorControl(
  input clk,
  input logic [2:0] current_floor,
  input logic [7:0] requests,
  output logic [1:0] door,
  output logic door_timer
);
  initial begin
    door = 2'b0;
    door_timer = 0;
  end

  always @(posedge clk) begin
    if (requests[current_floor] == 1) begin
      door = 2'b01; // Open door
      door_timer = 1;
    end else begin
      door = 2'b00; // Close door
      door_timer = 0;
    end
  end
endmodule
