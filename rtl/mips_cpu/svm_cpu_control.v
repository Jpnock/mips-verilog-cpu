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

  logic default_ram_write_en_o, tmp_ram_write_en_o;
  logic default_ram_read_en_o, tmp_ram_read_en_o;
  logic [3:0] default_ram_byte_en_o, tmp_ram_byte_en_o;
  logic default_ram_addr_sel_o, tmp_ram_addr_sel_o;
  logic default_src_b_sel_o, tmp_src_b_sel_o;
  logic default_regfile_write_en_o, tmp_regfile_write_en_o;
  regfile_addr_sel_t default_regfile_addr_3_sel_o, tmp_regfile_addr_3_sel_o;

  // Defaults
  assign pc_write_en_o                = isStateEXEC2 & ~stall_i;
  assign ir_write_en_o                = isStateEXEC1 & ram_readdata_valid;
  assign default_ram_write_en_o       = 0;
  assign default_ram_read_en_o        = isStateFETCH;
  assign default_ram_byte_en_o        = (state_i == FETCH) ? 4'b1111 : 0;
  assign default_ram_addr_sel_o       = 0;
  assign default_src_b_sel_o          = 0;
  assign default_regfile_write_en_o   = 0;
  assign default_regfile_addr_3_sel_o = REGFILE_ADDR_SEL_RT;

  always_comb begin
    tmp_ram_write_en_o       = default_ram_write_en_o;
    tmp_ram_read_en_o        = default_ram_read_en_o;
    tmp_ram_byte_en_o        = default_ram_byte_en_o;
    tmp_ram_addr_sel_o       = default_ram_addr_sel_o;
    tmp_src_b_sel_o          = default_src_b_sel_o;
    tmp_regfile_write_en_o   = default_regfile_write_en_o;
    tmp_regfile_addr_3_sel_o = default_regfile_addr_3_sel_o;

    case (opcode_i)
      OP_SW, OP_SH, OP_SB: begin
        if (isStateEXEC2) begin
          tmp_ram_write_en_o = 1;
          tmp_src_b_sel_o = 1;
          tmp_ram_addr_sel_o = 1;
          case (opcode_i)
            OP_SW: tmp_ram_byte_en_o = 4'b1111;
            OP_SH: tmp_ram_byte_en_o = 4'b0011 << load_store_byte_offset_i;
            OP_SB: tmp_ram_byte_en_o = 4'b0001 << load_store_byte_offset_i;
          endcase
`ifdef DEBUG
          $display("store: got offset of %d with byte enable of %04b", load_store_byte_offset_i,
                   tmp_ram_byte_en_o);
`endif
        end
      end
      OP_LW, OP_LH, OP_LHU, OP_LB, OP_LBU, OP_LWL, OP_LWR: begin
        if (isStateEXEC1) begin
          tmp_ram_read_en_o = 1;
          tmp_src_b_sel_o = 1;
          tmp_ram_addr_sel_o = 1;
          case (opcode_i)
            OP_LW: tmp_ram_byte_en_o = 4'b1111;
            OP_LH, OP_LHU: tmp_ram_byte_en_o = 4'b0011 << load_store_byte_offset_i;
            OP_LB, OP_LBU: tmp_ram_byte_en_o = 4'b0001 << load_store_byte_offset_i;
            OP_LWL: tmp_ram_byte_en_o = 4'b1111 << load_store_byte_offset_i;
            OP_LWR: tmp_ram_byte_en_o = 4'b1111 >> (3 - load_store_byte_offset_i);
          endcase
        end
        tmp_regfile_write_en_o = isStateEXEC2 | default_regfile_write_en_o;
      end
      OP_ADDI, OP_ADDIU, OP_SLTI, OP_SLTIU, OP_ANDI, OP_ORI, OP_XORI, OP_LUI: begin
        tmp_regfile_write_en_o = isStateEXEC2 | default_regfile_write_en_o;
        tmp_src_b_sel_o = isStateEXEC2 | default_src_b_sel_o;
      end
      OP_SPECIAL: begin
        case (function_i)
          FUNC_SLL, FUNC_SRL, FUNC_SRA, FUNC_SLLV, FUNC_SRLV, FUNC_SRAV, 
            FUNC_MFHI, FUNC_MFLO,
            FUNC_ADD, FUNC_ADDU, FUNC_SUB, FUNC_SUBU, FUNC_AND, FUNC_OR, FUNC_XOR, FUNC_NOR,
            FUNC_SLT, FUNC_SLTU, FUNC_JALR: begin
            if (isStateEXEC2) begin
              tmp_regfile_write_en_o   = 1;
              tmp_regfile_addr_3_sel_o = REGFILE_ADDR_SEL_RD;
            end
          end
          default: begin
            //$fatal(0, "Instruction undefined.");
          end
        endcase
      end
      OP_JAL: begin
        if (isStateEXEC2) begin
          tmp_regfile_write_en_o   = 1;
          tmp_regfile_addr_3_sel_o = REGFILE_ADDR_SEL_GPR31;
        end
      end
      OP_REGIMM: begin
        case (regimm_i)
          REGIMM_BGEZAL, REGIMM_BLTZAL: begin
            if (isStateEXEC2) begin
              // MIPS will always write to the link register, regardless of if the branch condition is met!
              tmp_regfile_write_en_o   = 1;
              tmp_regfile_addr_3_sel_o = REGFILE_ADDR_SEL_GPR31;
            end
          end
        endcase
      end

    endcase

    ram_write_en_o       = tmp_ram_write_en_o;
    ram_read_en_o        = tmp_ram_read_en_o;
    ram_byte_en_o        = tmp_ram_byte_en_o;
    ram_addr_sel_o       = tmp_ram_addr_sel_o;
    src_b_sel_o          = tmp_src_b_sel_o;
    regfile_write_en_o   = tmp_regfile_write_en_o;
    regfile_addr_3_sel_o = tmp_regfile_addr_3_sel_o;
  end
endmodule

