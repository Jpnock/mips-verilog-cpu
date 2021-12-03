import codes::*;

module control (
    input logic clk,
    input logic stall_i,
    input state_t state_i,
    input opcode_t opcode_i,
    input func_t function_i,
    input regimm_t regimm_i,
    input logic b_cond_met_i,
    input logic [1:0] load_store_byte_offset_i,
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


  // State logic.
  logic isStateFETCH;
  logic isStateEXEC1;
  logic isStateEXEC2;

  assign isStateFETCH = (state_i == FETCH);
  assign isStateEXEC1 = (state_i == EXEC1);
  assign isStateEXEC2 = (state_i == EXEC2);

  // Valid readdata logic.
  logic stall_i_delayed;
  logic ram_read_en_o_delayed;
  logic ram_readdata_valid;

  always_ff @(posedge clk) begin
    stall_i_delayed <= stall_i;
    ram_read_en_o_delayed <= ram_read_en_o;
  end

  assign ram_readdata_valid = (~stall_i_delayed & ram_read_en_o_delayed);

  always_comb begin
    // Defaults
    pc_write_en_o = isStateEXEC2 & ~stall_i;
    ir_write_en_o = isStateEXEC1 & ram_readdata_valid;
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
          case (opcode_i)
            OP_SW: ram_byte_en_o = 4'b1111;
            OP_SH: ram_byte_en_o = 4'b0011 << load_store_byte_offset_i;
            OP_SB: ram_byte_en_o = 4'b0001 << load_store_byte_offset_i;
          endcase
`ifdef DEBUG
          $display("store: got offset of %d with byte enable of %04b", load_store_byte_offset_i,
                   ram_byte_en_o);
`endif
        end
      end
      OP_LW, OP_LH, OP_LHU, OP_LB, OP_LBU: begin
        if (isStateEXEC1) begin
          ram_read_en_o = 1;
          src_b_sel_o = 1;
          ram_addr_sel_o = 1;
          case (opcode_i)
            OP_LW: ram_byte_en_o = 4'b1111;
            OP_LH, OP_LHU: ram_byte_en_o = 4'b0011 << load_store_byte_offset_i;
            OP_LB, OP_LBU: ram_byte_en_o = 4'b0001 << load_store_byte_offset_i;
          endcase
        end
        regfile_write_en_o |= isStateEXEC2;
      end
      OP_ADDI, OP_ADDIU, OP_SLTI, OP_SLTIU, OP_ANDI, OP_ORI, OP_XORI, OP_LUI: begin
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

          FUNC_JALR: begin
            if (isStateEXEC2) begin
              regfile_write_en_o   = b_cond_met_i;
              regfile_addr_3_sel_o = REGFILE_ADDR_SEL_RD;
            end
          end
          default: begin
            //$fatal(0, "Instruction undefined.");
          end
        endcase
      end
      OP_JAL: begin
        if (isStateEXEC2) begin
          regfile_write_en_o   = b_cond_met_i;
          regfile_addr_3_sel_o = REGFILE_ADDR_SEL_GPR31;
        end
      end
      OP_REGIMM: begin
        case (regimm_i)
          REGIMM_BGEZAL, REGIMM_BLTZAL: begin
            if (isStateEXEC2) begin
              // MIPS will always write to the link register, regardless of if the branch condition is met!
              regfile_write_en_o   = 1;
              regfile_addr_3_sel_o = REGFILE_ADDR_SEL_GPR31;
            end
          end
        endcase
      end

    endcase

  end
endmodule
