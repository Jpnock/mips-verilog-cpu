import codes::*;

module cpu_ram (
    input logic clk,
    input logic read,
    input logic write,
    input logic [3:0] byteenable,
    input size_t address,
    input size_t writedata,
    output size_t readdata,
    output logic waitrequest
);

  // RAM_SIZE is the size of the RAM, offset from the reset vector
  // RAM_FILE is the name of the file which the RAM will be initialised
  parameter RAM_FILE = "test/ram_test_01.bin";
  parameter RAM_OFFSET = 32'hBFC00000;
  parameter RAM_BYTES = 1024;

  logic [7:0] ram[RAM_BYTES-1:0];

  initial begin
    // TODO: check endianness
    $readmemh(RAM_FILE, ram, 0, RAM_BYTES - 1);
    // print out a few contents of the ram
    for (integer i = 0; i < 10; i++) begin
      $display("%b", ram[i]);
    end

  end

  size_t mapped_address;
  assign mapped_address = (address - RAM_OFFSET);


  // This is little endian ordering as the lowest byte in memory is the least significant.
  logic [7:0] read_3, read_2, read_1, read_0;
  assign read_0 = ram[mapped_address];
  assign read_1 = ram[mapped_address+1];
  assign read_2 = ram[mapped_address+2];
  assign read_3 = ram[mapped_address+3];

  logic [7:0] write_3, write_2, write_1, write_0;
  assign write_0 = (byteenable[0] == 1) ? writedata[7:0] : read_0;
  assign write_1 = (byteenable[1] == 1) ? writedata[15:8] : read_1;
  assign write_2 = (byteenable[2] == 1) ? writedata[23:16] : read_2;
  assign write_3 = (byteenable[3] == 1) ? writedata[31:24] : read_3;

  always_ff @(posedge clk) begin
    if (write) begin
      ram[mapped_address]   <= write_0;
      ram[mapped_address+1] <= write_1;
      ram[mapped_address+2] <= write_2;
      ram[mapped_address+3] <= write_3;
    end
    readdata = {read_3, read_2, read_1, read_0};
  end

  // TODO: we're ignoring the Avalon timing spec here
  assign waitrequest = 0;

endmodule
