import codes::*;

module mips_cpu_bus (
    /* Standard signals */
    input logic clk,
    input logic reset,
    output logic active,
    output logic [31:0] register_v0,

    /* Avalon memory mapped bus controller (master) */
    output logic [31:0] address,
    output logic write,
    output logic read,
    input logic waitrequest,
    output logic [31:0] writedata,
    output logic [3:0] byteenable,
    input logic [31:0] readdata
);

  function automatic size_t swap_endian(size_t to_swap);
    swap_endian = {to_swap[7:0], to_swap[15:8], to_swap[23:16], to_swap[31:24]};
  endfunction

  size_t readdata_bigendian;
  assign readdata_bigendian = swap_endian(readdata);

  // FSM
  logic stall, halt;
  state_t  state;

  // Control
  func_t   funct;
  opcode_t opcode;
  regimm_t regimm;
  logic
      pc_write_en,
      ir_write_en,
      regfile_write_en,
      src_b_sel,
      ram_addr_sel,
      regfile_writedata_sel,
      regfile_addr_3_sel;

  // PC
  logic b_cond_met;
  size_t pc_o, pc_i;

  // IR
  regaddr_t rs, rt, rd;
  logic [15:0] immediate;
  logic [4:0] shift;

  // RegFile
  regaddr_t addr_3;
  size_t
      rs_regfile_data,
      rs_data_d,
      rt_regfile_data,
      rt_data_d,
      write_data_3,
      rd_data_d,
      read_data_reg_v0;


  // ALU
  size_t mfhi, mflo, alu_out, effective_address;

  //TODO: Add wait request stalls later.
  assign stall = 0;
  assign halt  = (pc_o == 0) ? 1 : 0;
  fsm fsm (
      .clk(clk),
      .halt_i(halt),
      .reset_i(reset),
      .stall_i(stall),
      .state_o(state)
  );

`ifdef DEBUG
  always_ff @(posedge clk) begin
    if (halt) begin
      $display("Halt output (active %d): %08h", active, register_v0);
    end
  end
`endif

  control control (
      .state_i(state),
      .opcode_i(opcode),
      .function_i(funct),
      .pc_write_en_o(pc_write_en),
      .ir_write_en_o(ir_write_en),
      .ram_write_en_o(write),
      .ram_read_en_o(read),
      .regfile_write_en_o(regfile_write_en),
      .src_b_sel_o(src_b_sel),
      .ram_addr_sel_o(ram_addr_sel),
      .regfile_writedata_sel_o(regfile_writedata_sel),
      .regfile_addr_3_sel_o(regfile_addr_3_sel)
  );

  // TODO: For JR only. Change if required.
  assign pc_i = rs_regfile_data;
  // TODO: Add proper control logic for when branch conditions are met.
  assign b_cond_met = ((opcode == OP_SPECIAL) && (funct == FUNC_JR)) ? 1 : 0;

  pc pc (
      .clk(clk),
      .reset(reset),
      .wen(pc_write_en),
      .b_cond_met(b_cond_met),
      .pc_i(pc_i),
      .pc_o(pc_o)
  );

  ir ir (
      .clk(clk),
      .state_i(state),
      .wen_i(ir_write_en),
      .reset_i(reset),
      .instr_i(readdata_bigendian),
      .opcode_o(opcode),
      .funct_o(funct),
      .regimm_o(regimm),
      .shift_o(shift),  // TODO: Remove if not used.
      .rs_o(rs),
      .rt_o(rt),
      .rd_o(rd),
      .immediate_o(immediate)
  );

  always_comb begin
    // TODO: Add support for MFHI/MFLO later.
    // TODO: Remove alu_out multiplexer when the ALU has a single output.
    case (regfile_addr_3_sel)
      REGFILE_ADDR_SEL_RD: begin
        addr_3  = rd;
        alu_out = rd_data_d;
      end
      REGFILE_ADDR_SEL_RT: begin
        addr_3  = rt;
        alu_out = rt_data_d;
      end
      default: begin
`ifdef DEBUG
        $fatal(1, "unknown enum value for regfile_addr_3_sel");
`endif
      end
    endcase
  end

  // TODO: we need to be careful here if we're doing non 32-bit load operations
  // (e.g. LH, LB). The representation of bytes or half-words will always be
  // presented from bit 32, downward. For example an LB which returns 0xFF will
  // be represented in readdata_bigendian as 0xFF000000. A LH which returns
  // 0x4142 will be represented in readdata_bigendian as 0x41420000. These
  // values need shifting to the correct location before writing them.
  assign write_data_3 = alu_out;

  regfile regfile (
      .clk(clk),
      .reset_i(reset),
      .addr_1_i(rs),
      .addr_2_i(rt),
      .addr_3_i(addr_3),
      .write_data_3_i(write_data_3),
      .write_enable_i(regfile_write_en),
      .read_data_1_o(rs_regfile_data),
      .read_data_2_o(rt_regfile_data),
      .read_data_reg_v0_o(read_data_reg_v0)
  );

  alu alu (
      .clk(clk),
      .opcode_i(opcode),
      .funct_i(funct),
      .rs_i(rs_regfile_data),
      .rt_i(rt_regfile_data),
      .immediate_i(immediate),
      .ram_readdata_i(readdata_bigendian),
      .rd_o(rd_data_d),
      .rt_o(rt_data_d),
      .effective_address_o(effective_address),
      .mfhi_o(mfhi),
      .mflo_o(mflo)
  );

  /* Other IO/IN. */
  assign active = state != HALT;
  assign register_v0 = read_data_reg_v0;
  assign address = (ram_addr_sel == 1) ? effective_address : pc_o;

  assign writedata = swap_endian(rt_data_d);

  // TODO: Change when LB instructions are implemented. See the detailed
  // conversation here on how this should be produced:
  // https://github.com/Jpnock/verilog-cpu/pull/26#issuecomment-979345783
  assign byteenable = 4'b1111;

endmodule
