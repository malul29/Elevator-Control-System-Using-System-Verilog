// Submodule: Request Handler
module RequestHandler(
  input logic [2:0] req_floor,
  input logic [2:0] current_floor,
  output logic [7:0] requests,
  output logic [2:0] max_request,
  output logic [2:0] min_request
);
  initial begin
    requests = 8'b0;
    max_request = 3'b0;
    min_request = 3'b111;
  end

  always @(req_floor) begin
    requests[req_floor] = 1;
    if (max_request < req_floor) max_request = req_floor;
    if (min_request > req_floor) min_request = req_floor;

    if (requests[max_request] == 0 && req_floor > current_floor) 
      max_request = req_floor;
    if (requests[min_request] == 0 && req_floor < current_floor)
      min_request = req_floor;
  end
endmodule
