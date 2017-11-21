module ID_stage (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [31:0] instruction,
    input [31:0] MEM_Reg1, MEM_Reg2,
    input hazard_detected,
    output [4:0] MEM_src1, MEM_src2,
        MEM_src1_fd, MEM_src2_fd,
    output [4:0] dest,
    output [31:0] Reg2, Val2, Val1,
    output Br_taken_hazard_protected, is_immediate, ST_or_BNE, is_branch_or_jump,
    output [3:0] EXE_cmd_hazard_protected,
    output MEM_R_en_hazard_protected, MEM_W_en_hazard_protected, WB_en_hazard_protected
);
    wire [5:0] op_code;
    wire [4:0] src1, src2;
    wire [15:0] immediate;
    wire [31:0] immediate_extended;
    wire is_jump;
    wire [1:0] branch_type;
    wire [3:0] EXE_cmd;
    wire MEM_R_en, MEM_W_en, WB_en;
    wire Br_taken;
    wire [31:0] MEM_Reg1_fd, MEM_Reg2_fd;
    assign op_code = instruction[31:26];
    assign dest = instruction[25:21];
    assign src1 = instruction[20:16];
    assign src2 = instruction[15:11];
    assign MEM_src1 = src1;
    assign MEM_src1_fd = src1;
    MUX #(5) MEM_src2_fd_MUX(is_immediate, src2, 5'b0, MEM_src2_fd);
    assign immediate = instruction[15:0];
    Control_unit control_unit(
        op_code,
        is_immediate, ST_or_BNE, is_branch_or_jump, branch_type, EXE_cmd, MEM_R_en, MEM_W_en, WB_en
    );
    assign Val1 = MEM_Reg1;
    assign Reg2 = MEM_Reg2;
    assign Br_taken = is_branch_or_jump & is_jump;
	 
    MUX #(5) src2_MUX(ST_or_BNE, src2, dest, MEM_src2);
    Sign_extend #(16) immediate_sign_extend(immediate, immediate_extended);
    MUX #(32) Val2_MUX(is_immediate, MEM_Reg2, immediate_extended, Val2);
    Condition_check condition_check(
        branch_type, MEM_Reg1, MEM_Reg2,
        is_jump
    );

    MUX #(8) hazard_protection(
            hazard_detected,
            {EXE_cmd, MEM_R_en, MEM_W_en, WB_en, Br_taken},
            8'b0,
            {EXE_cmd_hazard_protected, MEM_R_en_hazard_protected, MEM_W_en_hazard_protected, WB_en_hazard_protected, Br_taken_hazard_protected}
        );
	 
endmodule