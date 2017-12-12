module EXE_stage (
    input clk,    // Clock
    input rst,  // Reset active high
    input [31:0] Reg2_2, // ST_value
    input [31:0] val2, val1,
    input [3:0] EXE_cmd,
    input [1:0] val1_s, val2_s, ST_value_s,
    input [31:0] ALU_result3, WB_value,
    output [31:0] ST_value_fd,
    output [31:0] ALU_result
);
    wire [31:0] val1_fd, val2_fd;
    ALU _ALU(val1_fd, val2_fd, EXE_cmd, ALU_result);
    MUX_3_1 #(32) val1_MUX(val1_s, val1, ALU_result3, WB_value, val1_fd);
    MUX_3_1 #(32) val2_MUX(val2_s, val2, ALU_result3, WB_value, val2_fd);
    MUX_3_1 #(32) ST_value_MUX(ST_value_s, Reg2_2, ALU_result3, WB_value, ST_value_fd);
endmodule