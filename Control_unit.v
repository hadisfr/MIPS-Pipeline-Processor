module Control_unit (
    input [5:0] op_code,
    output reg is_immediate,
    output reg ST_or_BNE,
    output reg is_branch_or_jump,
    output reg [1:0] branch_type,
    output reg [3:0] EXE_cmd,
    output reg MEM_R_en, MEM_W_en, WB_en
);
    parameter [5:0] NOP = 0, ADD = 1, SUB = 3, AND = 5, OR = 6, NOR = 7, XOR = 8, SLA = 9, SLL = 10, SRA = 11, SRL = 12, ADDI = 32, SUBI = 33, LD = 36, ST = 37, BEZ = 40, BNE = 41, JMP = 42;
    parameter [3:0] ALU_ADD = 0, ALU_SUB = 2, ALU_AND = 4, ALU_OR = 5, ALU_NOR = 6, ALU_XOR = 7, ALU_LEFT = 8, ALU_SRIGHT = 9, ALU_RIGHT = 10;
    parameter [1:0] BR_TYPE_BEZ = 0, BR_TYPE_BNE = 1, BR_TYPE_JMP = 2;
    always @(*) begin
        {is_immediate, ST_or_BNE, is_branch_or_jump, branch_type, EXE_cmd, MEM_R_en, MEM_W_en, WB_en} = 0;
        case (op_code)
            NOP: ;
            ADD: begin WB_en = 1; EXE_cmd = ALU_ADD; end
            SUB: begin WB_en = 1; EXE_cmd = ALU_SUB; end
            AND: begin WB_en = 1; EXE_cmd= ALU_AND; end
            OR: begin WB_en = 1; EXE_cmd = ALU_OR; end
            NOR: begin WB_en = 1; EXE_cmd = ALU_NOR; end
            XOR: begin WB_en = 1; EXE_cmd = ALU_XOR; end
            SLA: begin WB_en = 1; EXE_cmd = ALU_LEFT; end
            SLL: begin WB_en = 1; EXE_cmd = ALU_LEFT; end
            SRA: begin WB_en = 1; EXE_cmd = ALU_SRIGHT; end
            SRL: begin WB_en = 1; EXE_cmd = ALU_RIGHT; end
            ADDI: begin WB_en = 1; EXE_cmd = ALU_ADD; is_immediate = 1; end
            SUBI: begin WB_en = 1; EXE_cmd = ALU_SUB; is_immediate = 1; end
            LD: begin WB_en = 1; EXE_cmd = ALU_ADD; is_immediate = 1; MEM_R_en = 1; end
            ST: begin EXE_cmd = ALU_ADD; is_immediate = 1; ST_or_BNE = 1; MEM_W_en = 1; end
            BEZ: begin is_immediate = 1; is_branch_or_jump = 1; branch_type = BR_TYPE_BEZ; end
            BNE: begin is_immediate = 1; ST_or_BNE = 1; is_branch_or_jump = 1; branch_type = BR_TYPE_BNE; end
            JMP: begin is_immediate = 1; is_branch_or_jump = 1; branch_type = BR_TYPE_JMP; end
            default : ;
        endcase
    end
endmodule