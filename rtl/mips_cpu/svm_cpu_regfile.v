import codes::*;

module regfile (
    input logic clk,
    input logic reset_i,
    input regaddr_t addr_1_i,
    input regaddr_t addr_2_i,
    input regaddr_t addr_3_i,
    input size_t write_data_3_i,
    input logic write_enable_i,
    output size_t read_data_1_o,
    output size_t read_data_2_o,
    output size_t read_data_reg_t0_o
);

  // 32 times 32-bit registers
  size_t regs[31:0];

  assign read_data_1_o = regs[addr_1_i];
  assign read_data_2_o = regs[addr_2_i];
  assign read_data_reg_t0_o = regs[2];

  always_ff @(posedge clk) begin
    if (reset_i == 1) begin
      for (integer idx = 0; idx < 32; idx = idx + 1) begin
        regs[idx] <= 0;
      end
    end else if (write_enable_i == 1) begin
      if (addr_3_i != 0) begin
        regs[addr_3_i] <= write_data_3_i;
      end
    end
  end

endmodule
