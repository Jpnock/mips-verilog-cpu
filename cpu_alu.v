import codes::*;

module alu (
    input opcode_t opcode,
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [5:0] funct,
    output logic [31:0] out
);

  always_comb begin
    case (opcode)
      OP_SPECIAL: begin
        case (funct)
          // ADD
          FUNC_ADD: begin
            // TODO: fire exception on overflow
            out = a + b;
          end
          FUNC_ADDU: out = a + b;
          FUNC_SUB: begin
            // TODO: fire exception on overflow
            out = a - b;
          end
          FUNC_SUBU: out = a - b;
          FUNC_AND:  out = a & b;
          FUNC_OR:   out = a | b;
          FUNC_XOR:  out = a ^ b;
          FUNC_NOR:  out = a~|b;
        endcase
      end
      // OP_ADDI  :
      // OP_ADDIU :
      // OP_SLTI  :
      // OP_SLTIU :
      // OP_ANDI  :
      // OP_ORI   :
      // OP_XORI  :
      // OP_LUI   :
    endcase
  end

endmodule
