module ID_stage (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [31:0] Instruction,
    input [4:0] Dest_WB,
    input [31:0] MEM_W_value_WB,
    input WB_en_WB,
    output [4:0] Dest,
    output [31:0] Reg2, Val2, Val1,
    output Br_taken,
    output [3:0] EXE_cmd,
    output MEM_R_en, MEM_W_en, WB_en
);

// Register_file register_file(clk, rst, src1, src2, reg1, reg2);
assign Br_taken1 = 1'b0;

endmodule