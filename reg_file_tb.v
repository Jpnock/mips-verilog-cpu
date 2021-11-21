module reg_file_tb ();
  logic clk;
  logic reset;
  logic [5:0] A1;
  logic [5:0] A2;
  logic [5:0] A3;
  logic [31:0] WD3;
  logic WEN;
  logic [31:0] RD1;
  logic [31:0] RD2;
  logic [31:0] a;

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

    A1  = 0;
    A2  = 0;
    A3  = 1;
    WD3 = 1;
    WEN = 1;

    #3;

    assert (a == 1);

    #1;

    A3  = 2;
    WD3 = 2;
    WEN = 1;

    #3;

    assert (a == 2);

    #1;

    A1  = 1;
    A2  = 2;
    A3  = 4;
    WD3 = 32;
    WEN = 0;

    #3;

    assert (RD1 == 1);

    #3;

    assert (RD2 == 2);





    #10;


    $finish;








  end

  reg_file reg_file (
      .clk(clk),
      .A1 (A1),
      .A2 (A2),
      .A3 (A3),
      .WD3(WD3),
      .WEN(WEN),
      .RD1(RD1),
      .RD2(RD2),
      .a  (a)
  );

endmodule


