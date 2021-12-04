module mips_cpu_bus_tb ();

  logic clk;
  logic reset;
  logic active;
  logic [31:0] register_v0;

  logic [31:0] address;
  logic write;
  logic read;
  logic waitrequest;
  logic [31:0] writedata;
  logic [3:0] byteenable;
  logic [31:0] readdata;

  parameter RAM_FILE = "";
  parameter RAM_WAIT = 0;
  parameter EXPECTED_VALUE = -1;

  size_t expected_value_reg;
  assign expected_value_reg = EXPECTED_VALUE;

  initial begin
    $dumpfile("mips_cpu_bus_tb.vcd");
    $dumpvars(0, mips_cpu_bus_tb);

    clk = 0;
    #1;
    repeat (256) begin
      #2;
      clk = !clk;
    end

    assert (active == 0)
    else $fatal(1, "Testbench did not execute within 256 cycles");

    assert (register_v0 == expected_value_reg)
    else $fatal(1, "Testbench expected 0x%08x but got 0x%08x", expected_value_reg, register_v0);
    $finish;
  end

  initial begin
    reset = 1;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    reset = 0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
  end

  mips_cpu_bus mips_cpu_bus (
      .clk(clk),
      .reset(reset),
      .active(active),
      .register_v0(register_v0),
      .address(address),
      .write(write),
      .read(read),
      .waitrequest(waitrequest),
      .writedata(writedata),
      .byteenable(byteenable),
      .readdata(readdata)
  );

  cpu_ram #(
      .RAM_FILE(RAM_FILE),
      .RAM_WAIT(RAM_WAIT)
  ) cpu_ram (
      .clk(clk),
      .reset(reset),
      .read(read),
      .write(write),
      .byteenable(byteenable),
      .address(address),
      .writedata(writedata),
      .waitrequest(waitrequest),
      .readdata(readdata)
  );

endmodule
