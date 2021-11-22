import codes::*;

module ir (
      input clk,
      input state_t state_o,
      input logic wen_i,
      input logic reset_i,
      input size_t instr_i,
      output opcode_t opcode_o,
      output funct_t funct_o,
      output logic[4:0] shift_o;
      output regaddr_t rs_o,
      output regaddr_t rt_o,
      output regaddr_t rd_o,
      output logic[15:0] immediate_o,
      output logic[25:0] target_o
);

    // The register that holds the instruction in EXEC2 and the next FETCH
    size_t ihold;
    size_t data;

    always_ff @(posedge clk) begin
        if (state_o == EXEC1) begin
            ihold <= instr_i;
        end
    end 

    always_comb begin
        if (state_o == EXEC1) begin
            data = instr_i;
        end else begin
            data = ihold;
        end
      opcode_o = data[31:26];
      target_o = data[25:0];
      rs_o = data[25:21];
      rt_o = data[20:16];
      rd_o = data[15:11];
      immediate_o = data[15:0];
      shift_o = data[10:6];
      funct_o = data[5:0];
    end


endmodule
