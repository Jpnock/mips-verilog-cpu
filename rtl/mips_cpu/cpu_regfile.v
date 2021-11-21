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
    output size_t read_data_2_o
);


  logic [31:0] rf[31:0];

  always_ff @(posedge clk) begin
    if (write_enable_i == 1) begin
      rf[addr_3_i] <= write_data_3_i;
    end
  end

  always_comb begin
    if (WEN == 0) begin
      read_data_1_o = rf[addr_1_i];
      read_data_2_o = rf[addr_2_i];
    end
  end

endmodule
