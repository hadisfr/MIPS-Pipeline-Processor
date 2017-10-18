module Register_file (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [4:0] src1, src2,
    // dest,
    // input [31:0] Write_val,
    // input Write_en,
    output [31:0] reg1, reg2
);

    reg [31:0] _Register_file [0:31];
    assign reg1 = _Register_file[src1];
    assign reg2 = _Register_file[src2];

    // always @(negedge clk)
    //     if(Write_en)
    //         _Register_file[dest] = Write_val;

endmodule