import codes::*;

module reg_file_tb ();
  logic clk;
  logic reset_i;
  regaddr_t addr_1_i;
  regaddr_t addr_2_i;
  regaddr_t addr_3_i;
  size_t write_data_3_i;
  logic write_enable_i;
  size_t read_data_1_o;
  size_t read_data_2_o;
  size_t a;

  initial begin

    $dumpfile("reg_file_tb.vcd");
    $dumpvars(0, reg_file_tb);

    clk = 0;
    #1;
    repeat (2000) begin
      #1;
      clk = 1;
      #1;
      clk = 0;
    end
  end

  initial begin

    addr_1_i = 0;
    addr_2_i = 0;
    addr_3_i = 1;
    write_data_3_i = 1;
    write_enable_i = 1;

    #3;

    assert (a == 1);

    #1;

    addr_3_i = 2;
    write_data_3_i = 2;
    write_enable_i = 1;

    #3;

    assert (a == 2);

    #1;

    addr_1_i = 1;
    addr_2_i = 2;
    addr_3_i = 4;
    write_data_3_i = 32;
    write_enable_i = 0;

    #3;

    assert (read_data_1_o == 1);

    #3;

    assert (read_data_2_o == 2);

    #10;

    $finish;

  end

  regfile regfile (
      .clk(clk),
      .reset_i(reset_i),
      .addr_1_i(addr_1_i),
      .addr_2_i(addr_2_i),
      .addr_3_i(addr_3_i),
      .write_data_3_i(write_data_3_i),
      .write_enable_i(write_enable_i),
      .read_data_1_o(read_data_1_o),
      .read_data_2_o(read_data_2_o),
      .a(a)
  );

endmodule


