// Submodule: Emergency Control
module EmergencyControl(
  input clk, reset, emergency_stop,
  output logic emergency_stopped,
  output logic flag
);
  initial begin
    emergency_stopped = 0;
    flag = 0;
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      emergency_stopped <= 0;
      flag <= 0;
    end else if (emergency_stop) begin
      emergency_stopped <= 1;
      flag <= 1;
    end else if (!emergency_stop && flag) begin
      emergency_stopped <= 0;
      flag <= 0;
    end
  end
endmodule