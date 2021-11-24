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

  size_t word_address;
  assign word_address = (address - 32'hBFC00000) >> 2;

  size_t ram_address_data;
  assign ram_address_data = ram[word_address];

  // TODO: Check endianness
  logic [7:0] write_3, write_2, write_1, write_0;

  assign write_0 = (byteenable[0] == 1) ? writedata[7:0] : ram_address_data[7:0];
  assign write_1 = (byteenable[1] == 1) ? writedata[15:8] : ram_address_data[15:8];
  assign write_2 = (byteenable[2] == 1) ? writedata[23:16] : ram_address_data[23:16];
  assign write_3 = (byteenable[3] == 1) ? writedata[31:24] : ram_address_data[31:24];

  always_ff @(posedge clk) begin
    if (write) begin
      // TODO: check endianness
      ram[word_address] <= {write_3, write_2, write_1, write_0};
    end
  end

  // TODO: we're ignoring the Avalon spec here
  assign readdata = ram_address_data;
  assign waitrequest = 0;

endmodule
