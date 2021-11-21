import codes::*;

module fsm (
    input logic clk,
    input logic reset_i,
    input logic stall_i,
    output logic [1:0] state_o
);

  // TODO: Check if we need to transition to the next state on the negedge of a stall.

  logic [1:0] state_d, state_q;

  always_comb begin
    if (reset_i == 1) begin
      state_d = FETCH;
    end else begin
      if (stall_i == 1) begin
        state_d = state_q;
      end else begin
        case (state_q)
          FETCH: state_d = EXEC1;
          EXEC1: state_d = EXEC2;
          EXEC2: state_d = FETCH;
          default: begin
            state_d = 0;
          end
        endcase
      end
    end
  end

  always_ff @(posedge clk) begin
    state_q <= state_d;
  end

  assign state_o = state_q;

endmodule
