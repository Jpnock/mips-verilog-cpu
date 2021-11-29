import codes::*;

module alu (
    input logic clk,
    input logic reset_i,

    input full_op_t full_op_i,
    input opcode_t opcode_i,
    input func_t funct_i,

    input size_t rs_i,
    input size_t rt_i,
    input logic [15:0] immediate_i,
    input logic [25:0] target_i,

    input size_t pc_i,

    input size_t ram_readdata_i,

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
      return x[15] == 1 ? {16'hFFFF, x} : {16'b0, x};
    end
  endfunction

  function automatic size_t zeroextend16to32(input [15:0] x);
    begin
      return {16'b0, x};
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

  //assign effective_address_o   = sign_extended_imm + rs_i;

  always_comb begin
    case (opcode_i)
      OP_SPECIAL: begin
        case (funct_i)
          FUNC_SLL:  rd_o = rt_i << static_shift_amount;
          FUNC_SRL:  rd_o = rt_i >> static_shift_amount;
          FUNC_SRA:  rd_o = rt_i >>> static_shift_amount;
          FUNC_SLLV: rd_o = rt_i << variable_shift_amount;
          FUNC_SRLV: rd_o = rt_i >> variable_shift_amount;
          FUNC_SRAV: rd_o = rt_i >>> variable_shift_amount;
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
          //FUNC_NOR:  rd_o = rs_i~|rt_i;
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
        endcase
      end

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
      // TODO: For to fix some build errors I just moved the effective_address assignment here
      // to each load and store instruction, since the branch instruction also uses it. 
      // Perhaps they should use different wires?
      OP_LW: begin
        effective_address_o = sign_extended_imm + rs_i;
        rt_o = ram_readdata_i;
      end
      OP_LH: begin
        effective_address_o = sign_extended_imm + rs_i;
        rt_o = ram_readdata_i >> 16;
      end
      OP_LB: begin
        effective_address_o = sign_extended_imm + rs_i;
        rt_o = ram_readdata_i >> 24;
      end
      OP_SW: begin
        effective_address_o = sign_extended_imm + rs_i;
        rt_o = rt_i;
      end
      OP_SH: begin
        effective_address_o = sign_extended_imm + rs_i;
        rt_o = rt_i << 16;
      end
      OP_SB: begin
        effective_address_o = sign_extended_imm + rs_i;
        rt_o = rt_i << 24;
      end
      // TODO: we need to be careful here if we're doing non 32-bit store
      // operations (e.g. SH, SB). The representation of bytes or half-words
      // will always be presented from bit 32, downward. For example an SB which
      // stores 0xFF needs to be represented as 0xFF000000. A SH which stores
      // 0x4142 will be represented as 0x41420000. These values need shifting to
      // the correct location before outputting them. The same applies to loads,
      // however they may be handled elsewhere.
      default:  ;
    endcase



    // BGEZAL and BLTZAL must not use GBR[31]/$ra as the register to test the
    // jump condition from. This seems to be a compiler restriction, though. 

    // branch condition
    casex (full_op_i)
      FOP_BEQ: b_cond_met_o = (rs_i == rt_i) ? 1'b1 : 1'b0;
      FOP_BGEZ: b_cond_met_o = (rs_i >= 0) ? 1'b1 : 1'b0;
      FOP_BGTZ: b_cond_met_o = (rs_i > 0) ? 1'b1 : 1'b0;
      FOP_BLEZ: b_cond_met_o = (rs_i <= 0) ? 1'b1 : 1'b0;
      FOP_BLTZ: b_cond_met_o = (rs_i < 0) ? 1'b1 : 1'b0;
      FOP_BNE: b_cond_met_o = (rs_i != rt_i) ? 1'b1 : 1'b0;
      FOP_BGEZAL: b_cond_met_o = (rs_i >= 0) ? 1'b1 : 1'b0;
      FOP_BLTZAL: b_cond_met_o = (rs_i < 0) ? 1'b1 : 1'b0;
      FOP_J, FOP_JAL, FOP_JR, FOP_JR: b_cond_met_o = 1'b1;
      default: b_cond_met_o = 1'b0;
    endcase

    // saving return address. happens regardless if branch condition is met
    // TODO: The control logic for writing to the register file needs to be handled.
    casex (full_op_i)
      //GPR[31] = PC + 8
      FOP_BGEZAL, FOP_BLTZAL, FOP_JAL: rt_o = pc_i + 8;

      // this one should be GPR[rd] = PC + 8 
      FOP_JALR: rt_o = pc_i + 8;
    endcase

    // Determine branch address
    casex (full_op_i)
      // branch is relative to branch delay slot
      FOP_BEQ, FOP_BGEZ, FOP_BGTZ, FOP_BLEZ, FOP_BLTZ, FOP_BNE, FOP_BGEZAL, FOP_BLTZAL:
      effective_address_o = (sign_extended_imm << 2) + pc_i + 4;

      // PC region jumps
      FOP_J, FOP_JAL: effective_address_o = {pc_i[31:26], target_i};

      // register jumps
      FOP_JALR, FOP_JR: effective_address_o = rs_i;

      default: effective_address_o = 32'b0;
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
