import codes::*;

module alu (
    input logic clk,
    input logic reset_i,

    input opcode_t opcode_i,
    input func_t   funct_i,
    input regimm_t regimm_i,

    input size_t rs_i,
    input size_t rt_i,
    input logic [15:0] immediate_i,
    input logic [25:0] target_i,

    input size_t pc_i,

    input size_t ram_readdata_i,

    output logic [1:0] load_store_byte_offset_o,

    output size_t rd_o,
    output size_t rt_o,
    output size_t effective_address_o,
    output logic  b_cond_met_o,

    output size_t mfhi_o,
    output size_t mflo_o
);

  logic [63:0] mf_d, mf_q;

  assign mfhi_o = mf_q[63:32];
  assign mflo_o = mf_q[31:0];

  function automatic size_t signextend16to32(input [15:0] x);
    begin
      return ((x & 16'h8000) != 0) ? {16'hFFFF, x} : {16'b0, x};
    end
  endfunction

  function automatic size_t zeroextend16to32(input [15:0] x);
    begin
      return {16'b0, x};
    end
  endfunction

  function automatic size_t signextend8to32(input [7:0] x);
    begin
      return ((x & 8'h80) != 0) ? {24'hFFFFFF, x} : {24'b0, x};
    end
  endfunction

  size_t sign_extended_imm;
  size_t zero_extended_imm;

  assign sign_extended_imm = signextend16to32(immediate_i);
  assign zero_extended_imm = zeroextend16to32(immediate_i);

  logic [4:0] static_shift_amount;
  assign static_shift_amount = immediate_i[10:6];

  // Used for variable length shifts (register specified).
  // Obtained from the lower 5 bits of rs.
  logic [4:0] variable_shift_amount;
  assign variable_shift_amount = rs_i[4:0];

  size_t next_pc_i;
  assign next_pc_i = pc_i + 4;

  logic [3:0] next_pc_i_upper_4_bits;
  assign next_pc_i_upper_4_bits = next_pc_i[31:28];

  logic [27:0] word_target_i;
  assign word_target_i = {target_i, 2'b00};

  logic [4:0] load_store_bit_offset;
  assign load_store_bit_offset = {load_store_byte_offset_o, 3'b000};

  logic [7:0]
      ram_readdata_offset_0, ram_readdata_offset_1, ram_readdata_offset_2, ram_readdata_offset_3;
  assign ram_readdata_offset_0 = ram_readdata_i[31:24];
  assign ram_readdata_offset_1 = ram_readdata_i[23:16];
  assign ram_readdata_offset_2 = ram_readdata_i[15:8];
  assign ram_readdata_offset_3 = ram_readdata_i[7:0];

  size_t sign_extended_imm_plus_offset;
  assign sign_extended_imm_plus_offset = sign_extended_imm + rs_i;

  assign load_store_byte_offset_o = sign_extended_imm_plus_offset % 4;

  size_t load_store_effective_addr;
  assign load_store_effective_addr = sign_extended_imm_plus_offset & 32'hFFFFFFFC;

  // Instructions that affect the mf_d output.
  always_comb begin
    if (opcode_i == OP_SPECIAL) begin
      case (funct_i)
        FUNC_MULT: begin
          mf_d = $signed(rs_i) * $signed(rt_i);
        end
        FUNC_MULTU: begin
          mf_d = rs_i * rt_i;
        end
        FUNC_DIV: begin
          if (rt_i == 0) begin
            mf_d = 0;
          end else begin
            mf_d[31:0]  = $signed(rs_i) / $signed(rt_i);
            mf_d[63:32] = $signed(rs_i) % $signed(rt_i);
          end
        end
        FUNC_DIVU: begin
          if (rt_i == 0) begin
            mf_d = 0;
          end else begin
            mf_d[31:0]  = rs_i / rt_i;
            mf_d[63:32] = rs_i % rt_i;
          end
        end
        default: begin
          mf_d = 0;
        end
      endcase
    end else begin
      mf_d = 0;
    end
  end

  // Instructions that affect the rd_o output.
  always_comb begin
    case (opcode_i)
      OP_REGIMM: begin
        if (regimm_i == REGIMM_BGEZAL || regimm_i == REGIMM_BLTZAL) begin
          rd_o = pc_i + 8;
        end else begin
          rd_o = 0;
        end
      end
      OP_JAL: rd_o = pc_i + 8;
      OP_SPECIAL: begin
        case (funct_i)
          FUNC_JALR: rd_o = pc_i + 8;
          FUNC_SLL:  rd_o = rt_i << static_shift_amount;
          FUNC_SRL:  rd_o = rt_i >> static_shift_amount;
          FUNC_SRA:  rd_o = $signed(rt_i) >>> static_shift_amount;
          FUNC_SLLV: rd_o = rt_i << variable_shift_amount;
          FUNC_SRLV: rd_o = rt_i >> variable_shift_amount;
          FUNC_SRAV: rd_o = $signed(rt_i) >>> variable_shift_amount;
          FUNC_ADD: begin
            // TODO: fire exception on overflow
            rd_o = rs_i + rt_i;
          end
          FUNC_ADDU: rd_o = rs_i + rt_i;
          FUNC_SUB: begin
            // TODO: fire exception on overflow
            rd_o = rs_i - rt_i;
          end
          FUNC_SUBU: rd_o = rs_i - rt_i;
          FUNC_AND:  rd_o = rs_i & rt_i;
          FUNC_OR:   rd_o = rs_i | rt_i;
          FUNC_XOR:  rd_o = rs_i ^ rt_i;
          FUNC_NOR:  rd_o = rs_i~|rt_i;
          FUNC_SLT: begin
            if ($signed(rs_i) < $signed(rt_i)) begin
              rd_o = 1;
            end else begin
              rd_o = 0;
            end
          end
          FUNC_SLTU: begin
            if (rs_i < rt_i) begin
              rd_o = 1;
            end else begin
              rd_o = 0;
            end
          end
          default: begin
            rd_o = 0;
          end
        endcase
      end
      default: begin
        rd_o = 0;
      end
    endcase
  end

  // Instructions that affect the rt_o output
  always_comb begin
    case (opcode_i)
      OP_ADDI: begin
        // TODO: fire exception on overflow
        rt_o = rs_i + sign_extended_imm;
      end
      OP_ADDIU: rt_o = rs_i + sign_extended_imm;
      OP_SLTI: begin
        if ($signed(rs_i) < $signed(sign_extended_imm)) begin
          rt_o = 1;
        end else begin
          rt_o = 0;
        end
      end
      OP_SLTIU: begin
        // TODO: check the sign extension on this
        if (rs_i < sign_extended_imm) begin
          rt_o = 1;
        end else begin
          rt_o = 0;
        end
      end
      OP_ANDI:  rt_o = rs_i & zero_extended_imm;
      OP_ORI:   rt_o = rs_i | zero_extended_imm;
      OP_XORI:  rt_o = rs_i ^ zero_extended_imm;
      // TODO: LUI mentions something about sign extension but that doesn't make sense in this context.
      OP_LUI:   rt_o = {immediate_i, 16'b0};
      // We need to be careful here if we're doing non 32-bit store
      // operations (e.g. SH, SB). The representation of bytes or half-words
      // will always be presented from bit 32, downward. For example an SB which
      // stores 0xFF needs to be represented as 0xFF000000. A SH which stores
      // 0x4142 will be represented as 0x41420000. These values need shifting to
      // the correct location before outputting them. The same applies to loads,
      // however they may be handled elsewhere.
      OP_LWL: begin
        rt_o = (ram_readdata_i << load_store_bit_offset) | (rt_i & (32'hFFFFFFFF >> (32-load_store_bit_offset)));
      end
      OP_LWR: begin
        rt_o = (ram_readdata_i >> (24 - load_store_bit_offset)) | (rt_i & (32'hFFFFFF00 << load_store_bit_offset));
      end
      OP_LW: begin
        rt_o = ram_readdata_i;
      end
      OP_LH: begin
        case (load_store_byte_offset_o)
          0: rt_o = signextend16to32({ram_readdata_offset_0, ram_readdata_offset_1});
          default: rt_o = signextend16to32({ram_readdata_offset_2, ram_readdata_offset_3});
        endcase
`ifdef DEBUG
        $display("LH: got 0x%08x (orignally 0x%08x) with offset %d", rt_o, ram_readdata_i,
                 load_store_byte_offset_o);
`endif
      end
      OP_LHU: begin
        case (load_store_byte_offset_o)
          0: rt_o = zeroextend16to32({ram_readdata_offset_0, ram_readdata_offset_1});
          default: rt_o = zeroextend16to32({ram_readdata_offset_2, ram_readdata_offset_3});
        endcase
      end
      OP_LB: begin
        case (load_store_byte_offset_o)
          0: rt_o = signextend8to32(ram_readdata_offset_0);
          1: rt_o = signextend8to32(ram_readdata_offset_1);
          2: rt_o = signextend8to32(ram_readdata_offset_2);
          default: rt_o = signextend8to32(ram_readdata_offset_3);
        endcase
`ifdef DEBUG
        $display("got LB instruction data 0x%08x @ 0x%08x, loading byte 0x%08x with offset %d",
                 ram_readdata_i, effective_address_o, rt_o, load_store_byte_offset_o);
`endif
      end
      OP_LBU: begin
        case (load_store_byte_offset_o)
          0: rt_o = {24'b0, ram_readdata_offset_0};
          1: rt_o = {24'b0, ram_readdata_offset_1};
          2: rt_o = {24'b0, ram_readdata_offset_2};
          default: rt_o = {24'b0, ram_readdata_offset_3};
        endcase
      end
      OP_SW: begin
        rt_o = rt_i;
      end
      OP_SH: begin
        rt_o = (load_store_byte_offset_o == 0) ? (rt_i << 16) : (rt_i & 32'h0000FFFF);
      end
      OP_SB: begin
        case (load_store_byte_offset_o)
          0: rt_o = (rt_i << 24) & 32'hFF000000;
          1: rt_o = (rt_i << 16) & 32'h00FF0000;
          2: rt_o = (rt_i << 8) & 32'h0000FF00;
          default: rt_o = rt_i & 32'h000000FF;
        endcase
      end
      default: begin
        rt_o = 0;
      end
    endcase
  end

  // Calculate whether the branch condition is met.
  always_comb begin
    case (opcode_i)
      OP_BEQ:  b_cond_met_o = (rs_i == rt_i) ? 1'b1 : 1'b0;
      OP_BGTZ: b_cond_met_o = ($signed(rs_i) > 0) ? 1'b1 : 1'b0;
      OP_BLEZ: b_cond_met_o = ($signed(rs_i) <= 0) ? 1'b1 : 1'b0;
      OP_BNE:  b_cond_met_o = (rs_i != rt_i) ? 1'b1 : 1'b0;

      OP_J, OP_JAL: b_cond_met_o = 1'b1;
      OP_SPECIAL: begin
        case (funct_i)
          FUNC_JR, FUNC_JALR: b_cond_met_o = 1'b1;
          default: b_cond_met_o = 0;
        endcase
      end

      OP_REGIMM: begin
        case (regimm_i)
          // BGEZAL and BLTZAL must not use GBR[31]/$ra as the register to test the
          // jump condition from. This seems to be a compiler restriction, though. 
          REGIMM_BLTZ, REGIMM_BLTZAL: b_cond_met_o = ($signed(rs_i) < 0) ? 1'b1 : 1'b0;
          REGIMM_BGEZ, REGIMM_BGEZAL: b_cond_met_o = ($signed(rs_i) >= 0) ? 1'b1 : 1'b0;
          default: b_cond_met_o = 0;
        endcase
      end

      default: b_cond_met_o = 0;
    endcase
  end

  // Determine effective address for loads, stores, jumps and branches.
  always_comb begin
    case (opcode_i)
      OP_LWL, OP_LWR, OP_LW, OP_LH, OP_LHU, OP_LB, OP_LBU, OP_SW, OP_SH, OP_SB: begin
        effective_address_o = load_store_effective_addr;
      end

      // branch is relative to branch delay slot
      OP_BEQ, OP_BGTZ, OP_BLEZ, OP_BNE: effective_address_o = (sign_extended_imm << 2) + pc_i + 4;
      OP_REGIMM: begin
        case (regimm_i)
          REGIMM_BLTZ, REGIMM_BGEZ, REGIMM_BLTZAL, REGIMM_BGEZAL: begin
            effective_address_o = (sign_extended_imm << 2) + pc_i + 4;
          end
          default: begin
            effective_address_o = 0;
          end
        endcase
      end

      // PC region jumps
      // These instructions use the upper four bits of the branch delay slot.
      OP_J, OP_JAL: effective_address_o = {next_pc_i_upper_4_bits, word_target_i};

      // register jumps
      OP_SPECIAL: begin
        case (funct_i)
          FUNC_JALR, FUNC_JR: effective_address_o = rs_i;
          default: effective_address_o = 0;
        endcase
      end
      default: begin
        effective_address_o = 0;
      end
    endcase
  end

  always_ff @(posedge clk) begin
    if (reset_i == 1) begin
      mf_q <= 0;
    end else if (opcode_i == OP_SPECIAL) begin
      case (funct_i)
        FUNC_MULT, FUNC_MULTU, FUNC_DIV, FUNC_DIVU: begin
          mf_q <= mf_d;
        end
        FUNC_MTHI: mf_q[63:32] <= rs_i;
        FUNC_MTLO: mf_q[31:0] <= rs_i;
      endcase
    end
  end

endmodule
