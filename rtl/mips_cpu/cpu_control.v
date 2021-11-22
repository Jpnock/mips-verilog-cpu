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

  always_comb begin
    case (opcode_i)
      OP_SW: begin
        pc_wen_o = (state_i == EXEC2) ? 1 : 0;
        ir_wen_o = (state_i == EXEC1) ? 1 : 0;
        ram_wen_o = (state_i == EXEC2) ? 1 : 0;
        ram_rds_o = (state_i == FETCH) ? 1 : 0;
        reg_wen_o = 0;
        src_b_sel_o = (state_i == EXEC2) ? 1 : 0;
        ram_a_sel_o = (state_i == EXEC2) ? 1 : 0;
        reg_wd_sel_o = 1'bx;
        reg_a3_sel_o = 1'bx;
      end
      OP_LW: begin
        pc_wen_o = (state_i == EXEC2) ? 1 : 0;
        ir_wen_o = (state_i == EXEC1) ? 1 : 0;
        ram_wen_o = 0;
        ram_rds_o = ((state_i == FETCH) || (state == EXEC1)) ? 1 : 0;
        reg_wen_o = (state == EXEC2) ? 1 : 0;
        src_b_sel_o = (state_i == EXEC1) ? 1 : 0;
        ram_a_sel_o = (state_i == EXEC1) ? 1 : 0;
        reg_wd_sel_o = 0;
        reg_a3_sel_o = 0;
      end
      OP_ADDIU: begin
        pc_wen_o = (state_i == EXEC2) ? 1 : 0;
        ir_wen_o = (state_i == EXEC1) ? 1 : 0;
        ram_wen_o = 0;
        ram_rds_o = (state_i == FETCH) ? 1 : 0;
        reg_wen_o = (state == EXEC2) ? 1 : 0;
        src_b_sel_o = (state_i == EXEC2) ? 1 : 0;
        ram_a_sel_o = 0;
        reg_wd_sel_o = (state_i == EXEC2) ? 1 : 0;
        reg_a3_sel_o = 0;
      end
      OP_ADDU: begin
        pc_wen_o = (state_i == EXEC2) ? 1 : 0;
        ir_wen_o = (state_i == EXEC1) ? 1 : 0;
        ram_wen_o = 0;
        ram_rds_o = (state_i == FETCH) ? 1 : 0;
        reg_wen_o = (state == EXEC2) ? 1 : 0;
        src_b_sel_o = 0;
        ram_a_sel_o = 0;
        reg_wd_sel_o = (state_i == EXEC2) ? 1 : 0;
        reg_a3_sel_o = (state_i == EXEC2) ? 1 : 0;
      end
      OP_JR: begin
        pc_wen_o = (state_i == EXEC2) ? 1 : 0;
        ir_wen_o = (state_i == EXEC1) ? 1 : 0;
        ram_wen_o = 0;
        ram_rds_o = (state_i == FETCH) ? 1 : 0;
        reg_wen_o = 0;
        src_b_sel_o = 0;
        ram_a_sel_o = 0;
        reg_wd_sel_o = 0;
        reg_a3_sel_o = 0;
      end
      default: begin
        $fatal(0, "Instruction undefined.");
      end
    endcase
  end

endmodule
