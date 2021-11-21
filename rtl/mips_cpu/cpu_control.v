import codes::*;

module control (
    input state_t state_i,
    input opcode_t opcode_i,
    input func_t function_i,
    output logic pc_wen_o,
    output logic ir_wen_o,
    output logic ram_wen_o,
    output logic ram_rds_o,
    output logic reg_wen_o,
    output logic src_b_sel_o,
    output logic ram_a_sel_o,
    output logic reg_wd_sel_o,
    output logic reg_a3_sel_o
);

endmodule
