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

endmodule
