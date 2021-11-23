module cpu_ram (
    input logic clk,
    input logic read,
    input logic write,
    input logic [3:0] byteenable,
    input logic [31:0] address,
    input logic [31:0] writedata,
    output logic waitrequest,
    output logic [31:0] readdata
);

endmodule
