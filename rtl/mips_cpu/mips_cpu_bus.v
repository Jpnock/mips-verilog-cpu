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
  logic [31:0] pc_o, pc_i;

  // IR
  logic [4:0] rs, rt, rd;
  logic [15:0] immediate;

  // RegFile
  logic [ 4:0] addr_3;
  logic [31:0] read_data_1, read_data_2, write_data_3;


  // ALU
  logic stall_alu;
  logic [31:0] mfhi, mflo, rd_data, rt_data, alu_out;


  /* Modules */

  assign stall = stall_alu;  //TODO: Add wait request stalls later.
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

  assign pc_i = read_data_1;  // TODO: For JR only. Change if required.
  pc pc (
      .clk(clk),
      .reset_i(reset),
      .wen_i(pc_wen),
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
      .read_data_1_o(read_data_1),
      .read_data_2_o(read_data_2)
  );

  alu alu (
      .clk(clk),
      .opcocde_i(opcode),
      .funct_i(funct),
      .rs_i(rs),
      .rt_i(rt),
      .immediate_i(immediate),
      .rd_o(rd_data),
      .rt_o(rt_data),
      .mfhi_o(mfhi),
      .mflo_i(mflo),
      .stall_o(stall_alu)
  );
  // TODO: Add support for MFHI/MFLO later.
  // TODO: Remove when ALU has a single output.
  assign alu_out = (reg_a3_sel == 1) ? rd_data : rt_data;

  /* Other IO/IN. */
  assign active = 1;  //TODO: Think of implementation.
  assign register_v0 = 0;  //TODO: Fish out signal from Reg File.
  assign address = (ram_a_sel == 1) ? alu_out : pc_o;
  assign writedata = read_data_2;
  assign byteenable = 4'b1111;  //TODO: Change when LB instructions are implemented.

endmodule
