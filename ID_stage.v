module ID_stage (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [31:0] instruction,
    input [4:0] dest_WB,
    input [31:0] WB_value_Wb,
    input WB_en_WB,
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
    assign immdediate = instruction[15:0];
    Control_unit control_unit(
        clk, rst
    );
    Register_file #(32) register_file(
            clk, rst, src1, src2, dest_WB, WB_value_Wb, WB_en_WB,
            Val1, Reg2
        );
    assign Val2 = Reg2;
    assign Br_taken = 1'b0;
endmodule