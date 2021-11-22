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

  // TODO: Add logic for more instructions.

  always_comb begin
    pc_wen_o = (state_i == EXEC2) ? 1 : 0;
    ir_wen_o = (state_i == EXEC1) ? 1 : 0;
    case (opcode_i)
      OP_SW: begin
        ram_wen_o = (state_i == EXEC2) ? 1 : 0;
        ram_rds_o = (state_i == FETCH) ? 1 : 0;
        reg_wen_o = 0;
        src_b_sel_o = (state_i == EXEC2) ? 1 : 0;
        ram_a_sel_o = (state_i == EXEC2) ? 1 : 0;
        reg_wd_sel_o = 1'bx;
        reg_a3_sel_o = 1'bx;
      end
      OP_LW: begin
        ram_wen_o = 0;
        ram_rds_o = ((state_i == FETCH) || (state_i == EXEC1)) ? 1 : 0;
        reg_wen_o = (state_i == EXEC2) ? 1 : 0;
        src_b_sel_o = (state_i == EXEC1) ? 1 : 0;
        ram_a_sel_o = (state_i == EXEC1) ? 1 : 0;
        reg_wd_sel_o = 0;
        reg_a3_sel_o = 0;
      end
      OP_ADDIU: begin
        ram_wen_o = 0;
        ram_rds_o = (state_i == FETCH) ? 1 : 0;
        reg_wen_o = (state_i == EXEC2) ? 1 : 0;
        src_b_sel_o = (state_i == EXEC2) ? 1 : 0;
        ram_a_sel_o = 0;
        reg_wd_sel_o = (state_i == EXEC2) ? 1 : 0;
        reg_a3_sel_o = 0;
      end
      OP_SPECIAL: begin
        case (function_i)
          FUNC_JR: begin
            ram_wen_o = 0;
            ram_rds_o = (state_i == FETCH) ? 1 : 0;
            reg_wen_o = 0;
            src_b_sel_o = 0;
            ram_a_sel_o = 0;
            reg_wd_sel_o = 0;
            reg_a3_sel_o = 0;
          end
          FUNC_ADDU: begin
            ram_wen_o = 0;
            ram_rds_o = (state_i == FETCH) ? 1 : 0;
            reg_wen_o = (state_i == EXEC2) ? 1 : 0;
            src_b_sel_o = 0;
            ram_a_sel_o = 0;
            reg_wd_sel_o = (state_i == EXEC2) ? 1 : 0;
            reg_a3_sel_o = (state_i == EXEC2) ? 1 : 0;
          end
          default: begin
            $fatal(0, "Instruction undefined.");
          end
        endcase
      end
      default: begin
        $fatal(0, "Instruction undefined.");
      end
    endcase
  end
endmodule
