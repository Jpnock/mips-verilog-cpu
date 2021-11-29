import codes::*;

module control (
    input state_t state_i,
    input opcode_t opcode_i,
    input func_t function_i,
    output logic pc_write_en_o,
    output logic ir_write_en_o,
    output logic ram_write_en_o,
    output logic ram_read_en_o,
    output logic [3:0] ram_byte_en_o,
    output logic ram_addr_sel_o,
    output logic src_b_sel_o,
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
    ram_byte_en_o = (state_i == FETCH) ? 4'b1111 : 0;
    ram_addr_sel_o = 0;
    src_b_sel_o = 0;
    regfile_write_en_o = 0;
    regfile_addr_3_sel_o = REGFILE_ADDR_SEL_RT;

    case (opcode_i)
      OP_SW, OP_SH, OP_SB: begin
        if (isStateEXEC2) begin
          ram_write_en_o = 1;
          src_b_sel_o = 1;
          ram_addr_sel_o = 1;
          ram_byte_en_o = (opcode_i == OP_SW) ? 4'b1111 : (opcode_i == OP_SH ? 4'b1100 : 4'b1000);
        end
      end
      OP_LW, OP_LH, OP_LB: begin
        if (isStateEXEC1) begin
          ram_read_en_o = 1;
          src_b_sel_o = 1;
          ram_addr_sel_o = 1;
          ram_byte_en_o = (opcode_i == OP_LW) ? 4'b1111 : (opcode_i == OP_LH ? 4'b1100 : 4'b1000);
        end
        regfile_write_en_o |= isStateEXEC2;
      end
      OP_ADDI, OP_ADDIU, OP_SLTI, OP_SLTIU, OP_ANDI, OP_ORI,  OP_XORI, OP_LUI: begin
        regfile_write_en_o |= isStateEXEC2;
        src_b_sel_o |= isStateEXEC2;
      end
      OP_SPECIAL: begin
        case (function_i)
          FUNC_SLL, FUNC_SRL, FUNC_SRA, FUNC_SLLV, FUNC_SRLV, FUNC_SRAV, 
          FUNC_MFHI, FUNC_MFLO,
          FUNC_ADD, FUNC_ADDU, FUNC_SUB, FUNC_SUBU, FUNC_AND, FUNC_OR, FUNC_XOR, FUNC_NOR,
          FUNC_SLT, FUNC_SLTU: begin
            if (isStateEXEC2) begin
              regfile_write_en_o   = 1;
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
