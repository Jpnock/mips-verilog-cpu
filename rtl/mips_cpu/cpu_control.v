import codes::*;

module control (
    input state_t state_i,
    input opcode_t opcode_i,
    input func_t function_i,
    output logic pc_write_en_o,
    output logic ir_write_en_o,
    output logic ram_write_en_o,
    output logic ram_read_en_o,
    output logic src_b_sel_o,
    output logic ram_addr_sel_o,
    output logic regfile_writedata_sel_o,
    output logic regfile_write_en_o,
    output regfile_addr_sel_t regfile_addr_3_sel_o
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
    pc_write_en_o = isStateEXEC2;
    ir_write_en_o = isStateEXEC1;
    ram_write_en_o = 0;
    ram_read_en_o = isStateFETCH;
    src_b_sel_o = 0;
    ram_addr_sel_o = 0;
    regfile_writedata_sel_o = 0;
    regfile_write_en_o = 0;
    regfile_addr_3_sel_o = REGFILE_ADDR_SEL_RT;

    case (opcode_i)
      OP_SW: begin
        ram_write_en_o |= isStateEXEC2;
        src_b_sel_o |= isStateEXEC2;
        ram_addr_sel_o |= isStateEXEC2;
      end
      OP_LW: begin
        ram_read_en_o |= isStateEXEC1;
        src_b_sel_o |= isStateEXEC1;
        ram_addr_sel_o |= isStateEXEC1;
        regfile_write_en_o |= isStateEXEC2;
      end
      OP_ADDIU: begin
        regfile_write_en_o |= isStateEXEC2;
        src_b_sel_o |= isStateEXEC2;
        regfile_writedata_sel_o |= isStateEXEC2;
      end
      OP_SPECIAL: begin
        case (function_i)
          FUNC_JR: begin
          end
          FUNC_MTHI, MTLO: begin
            // TODO: Should not be needed. Remove when tested.
          end
          FUNC_ADDU, FUNC_MFHI, FUNC_MHLO: begin
            if (isStateEXEC2) begin
              regfile_write_en_o = 1;
              regfile_writedata_sel_o = 1;
              regfile_addr_3_sel_o = REGFILE_ADDR_SEL_RD;
            end
          end
          default: begin
            //$fatal(0, "Instruction undefined.");
          end
        endcase
      end
    endcase
  end
endmodule
