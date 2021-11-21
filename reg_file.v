module reg_file (
    input logic clk,
    input logic [5:0] A1,  //read register 1
    input logic [5:0] A2,  //read register 2
    input logic [5:0] A3,  //write register
    input logic [31:0] WD3,  //Data 'bus'
    input logic WEN,  //Write Enable
    output logic [31:0] RD1,  //Read data 1
    output logic [31:0] RD2,  //Read data 2
    output logic [31:0] a  //Help test the write
);


  reg [31:0] rf[31:0];

  always @(posedge clk) begin
    if (WEN == 1) begin
      rf[A3] = WD3;
      a = rf[A3];
    end
  end

  always_comb begin
    if (WEN == 0) begin
      RD1 = rf[A1];
      RD2 = rf[A2];
    end
  end


endmodule

