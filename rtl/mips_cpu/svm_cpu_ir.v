import codes::*;

module ir (
    input logic clk,
    input logic wen_i,
    input logic reset_i,
    input size_t instr_i,
    output opcode_t opcode_o,
    output func_t funct_o,
    output regimm_t regimm_o,
    output logic [4:0] shift_o,
    output regaddr_t rs_o,
    output regaddr_t rt_o,
    output regaddr_t rd_o,
    output logic [15:0] immediate_o,
    output logic [25:0] target_o
);

  // The register that holds the instruction in EXEC2 and the next FETCH
  size_t ihold;
  size_t data;

  always_ff @(posedge clk) begin
    if (reset_i) begin
      ihold <= 0;
    end else if (wen_i) begin
`ifdef DEBUG
      if (opcode_o == OP_SPECIAL) begin
        func_display(funct_o);
        $display("%08h", data);
      end else if (opcode_o == OP_REGIMM) begin
        regimm_display(regimm_o);
      end else begin
        opcode_display(opcode_o);
        $display("%08h, %06b, %06b", data, opcode_o, funct_o);
      end
`endif

      ihold <= instr_i;
    end
  end

  assign data = (wen_i) ? instr_i : ihold;
  assign opcode_o = logic_to_opcode(data[31:26]);
  assign target_o = data[25:0];
  assign rs_o = data[25:21];
  assign rt_o = data[20:16];
  assign rd_o = data[15:11];
  assign immediate_o = data[15:0];
  assign shift_o = data[10:6];
  assign funct_o = logic_to_func(data[5:0]);
  assign regimm_o = logic_to_regimm(data[20:16]);

  // These functions are required as iverilog does not support typecasting
  // between logic and enum...
  function automatic opcode_t logic_to_opcode(logic [5:0] i);
    case (i)
      OP_SPECIAL: logic_to_opcode = OP_SPECIAL;
      OP_REGIMM:  logic_to_opcode = OP_REGIMM;
      OP_J:       logic_to_opcode = OP_J;
      OP_JAL:     logic_to_opcode = OP_JAL;
      OP_BEQ:     logic_to_opcode = OP_BEQ;
      OP_BNE:     logic_to_opcode = OP_BNE;
      OP_BLEZ:    logic_to_opcode = OP_BLEZ;
      OP_BGTZ:    logic_to_opcode = OP_BGTZ;
      OP_ADDI:    logic_to_opcode = OP_ADDI;
      OP_ADDIU:   logic_to_opcode = OP_ADDIU;
      OP_SLTI:    logic_to_opcode = OP_SLTI;
      OP_SLTIU:   logic_to_opcode = OP_SLTIU;
      OP_ANDI:    logic_to_opcode = OP_ANDI;
      OP_ORI:     logic_to_opcode = OP_ORI;
      OP_XORI:    logic_to_opcode = OP_XORI;
      OP_LUI:     logic_to_opcode = OP_LUI;
      OP_LB:      logic_to_opcode = OP_LB;
      OP_LH:      logic_to_opcode = OP_LH;
      OP_LWL:     logic_to_opcode = OP_LWL;
      OP_LW:      logic_to_opcode = OP_LW;
      OP_LBU:     logic_to_opcode = OP_LBU;
      OP_LHU:     logic_to_opcode = OP_LHU;
      OP_LWR:     logic_to_opcode = OP_LWR;
      OP_SB:      logic_to_opcode = OP_SB;
      OP_SH:      logic_to_opcode = OP_SH;
      OP_SWL:     logic_to_opcode = OP_SWL;
      OP_SW:      logic_to_opcode = OP_SW;
      OP_SWR:     logic_to_opcode = OP_SWR;
      default:    logic_to_opcode = OP_INVALID;
    endcase
  endfunction

`ifdef DEBUG
  task automatic opcode_display(input opcode_t i);
    case (i)
      OP_SPECIAL: $display("Got opcode OP_SPECIAL");
      OP_REGIMM:  $display("Got opcode OP_REGIMM");
      OP_J:       $display("Got opcode OP_J");
      OP_JAL:     $display("Got opcode OP_JAL");
      OP_BEQ:     $display("Got opcode OP_BEQ");
      OP_BNE:     $display("Got opcode OP_BNE");
      OP_BLEZ:    $display("Got opcode OP_BLEZ");
      OP_BGTZ:    $display("Got opcode OP_BGTZ");
      OP_ADDI:    $display("Got opcode OP_ADDI");
      OP_ADDIU:   $display("Got opcode OP_ADDIU");
      OP_SLTI:    $display("Got opcode OP_SLTI");
      OP_SLTIU:   $display("Got opcode OP_SLTIU");
      OP_ANDI:    $display("Got opcode OP_ANDI");
      OP_ORI:     $display("Got opcode OP_ORI");
      OP_XORI:    $display("Got opcode OP_XORI");
      OP_LUI:     $display("Got opcode OP_LUI");
      OP_LB:      $display("Got opcode OP_LB");
      OP_LH:      $display("Got opcode OP_LH");
      OP_LWL:     $display("Got opcode OP_LWL");
      OP_LW:      $display("Got opcode OP_LW");
      OP_LBU:     $display("Got opcode OP_LBU");
      OP_LHU:     $display("Got opcode OP_LHU");
      OP_LWR:     $display("Got opcode OP_LWR");
      OP_SB:      $display("Got opcode OP_SB");
      OP_SH:      $display("Got opcode OP_SH");
      OP_SWL:     $display("Got opcode OP_SWL");
      OP_SW:      $display("Got opcode OP_SW");
      OP_SWR:     $display("Got opcode OP_SWR");
      default:    $display("Got opcode OP_INVALID");
    endcase
  endtask
`endif

  function automatic func_t logic_to_func(logic [5:0] i);
    case (i)
      FUNC_SLL:     logic_to_func = FUNC_SLL;
      FUNC_SRL:     logic_to_func = FUNC_SRL;
      FUNC_SRA:     logic_to_func = FUNC_SRA;
      FUNC_SLLV:    logic_to_func = FUNC_SLLV;
      FUNC_SRLV:    logic_to_func = FUNC_SRLV;
      FUNC_SRAV:    logic_to_func = FUNC_SRAV;
      FUNC_JR:      logic_to_func = FUNC_JR;
      FUNC_JALR:    logic_to_func = FUNC_JALR;
      FUNC_SYSCALL: logic_to_func = FUNC_SYSCALL;
      FUNC_BREAK:   logic_to_func = FUNC_BREAK;
      FUNC_MFHI:    logic_to_func = FUNC_MFHI;
      FUNC_MTHI:    logic_to_func = FUNC_MTHI;
      FUNC_MFLO:    logic_to_func = FUNC_MFLO;
      FUNC_MTLO:    logic_to_func = FUNC_MTLO;
      FUNC_MULT:    logic_to_func = FUNC_MULT;
      FUNC_MULTU:   logic_to_func = FUNC_MULTU;
      FUNC_DIV:     logic_to_func = FUNC_DIV;
      FUNC_DIVU:    logic_to_func = FUNC_DIVU;
      FUNC_ADD:     logic_to_func = FUNC_ADD;
      FUNC_ADDU:    logic_to_func = FUNC_ADDU;
      FUNC_SUB:     logic_to_func = FUNC_SUB;
      FUNC_SUBU:    logic_to_func = FUNC_SUBU;
      FUNC_AND:     logic_to_func = FUNC_AND;
      FUNC_OR:      logic_to_func = FUNC_OR;
      FUNC_XOR:     logic_to_func = FUNC_XOR;
      FUNC_NOR:     logic_to_func = FUNC_NOR;
      FUNC_SLT:     logic_to_func = FUNC_SLT;
      FUNC_SLTU:    logic_to_func = FUNC_SLTU;
      default:      logic_to_func = FUNC_INVALID;
    endcase
  endfunction

`ifdef DEBUG
  task automatic func_display(input func_t i);
    case (i)
      FUNC_SLL:     $display("Got SPECIAL: FUNC_SLL");
      FUNC_SRL:     $display("Got SPECIAL: FUNC_SRL");
      FUNC_SRA:     $display("Got SPECIAL: FUNC_SRA");
      FUNC_SLLV:    $display("Got SPECIAL: FUNC_SLLV");
      FUNC_SRLV:    $display("Got SPECIAL: FUNC_SRLV");
      FUNC_SRAV:    $display("Got SPECIAL: FUNC_SRAV");
      FUNC_JR:      $display("Got SPECIAL: FUNC_JR");
      FUNC_JALR:    $display("Got SPECIAL: FUNC_JALR");
      FUNC_SYSCALL: $display("Got SPECIAL: FUNC_SYSCALL");
      FUNC_BREAK:   $display("Got SPECIAL: FUNC_BREAK");
      FUNC_MFHI:    $display("Got SPECIAL: FUNC_MFHI");
      FUNC_MTHI:    $display("Got SPECIAL: FUNC_MTHI");
      FUNC_MFLO:    $display("Got SPECIAL: FUNC_MFLO");
      FUNC_MTLO:    $display("Got SPECIAL: FUNC_MTLO");
      FUNC_MULT:    $display("Got SPECIAL: FUNC_MULT");
      FUNC_MULTU:   $display("Got SPECIAL: FUNC_MULTU");
      FUNC_DIV:     $display("Got SPECIAL: FUNC_DIV");
      FUNC_DIVU:    $display("Got SPECIAL: FUNC_DIVU");
      FUNC_ADD:     $display("Got SPECIAL: FUNC_ADD");
      FUNC_ADDU:    $display("Got SPECIAL: FUNC_ADDU");
      FUNC_SUB:     $display("Got SPECIAL: FUNC_SUB");
      FUNC_SUBU:    $display("Got SPECIAL: FUNC_SUBU");
      FUNC_AND:     $display("Got SPECIAL: FUNC_AND");
      FUNC_OR:      $display("Got SPECIAL: FUNC_OR");
      FUNC_XOR:     $display("Got SPECIAL: FUNC_XOR");
      FUNC_NOR:     $display("Got SPECIAL: FUNC_NOR");
      FUNC_SLT:     $display("Got SPECIAL: FUNC_SLT");
      FUNC_SLTU:    $display("Got SPECIAL: FUNC_SLTU");
      default:      $display("Got SPECIAL: FUNC_INVALID");
    endcase
  endtask
`endif

  function automatic regimm_t logic_to_regimm(logic [4:0] i);
    case (i)
      REGIMM_BLTZ:   logic_to_regimm = REGIMM_BLTZ;
      REGIMM_BGEZ:   logic_to_regimm = REGIMM_BGEZ;
      REGIMM_BLTZAL: logic_to_regimm = REGIMM_BLTZAL;
      REGIMM_BGEZAL: logic_to_regimm = REGIMM_BGEZAL;
      default:       logic_to_regimm = REGIMM_INVALID;
    endcase
  endfunction

`ifdef DEBUG
  task automatic regimm_display(input regimm_t i);
    case (i)
      REGIMM_BLTZ:   $display("Got REGIMM: REGIMM_BLTZ");
      REGIMM_BGEZ:   $display("Got REGIMM: REGIMM_BGEZ");
      REGIMM_BLTZAL: $display("Got REGIMM: REGIMM_BLTZAL");
      REGIMM_BGEZAL: $display("Got REGIMM: REGIMM_BGEZAL");
      default:       $display("Got REGIMM: REGIMM_INALID");
    endcase
  endtask
`endif

endmodule
