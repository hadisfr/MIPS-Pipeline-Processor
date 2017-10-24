module Condition_check (
    input [1:0] branch_type,
    input [31:0] MEM_Reg1, MEM_Reg2,
    output reg is_jump
);
    parameter [1:0] BEZ = 0, BNE = 1, JMP = 2;
    always @(*) begin
        is_jump = 0;
        case (branch_type)
            JMP: is_jump = 1;
            BNE: is_jump = MEM_Reg1 != MEM_Reg2;
            BEZ: is_jump = MEM_Reg1 == 0;
            default : is_jump = 0;
        endcase
    end
endmodule