import codes::*;

module alu (
    input logic clk,

    input full_op_t full_op_i,
    input opcode_t opcode_i,
    input func_t funct_i,

    input size_t rs_i,
    input size_t rt_i,
    input logic [15:0] immediate_i,
    input logic [25:0] target_i,

    input size_t pc_i,

    input logic [7:0] text,

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

  assign effective_address_o   = sign_extended_imm + rs_i;

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
              mf_d[31:0]  = $unsigned(rs_i) / $unsigned(rt_i);
              mf_d[63:32] = $unsigned(rs_i) % $unsigned(rt_i);
            end
          end
        endcase
      end

      /*
      OP_REGIMM: begin
        REGIMM_BLTZ : begin
          // The offset needs to be relative to the branch delay slot 
          effective_address_o = (sign_extended_imm << 2) + pc + 4;
          if (rs_i < 0) begin
          end


        end
        //REGIMM_BGEZ:
        //REGIMM_BLTZAL:
        //REGIMM_BGEZAL:
      end
      */

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
      OP_LW: begin
        rt_o = ram_readdata_i;
      end
      OP_LH: begin
        rt_o = ram_readdata_i >> 16;
      end
      OP_LB: begin
        rt_o = ram_readdata_i >> 24;
      end
      OP_SW: begin
        rt_o = rt_i;
      end
      OP_SH: begin
        rt_o = rt_i << 16;
      end
      OP_SB: begin
        rt_o = rt_i << 24;
      end
      // TODO: we need to be careful here if we're doing non 32-bit store
      // operations (e.g. SH, SB). The representation of bytes or half-words
      // will always be presented from bit 32, downward. For example an SB which
      // stores 0xFF needs to be represented as 0xFF000000. A SH which stores
      // 0x4142 will be represented as 0x41420000. These values need shifting to
      // the correct location before outputting them. The same applies to loads,
      // however they may be handled elsewhere.
    endcase

    // The advantage of having the opcode as a single enum is that we can easily
    // group the instructions by functionality. The downside of this is that it is
    // less clear when rs, rt etc. should be used. 

    // BGEZAL and BLTZAL must not use GBR[31]/$ra as the register to test the
    // jump condition from. This seems to be a compiler restriction, though. 


    // Determine branch address
    case (full_op_i)

      FOP_BEQ, FOP_BGEZ, FOP_BGTZ, FOP_BLEZ, FOP_BLTZ, FOP_BNE, FOP_BGEZAL, FOP_BLTZAL: begin
        // branch is relative to branch delay slot
        effective_address_o = (sign_extended_imm << 2) + pc_i + 4;
      end

      FOP_J, FOP_JAL: begin
        // PC region jumps
        effective_address_o = {pc_in[31:26], target};
      end

      JALR, JR: begin
        // register jumps
        effective_address_o = rs;
      end

      default: begin
        b_cond_met_o = 1'b0;
        effective_address_o = 32'b0;
      end

    endcase

  end

  always_ff @(posedge clk) begin
    if (opcode_i == OP_SPECIAL) begin
      case (funct_i)
        FUNC_MULT, FUNC_MULTU, FUNC_DIV, FUNC_DIVU: begin
          mf_q <= mf_d;
        end
      endcase
    end
  end

endmodule
