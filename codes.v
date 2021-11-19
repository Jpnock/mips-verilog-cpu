package codes;
  // opcode_t defines the 6-bit opcode mapping.
  // This can be found on page 189, A-177 of
  // https://www.cs.cmu.edu/afs/cs/academic/class/15740-f97/public/doc/mips-isa.pdf
  typedef enum logic [5:0] {
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
    // 00XXX
    REGIMM_BLTZ = 5'b00000,
    REGIMM_BGEZ = 5'b00001,

    // 10XXX
    REGIMM_BLTZAL = 5'b10000,
    REGIMM_BGEZAL = 5'b10001
  } regimm_t;

endpackage
