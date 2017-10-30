module ALU(
    input signed [31:0] a, b,
    input [3:0] cmd,
    output reg signed [31:0] c
);
    parameter [3:0] ADD = 0, SUB = 2, AND = 4, OR = 5, NOR = 6, XOR = 7, LEFT = 8, SRIGHT = 9, RIGHT = 10;
    always @(*)
        case (cmd)
            AND: c = a & b;
            OR:  c = a | b; 
            NOR: c = ~(a | b);
            XOR: c = a ^ b;
            ADD: c = a + b;
            SUB: c = a - b;
            LEFT: c = a << b;
            SRIGHT: c = a >>> b;
            RIGHT: c = a >> b;
            default: c = 0;
        endcase
endmodule

