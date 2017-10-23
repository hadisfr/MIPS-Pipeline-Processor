module ID_stage (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [31:0] instruction,
    input [31:0] MEM_Reg1, MEM_Reg2,
    output [4:0] MEM_src1, MEM_src2,
    output [4:0] dest,
    output [31:0] Reg2, Val2, Val1,
    output Br_taken,
    output [3:0] EXE_cmd,
    output MEM_R_en, MEM_W_en, WB_en
);
    wire [5:0] op_code;
    wire [4:0] src1, src2;
    wire [15:0] immdediate;
    assign op_code = instruction[31:26];
    assign dest = instruction[25:21];
    assign src1 = instruction[20:16];
    assign src2 = instruction[15:11];
    assign MEM_src1 = src1;
    assign MEM_src2 = src2;
    assign immdediate = instruction[15:0];
    Control_unit control_unit(
        clk, rst
    );
    assign Val1 = MEM_Reg1;
    assign Reg2 = MEM_Reg2;
    assign Val2 = Reg2;
    assign Br_taken = 1'b0;
endmodule