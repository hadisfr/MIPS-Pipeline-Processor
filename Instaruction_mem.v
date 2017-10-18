module Instaruction_mem (
    input [31:0] PC,
    output [31:0] Instruction
);
    reg [31:0] _Instaruction_mem [0:7];
    always @(posedge PC) begin
        _Instaruction_mem[0] = 32'b000000_00000_00001_00010_00000000000;
        _Instaruction_mem[1] = 32'b000000_00000_00011_00100_00000000000;
        _Instaruction_mem[2] = 32'b000000_00000_00101_00110_00000000000;
        _Instaruction_mem[3] = 32'b000000_00010_00111_01000_00000000000;
        _Instaruction_mem[4] = 32'b000000_00011_01001_01010_00000000000;
        _Instaruction_mem[5] = 32'b000000_00000_01011_01100_00000000000;
        _Instaruction_mem[6] = 32'b000000_00000_01101_01110_00000000000;
        // 32'b0;
    end
    assign Instruction = _Instaruction_mem[PC[4:2]];
endmodule