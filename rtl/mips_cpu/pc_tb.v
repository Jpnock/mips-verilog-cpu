module pc_tb ();
  logic clk;
  logic reset;
  logic wen;
  logic b_instr;
  logic [31:0] pc_o;

  initial begin
    $dumpfile("pc_tb.vcd");
    $dumpvars(0, pc_tb);

    clk = 0;
    #1;

    forever begin
      clk = !clk;
      #5;
    end

  end


  initial begin
    reset = 1;
    wen = 1;
    b_instr = 0;

    repeat (3) begin
      @(posedge clk);
    end

    assert (pc_o == 0);
    @(posedge clk);

    reset = 0;

    repeat (3) begin
      @(posedge clk);
    end

    #1;
    reset = 1;

    repeat (3) begin
      @(posedge clk);
    end

    #1;
    reset = 0;
    assert (pc_o != 'hBFC00000);

    @(posedge clk);
    assert (pc_o == 'hBFC00000);

    repeat (3) begin
      @(posedge clk);
    end

    b_instr = 1;
    assert (pc_o == 'hBFC0000C);
    @(posedge clk);

    // branch instruction at 0xBFC00010
    b_instr = 0;
    assert (pc_o == 'hBFC00010);
    @(posedge clk);

    // instruction after branch should execute
    assert (pc_o == 'hBFC00014);
    @(posedge clk);

    // branch location
    assert (pc_o == 'hAAA00000);
    $display("%h", pc_o);
    repeat (3) begin
      @(posedge clk);
    end

    $finish(0);

  end

  cpu_pc pc (
      .clk(clk),
      .reset(reset),
      .wen(wen),
      .b_instr(b_instr),
      .pc_in('hAAA00000),
      .pc_o(pc_o)
  );

endmodule
