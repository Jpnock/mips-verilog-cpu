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

  logic isStateFETCH;
  logic isStateEXEC1;
  logic isStateEXEC2;

  assign isStateFETCH = (state_i == FETCH);
  assign isStateEXEC1 = (state_i == EXEC1);
  assign isStateEXEC2 = (state_i == EXEC2);

  always_comb begin
    // Defaults
    pc_wen_o = isStateEXEC2;
    ir_wen_o = isStateEXEC1;
    ram_wen_o = 0;
    ram_rds_o = isStateFETCH;
    reg_wen_o = 0;
    src_b_sel_o = 0;
    ram_a_sel_o = 0;
    reg_wd_sel_o = 0;
    reg_a3_sel_o = 0;

    case (opcode_i)
      OP_SW: begin
        ram_wen_o |= isStateEXEC2;
        src_b_sel_o |= isStateEXEC2;
        ram_a_sel_o |= isStateEXEC2;
      end
      OP_LW: begin
        ram_rds_o |= isStateEXEC1;
        src_b_sel_o |= isStateEXEC1;
        ram_a_sel_o |= isStateEXEC1;
        reg_wen_o |= isStateEXEC2;
      end
      OP_ADDIU: begin
        reg_wen_o |= isStateEXEC2;
        src_b_sel_o |= isStateEXEC2;
        reg_wd_sel_o |= isStateEXEC2;
      end
      OP_SPECIAL: begin
        case (function_i)
          FUNC_JR: begin
          end
          FUNC_ADDU: begin
            reg_wen_o |= isStateEXEC2;
            reg_wd_sel_o |= isStateEXEC2;
            reg_a3_sel_o |= isStateEXEC2;
          end
          default: begin
            //$fatal(0, "Instruction undefined.");
          end
        endcase
      end
    endcase
  end
endmodule
