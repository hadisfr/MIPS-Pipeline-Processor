module WB_stage (
    input clk,    // Clock
    input WB_EN_in, MEM_R_EN,
    input [31:0] ALU_result,
    input [31:0] Mem_read_value,
    input [4:0] Dest_in,
    output WB_EN,
    output [31:0] Write_value,
    output [4:0] Dest
);

endmodule