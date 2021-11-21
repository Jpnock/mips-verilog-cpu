import codes::*;

module ir (
    input logic clk,
    input logic wen_i,
    input logic reset_i,
    input size_t instr_i,
    output opcode_t opcode_o,
    output func_t funct_o,
    output regaddr_t rs_o,
    output regaddr_t rt_o,
    output regaddr_t rd_o,
    output logic [15:0] immediate_o
);

endmodule
