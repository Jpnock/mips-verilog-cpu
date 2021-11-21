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

  /* Declarations */

  // FSM
  logic stall;
  state_t state;

  // Control
  func_t funct;
  opcode_t opcode;
  logic pc_wen, ir_wen, reg_wen, src_b_sel, ram_a_sel, reg_wd_sel, reg_a3_sel;

  // PC
  logic b_cond_met;
  size_t pc_o, pc_i;

  // IR
  regaddr_t rs, rt, rd;
  logic [15:0] immediate;

  // RegFile
  regaddr_t addr_3;
  size_t rs_regfile_data, rs_data_d, rt_regfile_data, rt_data_d, write_data_3, rd_data_d;


  // ALU
  logic stall_alu;
  size_t mfhi, mflo, alu_out;


  /* Modules */

  //TODO: Add wait request stalls later.
  assign stall = stall_alu;
  fsm fsm (
      .clk(clk),
      .reset_i(reset),
      .stall_i(stall),
      .state_o(state)
  );


  control control (
      .state_i(state),
      .opcode_i(opcode),
      .function_i(funct),
      .pc_wen_o(pc_wen),
      .ir_wen_o(ir_wen),
      .ram_wen_o(write),
      .ram_rds_o(read),
      .reg_wen_o(reg_wen),
      .src_b_sel_o(src_b_sel),
      .ram_a_sel_o(ram_a_sel),
      .reg_wd_sel_o(reg_wd_sel),
      .reg_a3_sel_o(reg_a3_sel)
  );

  // TODO: For JR only. Change if required.
  assign pc_i = read_data_1;
  // TODO: Add proper control logic for when branch conditions are met.
  assign b_cond_met = 1'b0;

  pc pc (
      .clk(clk),
      .reset_i(reset),
      .wen_i(pc_wen),
      .b_cond_met(b_cond_met),
      .pc_i(pc_i),
      .pc_o(pc_o)
  );


  ir ir (
      .clk(clk),
      .wen_i(ir_wen),
      .reset_i(reset),
      .instr_i(readdata),
      .opcode_o(opcode),
      .funct_o(funct),
      .rs_o(rs),
      .rt_o(rt),
      .rd_o(rd),
      .immediate_o(immediate)
  );

  assign addr_3 = (reg_a3_sel == 1) ? rd : rt;
  assign write_data_3 = (reg_wd_sel == 1) ? alu_out : readdata;

  regfile regfile (
      .clk(clk),
      .reset_i(reset),
      .addr_1_i(rs),
      .addr_2_i(rt),
      .addr_3_i(addr_3),
      .write_data_3_i(write_data_3),
      .write_enable_i(reg_wen),
      .read_data_1_o(rs_regfile_data),
      .read_data_2_o(rt_regfile_data)
  );

  alu alu (
      .clk(clk),
      .opcode_i(opcode),
      .funct_i(funct),
      .rs_i(rs_regfile_data),
      .rt_i(rt_regfile_data),
      .immediate_i(immediate),
      .rd_o(rd_data_d),
      .rt_o(rt_data_d),
      .mfhi_o(mfhi),
      .mflo_o(mflo),
      .stall_o(stall_alu)
  );
  // TODO: Add support for MFHI/MFLO later.
  // TODO: Remove when ALU has a single output.
  assign alu_out = (reg_a3_sel == 1) ? rd_data_d : rt_data_d;

  /* Other IO/IN. */
  assign active = 1;  //TODO: Think of implementation.
  assign register_v0 = 0;  //TODO: Fish out signal from Reg File.
  assign address = (ram_a_sel == 1) ? alu_out : pc_o;
  assign writedata = rt_data_d;
  assign byteenable = 4'b1111;  //TODO: Change when LB instructions are implemented.

endmodule
