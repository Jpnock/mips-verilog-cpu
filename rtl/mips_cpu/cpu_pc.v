module cpu_pc (
    input logic clk,
    input logic reset, // resets every register in the PC. Will take one full cycle to complete. Independent of WEN.

    /*
    if low, the state of the PC can not be changed in any meaningful way unless it is reset.
    if high during a positive clock edge, the PC will "iterate". I.e. update itself based on other inputs.
    In the usual fetch, E1, E2 cycle this should therefore only be high for only one of these cycles. 
    */
    input logic wen,
    input logic b_cond_met,   // Set to high when branching. PC output will change accordingly cycle after the next assuming WEN is also high.
    input logic [31:0] pc_in,  // during a branch, set this to the location to branch to.
    output logic [31:0] pc_o  // pc output
);

  /* 
	NOTE(jsand): FUNCTIONALITY & ASSUMPTIONS:
	The requirements related to the PC are quite spread out, so I have tried compiling
	all the information together here in one place:

		"All signals are synchronous to clk, including reset. The reset signal must 
		be held high for at least 1 cycle to reset the CPU. This is a level-sensitive reset, 
		which is synchronous to the clock."

		"the effect of reset should be that:
			-All ISA-visible MIPS data registers are set to zero.
			-The next instruction to be executed post-reset should be at address 0xBFC00000." 
		
		"The reset signal may be held high for more than one cycle"
		
		"For the reset, we require that all registers (including the PC) are set to 0.""
		
		"0xBFC00000 : This is the location at which execution should start after reset."

	I have tried paying particular attention to the fact that David Thomas says the reset 
	must be held high for at least one cycle to reset the CPU. Implementation-wise, this
	means I don't change the output of the PC immediately whenever there is a reset, but
	only the input to the PC register. This means the PC will first output 0 the cycle after
	the positive clock edge where reset was first set to high.

	The requirements for when the post-reset address should be outputted is a bit more 
	relaxed, as the precise timing for this is not important as long as the next instruction
	exectuted after reset is the one at that address. Whenever I detect the reset going low,
	I simply force the output to be the reset address immediately. 

  (Feel free to delete/remove this giant block of text)
	*/

  logic [31:0] reset_pos = 32'hBFC00000;

  logic [31:0] pc_d, pc_q;
  logic [31:0] branch_d, branch_q;
  logic sel_branch_d, sel_branch_q;

  assign pc_o = pc_q;

  always_comb begin

    if (reset == 1) begin
      pc_d = 0;
      branch_d = 0;
      sel_branch_d = 0;
    end else if (wen == 0) begin
      pc_d = pc_q;
      branch_d = branch_q;
      sel_branch_d = sel_branch_q;
    end else begin

      if (b_cond_met == 1) begin
        branch_d = pc_in;
      end else begin
        branch_d = branch_q;
      end

      if (sel_branch_q == 1) begin
        pc_d = branch_q;
      end else begin
        pc_d = pc_q + 4;
      end

      sel_branch_d = b_cond_met;

    end
  end

  always_ff @(posedge clk) begin
    pc_q <= pc_d;
    branch_q <= branch_d;
    sel_branch_q <= sel_branch_d;
  end

  always_ff @(negedge reset) begin
    pc_q <= reset_pos;
  end

endmodule
