module Adder #(parameter n = 1) (
    input [n-1:0] operand1, operand2,
    output [n:0] result
);
    assign result = operand1 + operand2;
endmodule