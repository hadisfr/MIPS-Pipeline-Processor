module Instaruction_mem #(parameter n = 32) (
    input clk,
    input rst,
    input [n-1:0] PC,
    output [n-1:0] instruction
);
    reg [n-1:0] _Instaruction_mem [0:7];
    always @(posedge clk) begin
        _Instaruction_mem[0] = 32'b000000_00000_00001_00010_00000000000;
        _Instaruction_mem[1] = 32'b000000_00000_00011_00100_00000000000;
        _Instaruction_mem[2] = 32'b000000_00000_00101_00110_00000000000;
        _Instaruction_mem[3] = 32'b000000_00010_00111_01000_00000000000;
        _Instaruction_mem[4] = 32'b000000_00011_01001_01010_00000000000;
        _Instaruction_mem[5] = 32'b000000_00000_01011_01100_00000000000;
        _Instaruction_mem[6] = 32'b000000_00000_01101_01110_00000000000;
        _Instaruction_mem[7] = 32'b0;
    end
    assign instruction = _Instaruction_mem[PC[4:2]];
endmodule