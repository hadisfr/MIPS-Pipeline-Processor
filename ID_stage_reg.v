module ID_stage_reg (
    input clk,    // Clock
    input rst,  // Reset active high
    input en,
    input [31:0] PC_in,
    input [4:0] MEM_src1_fd_in, MEM_src2_fd_in,
    input [4:0] dest_in,
    input [31:0] Reg2_in, Val2_in, Val1_in,
    input Br_taken_in,
    input [3:0] EXE_cmd_in,
    input MEM_R_en_in, MEM_W_en_in, WB_en_in,
    output [31:0] PC,
    output [4:0] MEM_src1_fd, MEM_src2_fd,
    output [4:0] dest,
    output [31:0] Reg2, Val2, Val1,
    output Br_taken,
    output [3:0] EXE_cmd,
    output MEM_R_en, MEM_W_en, WB_en
);
    Reg #(32) PC_mem(clk, rst, rst | en, PC_in, PC);
    Reg #(5) MEM_src1_fd_mem(clk, rst, rst | en, MEM_src1_fd_in, MEM_src1_fd);
    Reg #(5) MEM_src2_fd_mem(clk, rst, rst | en, MEM_src2_fd_in, MEM_src2_fd);
    Reg #(5) dest_mem(clk, rst, rst | en, dest_in, dest);
    Reg #(32) Reg2_mem(clk, rst, rst | en, Reg2_in, Reg2);
    Reg #(32) Val2_mem(clk, rst, rst | en, Val2_in, Val2);
    Reg #(32) Val1_mem(clk, rst, rst | en, Val1_in, Val1);
    Reg #(1) Br_taken_mem(clk, rst, rst | en, Br_taken_in, Br_taken);
    Reg #(4) EXE_cmd_mem(clk, rst, rst | en, EXE_cmd_in, EXE_cmd);
    Reg #(1) MEM_R_en_mem(clk, rst, rst | en, MEM_R_en_in, MEM_R_en);
    Reg #(1) MEM_W_en_mem(clk, rst, rst | en, MEM_W_en_in, MEM_W_en);
    Reg #(1) WB_en_mem(clk, rst, rst | en, WB_en_in, WB_en);
endmodule