module IF_stage_reg (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    // input flush,
    input [31:0] PC_in,
    // input [31:0] Instruction_in,
    output reg [31:0] PC
    // output reg [31:0] Instruction
);
    always@(posedge clk)begin
        if(rst)begin
            PC <= 32'b0;
            // Instruction <= 32'b0;
        end
        else begin
            PC <= PC_in;
            // Instruction <= Instruction_in;
        end

    end
endmodule