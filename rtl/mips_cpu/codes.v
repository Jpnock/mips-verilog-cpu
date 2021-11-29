package codes;

  typedef logic [4:0] regaddr_t;

  typedef logic [31:0] size_t;

  // FSM codes.
  typedef enum logic [1:0] {
    FETCH = 2'b00,
    EXEC1 = 2'b01,
    EXEC2 = 2'b10,
    HALT  = 2'b11
  } state_t;

  // opcode_t defines the 6-bit opcode mapping.
  // This can be found on page 189, A-177 of
  // https://www.cs.cmu.edu/afs/cs/academic/class/15740-f97/public/doc/mips-isa.pdf
  typedef enum logic [5:0] {
    // This doesn't exist in MIPS but it's here for the opcode typecast
    OP_INVALID = 6'b111111,

    // 000XXX
    OP_SPECIAL = 6'b000000,
    OP_REGIMM  = 6'b000001,
    OP_J       = 6'b000010,
    OP_JAL     = 6'b000011,
    OP_BEQ     = 6'b000100,
    OP_BNE     = 6'b000101,
    OP_BLEZ    = 6'b000110,
    OP_BGTZ    = 6'b000111,

    // 001XXX
    OP_ADDI  = 6'b001000,
    OP_ADDIU = 6'b001001,
    OP_SLTI  = 6'b001010,
    OP_SLTIU = 6'b001011,
    OP_ANDI  = 6'b001100,
    OP_ORI   = 6'b001101,
    OP_XORI  = 6'b001110,
    OP_LUI   = 6'b001111,

    // 100XXX
    OP_LB  = 6'b100000,
    OP_LH  = 6'b100001,
    OP_LWL = 6'b100010,
    OP_LW  = 6'b100011,
    OP_LBU = 6'b100100,
    OP_LHU = 6'b100101,
    OP_LWR = 6'b100110,

    // 101XXX
    OP_SB  = 6'b101000,
    OP_SH  = 6'b101001,
    OP_SWL = 6'b101010,
    OP_SW  = 6'b101011,
    OP_SWR = 6'b101110
  } opcode_t;

  // These were generated using James' genfunc.py
  typedef enum logic [5:0] {
    // This doesn't exist in MIPS but it's here for the func typecast
    FUNC_INVALID = 6'b111111,

    // 000XXX
    FUNC_SLL  = 6'b000000,
    FUNC_SRL  = 6'b000010,
    FUNC_SRA  = 6'b000011,
    FUNC_SLLV = 6'b000100,
    FUNC_SRLV = 6'b000110,
    FUNC_SRAV = 6'b000111,

    // 001XXX
    FUNC_JR      = 6'b001000,
    FUNC_JALR    = 6'b001001,
    FUNC_SYSCALL = 6'b001100,
    FUNC_BREAK   = 6'b001101,

    // 010XXX
    FUNC_MFHI = 6'b010000,
    FUNC_MTHI = 6'b010001,
    FUNC_MFLO = 6'b010010,
    FUNC_MTLO = 6'b010011,

    // 011XXX
    FUNC_MULT  = 6'b011000,
    FUNC_MULTU = 6'b011001,
    FUNC_DIV   = 6'b011010,
    FUNC_DIVU  = 6'b011011,

    // 100XXX
    FUNC_ADD  = 6'b100000,
    FUNC_ADDU = 6'b100001,
    FUNC_SUB  = 6'b100010,
    FUNC_SUBU = 6'b100011,
    FUNC_AND  = 6'b100100,
    FUNC_OR   = 6'b100101,
    FUNC_XOR  = 6'b100110,
    FUNC_NOR  = 6'b100111,

    // 101XXX
    FUNC_SLT  = 6'b101010,
    FUNC_SLTU = 6'b101011
  } func_t;

  typedef enum logic [4:0] {
    // This doesn't exist in MIPS but it's here for the func typecast
    REGIMM_INVALID = 5'b11111,

    // 00XXX
    REGIMM_BLTZ = 5'b00000,
    REGIMM_BGEZ = 5'b00001,

    // 10XXX
    REGIMM_BLTZAL = 5'b10000,
    REGIMM_BGEZAL = 5'b10001
  } regimm_t;

  // TODO: Determine how we want to decode opcodes.
  // The advantage of having the opcode as a single enum is that we can easily
  // group the instructions by functionality. This reduces the complexity of the
  // switch statements quite a bit. The downside of this is that it is
  // less clear when rs, rt etc. should be used. 
  typedef enum logic [31:0] {
    FOP_INVALID = 32'b1,

    FOP_J    = {OP_J, 26'bX},
    FOP_JAL  = {OP_JAL, 26'bX},
    FOP_BEQ  = {OP_BEQ, 26'bX},
    FOP_BNE  = {OP_BNE, 26'bX},
    FOP_BLEZ = {OP_BLEZ, 26'bX},
    FOP_BGTZ = {OP_BGTZ, 26'bX},

    FOP_ADDI  = {OP_ADDI, 26'bX},
    FOP_ADDIU = {OP_ADDIU, 26'bX},
    FOP_SLTI  = {OP_SLTI, 26'bX},
    FOP_SLTIU = {OP_SLTIU, 26'bX},
    FOP_ANDI  = {OP_ANDI, 26'bX},
    FOP_ORI   = {OP_ORI, 26'bX},
    FOP_XORI  = {OP_XORI, 26'bX},
    FOP_LUI   = {OP_LUI, 26'bX},

    // 100XXX
    FOP_LB  = {OP_LB, 26'bX},
    FOP_LH  = {OP_LH, 26'bX},
    FOP_LWL = {OP_LWL, 26'bX},
    FOP_LW  = {OP_LW, 26'bX},
    FOP_LBU = {OP_LBU, 26'bX},
    FOP_LHU = {OP_LHU, 26'bX},
    FOP_LWR = {OP_LWR, 26'bX},

    // 101XXX
    FOP_SB  = {OP_SB, 26'bX},
    FOP_SH  = {OP_SH, 26'bX},
    FOP_SWL = {OP_SWL, 26'bX},
    FOP_SW  = {OP_SW, 26'bX},
    FOP_SWR = {OP_SWR, 26'bX},

    // 000XXX
    FOP_SLL  = {OP_SPECIAL, 20'bX, FUNC_SLL},
    FOP_SRL  = {OP_SPECIAL, 20'bX, FUNC_SRL},
    FOP_SRA  = {OP_SPECIAL, 20'bX, FUNC_SRA},
    FOP_SLLV = {OP_SPECIAL, 20'bX, FUNC_SLLV},
    FOP_SRLV = {OP_SPECIAL, 20'bX, FUNC_SRLV},
    FOP_SRAV = {OP_SPECIAL, 20'bX, FUNC_SRAV},

    // 001XXX
    FOP_JR      = {OP_SPECIAL, 20'bX, FUNC_JR},
    FOP_JALR    = {OP_SPECIAL, 20'bX, FUNC_JALR},
    FOP_SYSCALL = {OP_SPECIAL, 20'bX, FUNC_SYSCALL},
    FOP_BREAK   = {OP_SPECIAL, 20'bX, FUNC_BREAK},

    // 010XXX
    FOP_MFHI = {OP_SPECIAL, 20'bX, FUNC_MFHI},
    FOP_MTHI = {OP_SPECIAL, 20'bX, FUNC_MTHI},
    FOP_MFLO = {OP_SPECIAL, 20'bX, FUNC_MFLO},
    FOP_MTLO = {OP_SPECIAL, 20'bX, FUNC_MTLO},

    // 011XXX
    FOP_MULT  = {OP_SPECIAL, 20'bX, FUNC_MULT},
    FOP_MULTU = {OP_SPECIAL, 20'bX, FUNC_MULTU},
    FOP_DIV   = {OP_SPECIAL, 20'bX, FUNC_DIV},
    FOP_DIVU  = {OP_SPECIAL, 20'bX, FUNC_DIVU},

    // 100XXX
    FOP_ADD  = {OP_SPECIAL, 20'bX, FUNC_ADD},
    FOP_ADDU = {OP_SPECIAL, 20'bX, FUNC_ADDU},
    FOP_SUB  = {OP_SPECIAL, 20'bX, FUNC_SUB},
    FOP_SUBU = {OP_SPECIAL, 20'bX, FUNC_SUBU},
    FOP_AND  = {OP_SPECIAL, 20'bX, FUNC_AND},
    FOP_OR   = {OP_SPECIAL, 20'bX, FUNC_OR},
    FOP_XOR  = {OP_SPECIAL, 20'bX, FUNC_XOR},
    FOP_NOR  = {OP_SPECIAL, 20'bX, FUNC_NOR},

    // 101XXX
    FOP_SLT  = {OP_SPECIAL, 20'bX, FUNC_SLT},
    FOP_SLTU = {OP_SPECIAL, 20'bX, FUNC_SLTU},

    FOP_BLTZ = {OP_REGIMM, 5'bX, REGIMM_BLTZ, 16'bX},
    FOP_BGEZ = {OP_REGIMM, 5'bX, REGIMM_BGEZ, 16'bX},

    // 10XXX
    FOP_BLTZAL = {OP_REGIMM, 5'bX, REGIMM_BLTZAL, 16'bX},
    FOP_BGEZAL = {OP_REGIMM, 5'bX, REGIMM_BGEZAL, 16'bX}

  } full_op_t;



  typedef enum logic {
    REGFILE_ADDR_SEL_RT    = 2'b00,
    REGFILE_ADDR_SEL_RD    = 2'b01,
    REGFILE_ADDR_SEL_GPR31 = 2'b10
  } regfile_addr_sel_t;

endpackage
